const express = require('express');
const mysql = require('mysql');
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
const bcrypt = require('bcrypt');
const cors = require('cors');
const cookieParser = require('cookie-parser');
const session = require('express-session');
const Docxtemplater = require('docxtemplater');
const fs = require('fs');
const PizZip = require("pizzip");
const moment = require('moment');
const notifier = require('node-notifier'); 
const nodemailer = require('nodemailer');
const cron = require('cron');
const { exec } = require('child_process');
const axios = require('axios');

const app = express();

// Create MySQL connection pool
const pool = mysql.createPool({
  connectionLimit: 10,
  host: `db4free.net`,
  user: `backend_server`,
  password:'password12345',
  database:'backenddb',
});


// Set up middleware
app.use(bodyParser.json());
app.use(cors({
  origin: 'https://hettrrms.onrender.com', // Replace with your frontend URL
  methods: ['GET', 'POST', 'PUT'],
  credentials: true,
  // You can add more options here if needed
}));

app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
  key: "userId",
  secret: "topsecret",
  resave: false,
  saveUninitialized: false,
  cookie: {
    maxAge: null
  }
}));
app.use(express.static('public'));
app.use(express.json());
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './uploads');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});
const stored = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './records');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});
const store = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './restores');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});
const stor = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './backups');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));
const upload = multer({ storage: storage });

app.use('/images', express.static(path.join(__dirname, 'images')));
app.use('/template', express.static(path.join(__dirname, 'template')));
app.use('/records', express.static(path.join(__dirname, 'records')));
const record = multer({ storage: stored });
app.use('/restores', express.static(path.join(__dirname, 'restores')));
const restore = multer({ storage: store });
app.use('/backups', express.static(path.join(__dirname, 'backups')));
const backup = multer({ storage: stor });

// Configure Nodemailer transporter
const transporter = nodemailer.createTransport({
host:'smtp.gmail.com',
port:587,
secure: false,
  auth: {
    user: 'adrianenunez55@gmail.com', // Update with your email address
    pass: 'wkpqkrodxrqtyvjr', // Update with your email password
  },
});

// Handle POST request for password reset email
app.post('/api/forgot-password', (req, res) => {
  const username = req.body.username;
  const randomPassword = generateRandomPassword(); // Generate a random password

  bcrypt.hash(randomPassword, 10, (err, hashedPassword) => {
    if (err) {
      console.error(err);
      showError('Error hashing the password');
      return;
    }

    const updateQuery = 'UPDATE users SET password = ? WHERE username = ?';
    const updateValues = [hashedPassword, username];

    pool.getConnection((err, connection) => {
      if (err) {
        console.error(err);
        showError('Error connecting to database');
        return;
      }

      connection.query(updateQuery, updateValues, (err, result) => {
        connection.release();

        if (err) {
          console.error(err);
          showError('Error updating password in the database');
          return;
        }

        if (result.affectedRows === 0) {
          showError('User not found');
          return;
        }

        // Fetch user's email address based on the provided username
        const getEmailQuery = 'SELECT email FROM users WHERE username = ?';
        const getEmailValues = [username];

        connection.query(getEmailQuery, getEmailValues, (err, emailResult) => {
          if (err) {
            console.error(err);
            showError('Error fetching user email');
            return;
          }

          if (emailResult.length === 0 || !emailResult[0].email) {
            showError('User email not found');
            return;
          }

          const userEmailAddress = emailResult[0].email;

          // Send password reset email
          const mailOptions = {
            from: 'adrianenunez55@gmail.com', // Update with your email address
            to: userEmailAddress, // Use the user's email address
            subject: 'Password Reset',
            text: `Your new password: ${randomPassword}`,
          };

          transporter.sendMail(mailOptions, (error, info) => {
            if (error) {
              console.error(error);
              showError('Failed to send password reset email');
            } else {
              console.log('Password reset email sent');
              res.status(200).json({ success: true });
            }
          });
        });
      });
    });
  });
});

function generateRandomPassword(length = 8) {       
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()';
  let password = '';

  for (let i = 0; i < length; i++) {
    const randomIndex = Math.floor(Math.random() * characters.length);
    password += characters[randomIndex];
  }

  return password;
}

// Handle POST request
app.post('/api/register', upload.fields([
  { name: 'idImage', maxCount: 1 },
  { name: 'userImage', maxCount: 1 }
]), (req, res) => {
  const firstName = req.body.firstName;
  const lastName = req.body.lastName;
  const email = req.body.email;
  const phoneNumber = req.body.phoneNumber;
  const birthdate = req.body.birthdate;
  const age = req.body.age;
  const gender = req.body.gender;
  const username = req.body.username;
  const password = req.body.password;
  const confirmPassword = req.body.confirmPassword;
  const idImage = req.files.idImage[0].filename;
  const userImage = req.files.userImage[0].filename;

  // Check if passwords match
  if (password !== confirmPassword) {
    showError('Passwords do not match');
    return;
  }

  // Check if username already exists
  const usernameQuery = 'SELECT COUNT(*) AS count FROM users WHERE username = ?';
  const usernameValues = [username];

  pool.getConnection((err, connection) => {
    if (err) {
      console.error(err);
      showError('Error connecting to database');
      return;
    }
    connection.query(usernameQuery, usernameValues, async (err, result) => {
      if (err) {
        connection.release();
        console.error(err);
        showError('Error checking username');
        return;
      }

      if (result[0].count > 0) {
        connection.release();
        res.status(409).json({ error: 'Username already exists' });
        return;
      }
      

      // Hash the password
      const hashedPassword = await bcrypt.hash(password, 10);

      const insertQuery = 'INSERT INTO users (firstName, lastName, email, phoneNumber, birthdate, age, gender, username, password, idImage, userImage) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
      const insertValues = [firstName, lastName, email, phoneNumber, birthdate, age, gender, username, hashedPassword, idImage, userImage];

      connection.query(insertQuery, insertValues, (err, result) => {
        connection.release();

        if (err) {
          console.error(err);
          showError('Error inserting data into database');
          return;
        }

        res.status(200).json({ message: 'User registered successfully' });

      });
    });
  });
});

