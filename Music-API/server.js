
var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var morgan = require('morgan');
var mongoose = require('mongoose');
var Mongo = require('mongodb');
var passport = require('passport');
var config = require('./config/database');
var User = require('./app/Models/user');
var port = process.env.PORT || 8080;
var potAuth = process.env;
var jwt = require('jwt-simple');


app.use(bodyParser.urlencoded({extended : false}));
app.use(bodyParser.json());

app.use(morgan('dev'));

app.use(passport.initialize());

app.get('/',function(req,res){
	res.send('Hello! The API is at http://localhost:' + process.env + '/api');
});

mongoose.Promise = global.Promise;

mongoose.connect(config.database);
 var db = mongoose.connection;
 db.on('error', console.error.bind(console, 'MongoDB connection error:'));
 console.log(db);
// pass passport for configuration
require('./config/passport')(passport);
 
// bundle our routes
var apiRoutes = express.Router();
 
// create a new user account (POST http://localhost:8080/api/signup)
apiRoutes.post('/signup', function(req, res) {
	var isProfilePicturePresent,
		pPicture;
	if (!req.body.pPicture) {isProfilePicturePresent = false; pPicture = '';}
	else {isProfilePicturePresent = true; pPicture = req.body.pPicture }
   {
    var newUser = new User({
      firstName: req.body.fname,
      lastName : req.body.lname,
      email : req.body.email,
      password: req.body.password,
      isProfilePicturePresent: isProfilePicturePresent,
      profilePicture : pPicture
    });
    // save the user
    newUser.save(function(err) {
      if (err) {
        return res.json({success: false, msg: err});
      }
      res.json({success: true, msg: 'Successful created new user.'});
    });
  }
});
 

apiRoutes.post('/login', function(req, res) {
  User.findOne({
    email: req.body.email
  }, function(err, user) {
    if (err) throw err;
 
    if (!user) {
      res.send({success: false, msg: 'Authentication failed. User not found.'});
    } else {
      // check if password matches
      user.comparePassword(req.body.password, function (err, isMatch) {
        if (isMatch && !err) {
          // if user is found and password is right create a token
          var token = jwt.encode(user, config.secret);
          // return the information including token as JSON
          res.json({success: true, token: 'JWT ' + token});
        } else {
          res.send({success: false, msg: 'Authentication failed. Wrong password.'});
        }
      });
    }
  });
});


apiRoutes.get('/me/', passport.authenticate('jwt', { session: false}), function(req, res) {
  var token = getToken(req.headers);
  if (token) {
    var decoded = jwt.decode(token, config.secret);
    User.findOne({
      email: decoded.email
    }, function(err, user) {
        if (err) throw err;
 
        if (!user) {
          return res.status(403).send({success: false, msg: 'Authentication failed. User not found.'});
        } else {
          user = user.toObject();
          delete user['password'];
          res.json({success: true, user : user});
        }
    });
  } else {
    return res.status(403).send({success: false, msg: 'No token provided.'});
  }
});
 
getToken = function (headers) {
  if (headers && headers.authorization) {
    var parted = headers.authorization.split(' ');
    if (parted.length === 2) {
      return parted[1];
    } else {
      return null;
    }
  } else {
    return null;
  }
};


// connect the api routes under /api/*
app.use('/api', apiRoutes);

app.listen(port);
console.log('There will be dragons at ' + process.env);