// For file saving
app.post("/api/generate-record", (req, res) => {
  const userId = req.body.userId;
  const bookingId = req.body.bookingId;
  const name = req.body.name;
  const email = req.body.email;
  const destination = req.body.destination;
  const departureDate = req.body.departureDate;
  const returnDate = req.body.returnDate;
  const numTravelers = req.body.numTravelers;
  const totalPayment = req.body.totalPayment;
  const travelers = req.body.travelers;
  
  const formattedTravelers = JSON.parse(travelers)
  .map((traveler) => `Name: ${traveler.name}Age: ${traveler.age}`)
  .join("\n");

  // Generate the Word file
  const data = {
    userId,
    bookingId,
    name,
    email,
    destination,
    departureDate: moment(departureDate).format('MMMM/DD/YYYY'),
    returnDate: moment(returnDate).format('MMMM/DD/YYYY'),
    numTravelers,
    totalPayment,
    travelers: formattedTravelers,
  };
  const content = fs.readFileSync("https://hettrrms-server.onrender.com/template/template.docx", "binary");
  const zip = new PizZip(content);
  const doc = new Docxtemplater();
  doc.loadZip(zip);
  doc.setData(data);
  doc.render();

  try {
    const outputPath = path.join("template", `${name}-${destination}${bookingId}.docx`);
    const generatedData = doc.getZip().generate({ type: "nodebuffer" });
    fs.writeFileSync(outputPath, generatedData);

    // Save the data to the database
    const query = "INSERT INTO client_records (user_id, file) VALUES (?, ?)";
    const values = [userId, outputPath];
    pool.query(query, values, (error, results) => {
      if (error) {
        console.error("Error saving data to the database:", error);
        res.status(500).json({ error: "Error saving data to the database" });
      } else {
        console.log("Data saved to the database successfully");
        res.json({ message: "Record generated and saved successfully" });
      }
    });
  } catch (error) {
    console.error("Error generating Word file:", error);
    res.status(500).json({ error: "Error generating Word file" });
  }
});

// get all the records 
// Route to fetch the list of generated files
app.get('/api/generated-files', (req, res) => {
  const query = 'SELECT * FROM client_records';
  pool.query(query, (error, results) => {
    if (error) {
      console.error('Error fetching generated files:', error);
      res.status(500).json({ error: 'Error fetching generated files' });
    } else {
      res.json(results);
    }
  });
});


// for login
app.post('/api/login', (req, res) => {
  const username = req.body.username;
  const password = req.body.password;

  const query = 'SELECT * FROM users WHERE username = ?';

  pool.getConnection((err, connection) => {
    if (err) {
      console.error(err);
      showError('Error connecting to database', res);
      return;
    }
    connection.query(query, [username], async (err, results) => {
      if (err) {
        connection.release();
        console.error(err);
        showError('Error retrieving user information', res);
        return;
      }

      if (results.length === 0) {
        connection.release();
        res.json({ error: 'Invalid username or password' });
        return;
      }

      const user = results[0];
      const passwordMatches = await bcrypt.compare(password, user.password);

      if (!passwordMatches) {
        connection.release();
        res.json({ error: 'Invalid username or password' });
        return;
      }

      req.session.userId = user.id;
      req.session.username = user.username;
      req.session.role = user.role;
      req.session.firstName = user.firstName;
      req.session.lastName = user.lastName;
      req.session.email = user.email;
      req.session.phoneNumber = user.phoneNumber;
      req.session.birthdate= user.birthdate;
      req.session.age= user.age;
      req.session.gender= user.gender;
      req.session.userImage = `https://hettrrms-server.onrender.com/uploads/${user.userImage}`;
      console.log("Stored username:", req.session.username);
      console.log("Stored fname:", req.session.firstName);
      console.log("Stored lname:", req.session.lastName);
      connection.release();

      res.json({
        role: user.role,
        userId: user.id,
        username: user.username,
        firstName: user.firstName ,
        lastName:user.lastName,
        email: user.email,
        phoneNumber: user.phoneNumber,
        birthdate: user.birthdate,
        age: user.age,
        gender: user.gender,
        userImage: `https://hettrrms-server.onrender.com/uploads/${user.userImage}`,
      });
    });
  });
});

//update the userImage
app.put('/api/users/:id/image', upload.single('userImage'), (req, res) => {
  const userId = req.params.id;
  const userImage = req.file.filename;

  // Update user image in the database
  const query = 'UPDATE users SET userImage = ? WHERE id = ?';
  const values = [userImage, userId];

  pool.query(query, values, (err, result) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Unable to update user image' });
      return;
    }

    res.status(200).json({ success: true });
  });
});
//update user info
app.put('/api/users/:id', (req, res) => {
  const userId = req.params.id;
  const { firstName, lastName, email, phoneNumber, birthdate, age, gender } = req.body;

  const updateUserQuery = 'UPDATE users SET firstName = ?, lastName = ?, email = ?, phoneNumber = ?, birthdate = ?, age = ?, gender = ? WHERE id = ?';
  const updateUserValues = [firstName, lastName, email, phoneNumber, birthdate, age, gender, userId];

  pool.getConnection((err, connection) => {
    if (err) {
      console.error(err);
      res.status(500).json({ error: 'Error connecting to database' });
      return;
    }

    connection.query(updateUserQuery, updateUserValues, (err, result) => {
      connection.release();

      if (err) {
        console.error(err);
        res.status(500).json({ error: 'Error updating user' });
        return;
      }

      // Return the updated user information
      res.status(200).json({
        id: userId,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        birthdate: birthdate,
        age: age,
        gender: gender,
      });
    });
  });
});
//update user password
app.put('/api/users/:id/password', (req, res) => {
  const userId = req.params.id;
  const { currentPassword, newPassword } = req.body;

  // Fetch the user from the database
  const getUserQuery = 'SELECT * FROM users WHERE id = ?';
  pool.query(getUserQuery, [userId], (error, results) => {
    if (error) {
      console.error(error);
      return res.status(500).json({ error: 'Failed to fetch user data' });
    }

    // Check if the current password matches the user's password
    const user = results[0];
    bcrypt.compare(currentPassword, user.password, (bcryptError, isMatch) => {
      if (bcryptError) {
        console.error(bcryptError);
        return res.status(500).json({ error: 'Failed to compare passwords' });
      }

      if (!isMatch) {
        return res.status(400).json({ error: 'Current password is incorrect' });
      }

      // Hash the new password
      bcrypt.hash(newPassword, 10, (hashError, hashedPassword) => {
        if (hashError) {
          console.error(hashError);
          return res.status(500).json({ error: 'Failed to hash password' });
        }

        // Update the user's password in the database
        const updatePasswordQuery = 'UPDATE users SET password = ? WHERE id = ?';
        pool.query(updatePasswordQuery, [hashedPassword, userId], (updateError) => {
          if (updateError) {
            console.error(updateError);
            return res.status(500).json({ error: 'Failed to update password' });
          }

          return res.status(200).json({ message: 'Password updated successfully' });
        });
      });
    });
  });
});






app.get('/api/logout', (req, res) => {
  req.session.destroy((error) => {
    if (error) {
      console.error(error);
      res.status(500).json({ message: 'Failed to logout' });
    } else {
      res.clearCookie('userId');
      res.status(200).json({ message: 'Logout successful' });
    }
  });
});
//delete user 
app.delete('/api/users/:id', (req, res) => {
  const id = req.params.id;
  pool.query('DELETE FROM users WHERE id = ?', [id], (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Failed to delete user' });
    } else if (results.affectedRows === 0) {
      res.status(404).json({ error: `User with ID ${id} not found` });
    } else {
      res.json({ message: `User with ID ${id} deleted successfully` });
    }
  });
});
//show the users in table 
app.get('/show', (req, res) => {
  pool.query('SELECT * FROM users', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving users');
    } else {
      res.json(results);
    }
  });
});
app.get('/users', (req, res) => {
  pool.query('SELECT COUNT(*) as total_users FROM users', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving users');
    } else {
      res.send(results[0].total_users.toString());
    }
  });
});






//edit user details in table
// Define the API endpoint for updating a user
app.put('/api/users/:id', (req, res) => {
  const id = req.params.id;
  const { firstName, lastName, email, phoneNumber, gender } = req.body;

  // Update the user in the database
  const query = `UPDATE users SET firstName = ?, lastName = ?, email = ?, phoneNumber = ?, gender = ? WHERE id = ?`;
  const values = [firstName, lastName, email, phoneNumber, gender, id];
  pool.query(query, values, (err, result) => {
    if (err) {
      console.error('Error updating user in MySQL database: ', err);
      res.status(500).send('Failed to update user');
      return;
    }
    console.log('User updated in MySQL database');
    res.send({ id, firstName, lastName, email, phoneNumber, gender });
  });
});

//saving Local packages 
app.post('/api/packages', upload.fields([{ name: 'image' }]), (req, res) => {
  const { name, description, price, itinerary } = req.body;

  // Insert package data into MySQL database
  const sql = 'INSERT INTO packages (name, description, price, image, itinerary) VALUES (?, ?, ?, ?, ?)';
  const values = [name, description, price, req.files['image'][0].path, JSON.stringify(itinerary)];

  pool.query(sql, values, (error, result) => {
    if (error) {
      console.log('Error inserting package data:', error);
      res.status(500).json({ error: 'Error inserting package data' });
    } else {
      console.log('Package data inserted successfully');
      const imageUrl = `https://hettrrms-server.onrender.com/uploads/${req.files['image'][0].filename}`;
      res.json({ message: 'Package data inserted successfully', imageUrl });
    }
  });
});

app.get('/api/packages', (req, res) => {
  const sql = 'SELECT id, name, description, price, CONCAT("https://hettrrms-server.onrender.com/", image) as imageUrl, itinerary FROM packages';
  pool.query(sql, (error, results) => {
    if (error) {
      console.log('Error getting packages:', error);
      res.status(500).json({ error: 'Error getting packages' });
    } else {
      res.json(results);
    }
  });
});
//show total Local packages 
app.get('/packages', (req, res) => {
  pool.query('SELECT COUNT(*) as total_packages FROM packages', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving packages');
    } else {
      res.send(results[0].total_packages.toString());
    }
  });
});

//saving National packages 
app.post('/api/national', upload.fields([{ name: 'image' }]), (req, res) => {

  const { name, description, price, itinerary } = req.body;

  // Insert package data into MySQL database
  const sql = 'INSERT INTO national (name, description, price, image, itinerary) VALUES (?, ?, ?, ?, ?)';
  const values = [name, description, price, req.files['image'][0].path, JSON.stringify(itinerary)];

  pool.query(sql, values, (error, result) => {
    if (error) {
      console.log('Error inserting package data:', error);
      res.status(500).json({ error: 'Error inserting package data' });
    } else {
      console.log('Package data inserted successfully');
      const imageUrl = `https://hettrrms-server.onrender.com/uploads/${req.files['image'][0].filename}`;
      res.json({ message: 'National Package data inserted successfully', imageUrl });
    }
  });
});

app.get('/api/national', (req, res) => {
  const sql = 'SELECT id, name, description, price, CONCAT("https://hettrrms-server.onrender.com/", image) as imageUrl, itinerary FROM national';
  pool.query(sql, (error, results) => {
    if (error) {
      console.log('Error getting national packages:', error);
      res.status(500).json({ error: 'Error getting national packages' });
    } else {
      res.json(results);
    }
  });
});
//show total national packages 
app.get('/national', (req, res) => {
  pool.query('SELECT COUNT(*) as total_packages FROM national', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving national');
    } else {
      res.send(results[0].total_packages.toString());
    }
  });
});



//saving International packages 
app.post('/api/international', upload.fields([{ name: 'image' }]), (req, res) => {
  const { name, description, price, itinerary } = req.body;

  // Insert package data into MySQL database
  const sql = 'INSERT INTO international (name, description, price, image, itinerary) VALUES (?, ?, ?, ?, ?)';
  const values = [name, description, price, req.files['image'][0].path, JSON.stringify(itinerary)];

  pool.query(sql, values, (error, result) => {
    if (error) {
      console.log('Error inserting package data:', error);
      res.status(500).json({ error: 'Error inserting package data' });
    } else {
      console.log('Package data inserted successfully');
      const imageUrl = `https://hettrrms-server.onrender.com/uploads/${req.files['image'][0].filename}`;
      res.json({ message: 'International Package data inserted successfully', imageUrl });
    }
  });
});

app.get('/api/international', (req, res) => {
  const sql = 'SELECT id, name, description, price, CONCAT("https://hettrrms-server.onrender.com/", image) as imageUrl, itinerary FROM international';
  pool.query(sql, (error, results) => {
    if (error) {
      console.log('Error getting international packages:', error);
      res.status(500).json({ error: 'Error getting international packages' });
    } else {
      res.json(results);
    }
  });
});
//show total international packages 
app.get('/international', (req, res) => {
  pool.query('SELECT COUNT(*) as total_packages FROM international', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving international');
    } else {
      res.send(results[0].total_packages.toString());
    }
  });
});

//store all the data form of the booking
app.post("/api/bookings", (req, res) => {
  const { userId, name, email, destination, departureDate, returnDate, numTravelers, travelers, totalPayment, needtoPay } = req.body;
  const sql = `INSERT INTO travel_booking (user_id, name1, email, destination, departureDate, returnDate, numTravelers, travelers, totalPayment, needtoPay) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`;
  const values = [userId, name, email, destination, departureDate, returnDate, numTravelers, JSON.stringify(travelers), totalPayment, needtoPay];

  pool.query(sql, values, (err, result) => {
    if (err) {
      console.error("Error saving booking to database: ", err);
      res.status(500).json({ message: "Failed to save booking" });
    } else {
      console.log("Booking saved to database: ", result);
      res.status(200).json({ message: "Booking saved successfully" });
      const notificationMsg = `New booking made by ${name} for ${destination}`;

      const query = `INSERT INTO notifications (message) VALUES ('${notificationMsg}')`;
      pool.query(query, (error, result) => {
        if (error) {
          console.error(error);
        } else {
          console.log(`New notification added: ${notificationMsg}`);
          const apiKey = '6ef90c407484a0db17487a435aed6a1e613b97d5';
          const message = `New booking made by ${name} for ${destination}`;
          const phoneNumber = '+639273797184'; 
          const apiEndpoint = `https://sms.teamssprogram.com/api/send?key=${apiKey}&phone=${encodeURIComponent(phoneNumber)}&message=${encodeURIComponent(message)}&device=350&sim=2&priority=1`;
          sendSMS(apiEndpoint);
        }
      });
    }
  });
});
function sendSMS(apiEndpoint) {
 
  return axios.post(apiEndpoint)
    .then(response => {
      console.log('Message sent successfully.');
      console.log('Response:', response.data);
    })
    .catch(error => {
      console.error('Error sending message:', error.response.data);
    });
}
app.get('/api/bookings', (req, res) => {
  const status = req.query.status || '';
  const sql = `SELECT * FROM travel_booking WHERE status = '${status}'`;
  pool.query(sql, (err, result) => {
    if (err) {
      console.error('Error fetching bookings from database: ', err);
      res.status(500).json({ message: 'Failed to fetch bookings' });
    } else {
      console.log('Bookings fetched from database: ', result);
      const bookings = result.map(booking => {
        const travelers = JSON.parse(booking.travelers);
        return { ...booking, travelers };
      });
      res.status(200).json({ bookings });
    }
  });
});

//count of all pending booking to be Accept or Decline 
app.get('/bookings/count', (req, res) => {
  const status = req.query.status || 'pending'; 
  const sql = `SELECT COUNT(*) AS count FROM travel_booking WHERE status = ?`;
  pool.query(sql, [status], (err, result) => {
    if (err) {
      console.error("Error fetching count of pending bookings: ", err);
      res.status(500).json({ message: "Failed to fetch count of pending bookings" });
    } else {
      res.status(200).json({ count: result[0].count });
    }
  });
});



//accept the booking 
app.post('/api/bookings/:bookingId/accept', (req, res) => {
  const bookingId = req.params.bookingId;

  pool.query(
    `UPDATE travel_booking SET status = 'accepted' WHERE id = ?`,
    [bookingId],
    (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
      } else if (results.affectedRows === 0) {
        res.status(404).send('Booking not found');
      } else {
        // Get the booking details
        pool.query(
          `SELECT * FROM travel_booking WHERE id = ?`,
          [bookingId],
          (error, results) => {
            if (error) {  
              console.error(error);
              res.status(500).send('Internal Server Error');
            } else if (results.length === 0) {
              res.status(404).send('Booking not found');
            } else {
              const booking = results[0];
              const userId = booking.user_id;
              const message = `Your booking for travel to ${booking.destination} has been accepted. Please settle your payment.`;

              // Insert a new notification into user_notification table
              pool.query(
                `INSERT INTO user_notification (user_id, message) VALUES (?, ?)`,
                [userId, message],
                (error, results) => {
                  if (error) {
                    console.error(error);
                    res.status(500).send('Internal Server Error');
                  } else {
                    res.sendStatus(204);
                   
                   // Fetch the user's phone number
                   pool.query(
                    `SELECT phoneNumber FROM users WHERE id = ?`,
                    [userId],
                    (error, results) => {
                      if (error) {
                        console.error(error);
                      } else if (results.length === 0) {
                        console.log('User not found');
                      } else {
                        const apiKey = '6ef90c407484a0db17487a435aed6a1e613b97d5';
                        const phoneNumber = results[0].phoneNumber;
                        const apiEndpoint = `https://sms.teamssprogram.com/api/send?key=${apiKey}&phone=${encodeURIComponent(phoneNumber)}&message=${encodeURIComponent(message)}&device=350&sim=2&priority=1`;
                        sendSMS(apiEndpoint);
                      }
                    }
                  );
                  }
                }
              );
            }
          }
        );
      }
    }
  );
});

// Define the endpoint for declining a booking
app.post('/api/bookings/:bookingId/decline', (req, res) => {
  const bookingId = req.params.bookingId;

  pool.query(
    `UPDATE travel_booking SET status = 'declined' WHERE id = ?`,
    [bookingId],
    (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
      } else if (results.affectedRows === 0) {
        res.status(404).send('Booking not found');
      } else {
        // Get the booking details
        pool.query(
          `SELECT * FROM travel_booking WHERE id = ?`,
          [bookingId],
          (error, results) => {
            if (error) {
              console.error(error);
              res.status(500).send('Internal Server Error');
            } else if (results.length === 0) {
              res.status(404).send('Booking not found');
            } else {
              const booking = results[0];
              const userId = booking.user_id;
              const message = `Your booking for travel to ${booking.destination} has been declined.`;

              // Insert a new notification into user_notification table
              pool.query(
                `INSERT INTO user_notification (user_id, message) VALUES (?, ?)`,
                [userId, message],
                (error, results) => {
                  if (error) {
                    console.error(error);
                    res.status(500).send('Internal Server Error');
                  } else {
                    res.sendStatus(204);
                    pool.query(
                      `SELECT phoneNumber FROM users WHERE id = ?`,
                      [userId],
                      (error, results) => {
                        if (error) {
                          console.error(error);
                        } else if (results.length === 0) {
                          console.log('User not found');
                        } else {
                          const apiKey = '6ef90c407484a0db17487a435aed6a1e613b97d5';
                          const phoneNumber = results[0].phoneNumber;
                          const apiEndpoint = `https://sms.teamssprogram.com/api/send?key=${apiKey}&phone=${encodeURIComponent(phoneNumber)}&message=${encodeURIComponent(message)}&device=350&sim=2&priority=1`;
                          sendSMS(apiEndpoint);
                        }
                      }
                    );
                  }
                }
              );
            }
          }
        );
      }
    }
  );
});

// for admin notification
app.get('/api/notifications', (req, res) => {
  const query = 'SELECT * FROM notifications ORDER BY created_at DESC';
  pool.query(query, (error, result) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    } else {
      res.json(result);
    }
  });
});

app.get('/api/notifications/:userId', (req, res) => {
  const userId = req.params.userId;
  
  pool.query(
    `SELECT * FROM user_notification WHERE user_id = ? ORDER BY created_at DESC`,
    [userId],
    (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
      } else {  
        res.json(results);
      } 
    }
  );
});

app.get('/api/bookings/:userId', (req, res) => {
  const userId = req.params.userId;
  const sql = `SELECT * FROM travel_booking WHERE user_id = ? ORDER BY id DESC`;
  pool.query(sql, [userId], (err, result) => {
    if (err) {
      console.error("Error retrieving bookings from database: ", err);
      res.status(500).json({ message: "Failed to retrieve bookings" });
    } else {
      console.log("Bookings retrieved from database: ", result);
      res.status(200).json({ bookings: result });
    }
  });
});
app.post('/submit-payment-proof', upload.fields([{ name: 'paymentProof' }]), (req, res) => {
  const { bookingId, userId, name, email, destination, departureDate, returnDate, numTravelers, travelers, totalPayment, needtoPay, paymentAmount } = req.body;
  const newNeedtoPay = needtoPay - paymentAmount;

  // Insert into payment_proof table
  pool.query(
    'INSERT INTO payment_proof (booking_id, user_id, name, email, destination, departure_date, return_date, num_travelers, travelers, total_payment, needtoPay, amountpaid, payment_proof_path) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
    [bookingId, userId, name, email, destination, new Date(departureDate), new Date(returnDate), numTravelers, JSON.parse(travelers), totalPayment, newNeedtoPay, paymentAmount, req.files['paymentProof'][0].path],
    (error, results) => {
      if (error) {
        console.error(error);
        res.status(500).json({ error: 'Internal server error' });
        return;
      }

      pool.query(
        'UPDATE travel_booking SET needtoPay = ? WHERE id = ?',
        [newNeedtoPay, bookingId],
        (error, results) => {
          if (error) {
            console.error(error);
            res.status(500).json({ error: 'Internal server error' });
            return;
          }

          if (results.affectedRows === 0) {
            res.status(404).json({ error: 'Booking not found' });
            return;
          }

          pool.getConnection((error, connection) => {
            if (error) {
              console.error(error);
              res.status(500).json({ error: 'Internal server error' });
              return;
            }

            connection.beginTransaction((error) => {
              if (error) {
                console.error(error);
                res.status(500).json({ error: 'Internal server error' });
                return;
              }

              const scheduleTitle = `${name} - ${destination}`;

              // Check if reservation already exists for the bookingId
              connection.query(
                'SELECT * FROM reservation WHERE booking_id = ?',
                [bookingId],
                (error, results) => {
                  if (error) {
                    console.error(error);
                    connection.rollback(() => {
                      connection.release();
                      res.status(500).json({ error: 'Internal server error' });
                    });
                    return;
                  }

                  if (results.length > 0) {
                    // Reservation already exists, rollback transaction
                    connection.rollback(() => {
                      connection.release();
                      res.status(200).json({ message: 'Payment proof submitted' });
                    });
                    return;
                  }

                  // Insert into reservation table
                  connection.query(
                    'INSERT INTO reservation (booking_id, user_id, name, email, destination, departure_date, return_date, num_travelers, travelers, total_payment) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
                    [bookingId, userId, name, email, destination, new Date(departureDate), new Date(returnDate), numTravelers, JSON.parse(travelers), totalPayment],
                    (error, result) => {
                      if (error) {
                        console.error(error);
                        connection.rollback(() => {
                          connection.release();
                          res.status(500).json({ error: 'Internal server error' });
                        });
                        return;
                      }

                      // Insert into schedule table
                      connection.query(
                        'INSERT INTO schedule (booking_id, title, start, end) VALUES (?, ?, ?, ?)',
                        [bookingId, scheduleTitle, new Date(departureDate), new Date(returnDate)],
                        (error, result) => {
                          if (error) {
                            console.error(error);
                            connection.rollback(() => {
                              connection.release();
                              res.status(500).json({ error: 'Internal server error' });
                            });
                            return;
                          }

                          connection.commit((error) => {
                            if (error) {
                              console.error(error);
                              connection.rollback(() => {
                                connection.release();
                                res.status(500).json({ error: 'Internal server error' });
                              });
                              return;
                            }

                            connection.release();
                            res.status(200).json({ message: 'Payment proof submitted successfully' });
                          });
                        }
                      );
                    }
                  );
                }
              );
            });
          });
        }
      );
    }
  );
});
app.get('/api/paymentproof/:userId', (req, res) => {
  const userId = req.params.userId;
  const sql = `SELECT * FROM payment_proof WHERE user_id = ? ORDER BY submitted_at DESC`;
  pool.query(sql, [userId], (err, result) => {
    if (err) {
      console.error("Error retrieving payment details for bookings from database: ", err);
      res.status(500).json({ message: "Failed to retrieve payment details for bookings" });
    } else {
      console.log("payment proof for bookings retrieved from database: ", result);
      res.status(200).json({ proofs: result });
    }
  });
});

app.get('/api/reservations/:userId', (req, res) => {
  const userId = req.params.userId;
  const sql = `SELECT * FROM reservation WHERE user_id = ? ORDER BY submitted_at DESC`;
  pool.query(sql, [userId], (err, result) => {
    if (err) {
      console.error("Error retrieving payment details for bookings from database: ", err);
      res.status(500).json({ message: "Failed to retrieve payment details for bookings" });
    } else {
      console.log("payment proof for bookings retrieved from database: ", result);
      res.status(200).json({ proofs: result });
    }
  });
});
app.post("/api/events", (req, res) => {
  const { title, start, end } = req.body;

  const sql = "INSERT INTO schedule (title, start, end) VALUES (?, ?, ?)";
  pool.query(sql, [title, start, end], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Error adding event." });
    }

    // Create a Windows reminder if the current date is equal to the start date
    const currentDate = moment().format("YYYY-MM-DD");
    if (currentDate === start.split("T")[0]) {
      const reminderTitle = "Event Reminder";
      const reminderMessage = `Event "${title}" is starting today!`;

      notifier.notify({
        title: reminderTitle,
        message: reminderMessage,
      });
    }

    res.status(201).json({ message: "Event added successfully." });
  });
});

app.get("/api/events", (req, res) => {
  const sql = "SELECT * FROM schedule";
  pool.query(sql, (err, results) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ message: "Error retrieving events." });
    }
console.log({schedule:results});
    res.status(200).json(results);
  });
});

app.put('/api/events/:id', (req, res) => {
  const { id } = req.params;
  const { title, start, end } = req.body;
  const sql = 'UPDATE schedule SET title = ?, start = ?, end = ? WHERE id = ?';

  pool.query(sql, [title, start, end, id], (err) => {
    if (err) {
      throw err;
    }

    res.json({ message: 'Event updated successfully.' });
  });
});

app.delete('/api/events/:id', (req, res) => {
  const { id } = req.params;
  const sql = 'DELETE FROM schedule WHERE id = ?';

  pool.query(sql, [id], (err) => {
    if (err) {
      throw err;
    }

    res.json({ message: 'Event deleted successfully.' });
  });
});

//show total reservation
app.get('/reservation', (req, res) => {
  pool.query('SELECT COUNT(*) as total_reservation FROM reservation', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error retrieving reservation');
    } else {
      res.send(results[0].total_reservation.toString());
    }
  });
});
app.get('/allreservations', (req, res) => {
  pool.query('SELECT * FROM reservation ', (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    } else {
      res.status(200).json(results);
    }
  });
});

app.get('/allproof', (req, res) => {
  pool.query('SELECT *, DATE_FORMAT(submitted_at, "%Y-%m-%d %H:%i:%s") AS formatted_submitted_at FROM payment_proof ORDER BY submitted_at DESC', (error, results) => {
    if (error) {
      console.error(error);
      res.status(500).json({ error: 'Internal server error' });
    } else {
      res.status(200).json(results);
    }
  });
});

//request change date
app.post('/api/request-date-change', (req, res) => {
  const { userId, bookingId, departureDate, returnDate } = req.body;
  const createdAt = new Date();

  const sql = `INSERT INTO request_change_date (user_id, booking_id, departure_date, return_date, created_at) 
               VALUES (?, ?, ?, ?, ?)`;

  pool.query(sql, [userId, bookingId, departureDate, returnDate, createdAt], (err, result) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ error: 'Internal Server Error' });
    } else {
      const message = `A request change date has been submitted in booking ID: ${bookingId} by user ID: ${userId}`;
      pool.query(
        `INSERT INTO notifications (message) VALUES (?)`,
        [message],
        (error, results) => {
          if (error) {
            console.error(error);
            res.status(500).send('Internal Server Error');
          } else {
            res.json({ message: 'Request submitted successfully' });
          }
        }
      );
    }
  });
});



app.get('/api/requests', (req, res) => {
  const status = req.query.request_status || '';
  const sql = `SELECT * FROM request_change_date WHERE request_status = '${status}'`;
  pool.query(sql, (err, result) => {
    if (err) {
      console.error('Error fetching requests from database: ', err);
      res.status(500).json({ message: 'Failed to fetch requests' });
    } else {
      console.log('Requests fetched from database: ', result);
      res.json({ requests: result });
    }
  });
});

// Updating the request for accept and decline
app.post('/api/update-booking-date', (req, res) => {
  const { bookingId, departureDate, returnDate} = req.body;
  const sql = 'UPDATE travel_booking SET departureDate = ?, returnDate = ? WHERE id = ?';
  const params = [departureDate, returnDate, bookingId];

  pool.query(sql, params, (error, results) => {
    if (error) {
      console.error('Error updating booking date:', error);
      res.status(500).json({ error: 'Failed to update booking date.' });
    } else {
     const status='accepted';
     pool.query('UPDATE request_change_date SET request_status = ? WHERE booking_id = ?', [status, bookingId], (error, results) => {
      if (error){
        console.error('Error updating request status:', error);
        res.status(500).json({ error: 'Failed to update request status.' });
      }
      else{
        pool.query('UPDATE reservation SET departure_date = ?, return_date = ? WHERE booking_id = ?', [departureDate, returnDate, bookingId], (error, results) =>{
          if (error) {
            console.error('Error updating reservation date:', error);
            res.status(500).json({ error: 'Failed to update reservation date.' });
          } else {
            pool.query('UPDATE schedule SET start = ?, end = ? WHERE booking_id = ?', [departureDate, returnDate, bookingId], (error, results) =>{
              if (error){
                console.error('Error updating schedule:', error);
                res.status(500).json({ error: 'Failed to update schedule.' });
              } 
              else{
                const message= 'Your request has been accepted your new departure date is : ${departureDate} and return date is: ${returnDate}';
                pool.query('INSERT INTO user_notification (message) VALUES (?)',[message], (error, results) => {
                  if (error){
                    console.error('Error inserting notifications:', error);
                    res.status(500).json({ error: 'Failed to insert the notification.' });
                  }
                  else {
                    res.status(200).json({ message: 'Booking date updated successfully.' });
                  }
                });
              }
            });
          }
        });
      }
     });
    }
  });
});



app.post('/api/decline-request/:requestId', (req, res) => {
  const requestId = req.params.requestId;
  
  const sql = `UPDATE request_change_date SET request_status = 'declined' WHERE id = ?`;
  
  pool.query(sql, [requestId], (error, results) => {
    if (error) {
      console.error('Error declining request:', error);
      res.status(500).json({ message: 'Failed to decline request.' });
    } else {
      const message= 'Your request has been declined';
      pool.query('INSERT INTO user_notification (message) VALUES (?)',[message], (error, results) => {
        if (error){
          console.error('Error inserting notifications:', error);
          res.status(500).json({ error: 'Failed to insert the notification.' });
        }
        else {
          res.status(200).json({ message: 'Request declined successfully.' });
        }
      });
    }
  });
});


app.get('/requests/count', (req, res) => {
  const status = req.query.request_status || 'pending'; 
  const sql = `SELECT COUNT(*) AS count FROM request_change_date WHERE request_status = ?`;
  pool.query(sql, [status], (err, result) => {
    if (err) {
      console.error("Error fetching count of pending requests: ", err);
      res.status(500).json({ message: "Failed to fetch count of pending requests" });
    } else {
      res.status(200).json({ count: result[0].count });
    }
  });
});



//businesspartner
app.post('/api/uploadRecord', record.single('file'), (req, res) => {
  const filePath = req.file.path; // Get the file path of the uploaded file

  res.json({ success: true, filePath: filePath });
});


app.post('/api/saveRecord', (req, res) => {
  const { filePath } = req.body;
  const query = 'INSERT INTO business_partner_records (fileName) VALUES (?)';
  pool.query(query, [filePath], (err, results) => {
    if (err) {
      console.error('Error executing MySQL query:', err);
      res.status(500).json({ error: 'Failed to save the record' });
      return;
    }
    res.json({ success: true });
  });
});

app.get('/api/business-partner-files', (req, res) => {
  const query = 'SELECT * FROM business_partner_records';
  pool.query(query, (error, results) => {
    if (error) {
      console.error('Error fetching business partner files:', error);
      res.status(500).json({ error: 'Error fetching business partner files' });
    } else {
      res.json(results);
    }
  });
});

// Endpoint to download a file
app.get('/api/downloadRecord', (req, res) => {
  const fileName = req.query.filePath;

  // Check if the file exists
  fs.access(fileName, fs.constants.F_OK, (err) => {
    if (err) {
      console.error('File does not exist:', fileName);
      res.status(404).json({ error: 'File not found' });
      return;
    }

    // Stream the file to the response
    const fileStream = fs.createReadStream(fileName);
    fileStream.pipe(res);
  });
});

app.get('/backup', (req, res) => {
  const backupFileName = `backup_${new Date().toISOString().replace(/:/g, '-').replace(/\./g, '-')}.sql`;
  const backupFilePath = path.join(__dirname, 'backups', backupFileName).replace(/\\/g, '/');

  const mysqlConfig = {
    connectionLimit: 100,
    host: `db4free.net`,
    port: 3306,
    user: `backend_server`,
    password:'password12345',
    database:'backenddb',
  };

  const backupProcess = `mysqldump --user=${mysqlConfig.user} --password=${mysqlConfig.password} --host=${mysqlConfig.host} ${mysqlConfig.database} > "${backupFilePath}"`;

  exec(backupProcess, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ success: false });
    }

    console.log(`Backup created: ${backupFileName}`);
    return res.json({ success: true });
  });
});


// Modify the restore API endpoint
app.post('/restore', restore.single('file'), (req, res) => {
  const { path: filePath } = req.file;

  const mysqlConfig = {
    connectionLimit: 100,
    host: `db4free.net`,
    port: 3306,
    user: `backend_server`,
    password:'password12345',
    database:'backenddb',
  };

  const restoreProcess = `mysql --user=${mysqlConfig.user} --password=${mysqlConfig.password} --host=${mysqlConfig.host} ${mysqlConfig.database} < ${filePath}`;

  exec(restoreProcess, (err) => {
    if (err) {
      console.error(err);
      return res.status(500).json({ success: false });
    }

    console.log('Database restored');
    return res.json({ success: true });
  });
});


// Schedule automatic backups on the 28th day of the month
const backupJob = new cron.CronJob('0 0 0 28 * *', () => {
  const backupFileName = `backup_${new Date().toISOString()}.sql`;
  const backupFilePath = `https://hettrrms-server.onrender.com/backups/${backupFileName}`;

  const backupProcess = `mysqldump --user=${pool.user} --password=${pool.password} --host=${pool.host} ${pool.database} > ${backupFilePath}`;

  pool.query(backupProcess, (err) => {
    if (err) {
      console.error(err);
      return;
    }

    console.log(`Automated backup created: ${backupFileName}`);
  });
});

backupJob.start();
// Start the server
app.listen(3000, () => {
  console.log('Server started on port 3000');
});

// Function to display error message
function showError(message) {
  console.error('Error: ' + message);
}