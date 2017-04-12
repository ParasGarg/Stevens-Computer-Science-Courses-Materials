const express = require('express');
const router = express.Router();
const data = require('../data');
const usersData = data.users;
const flash = require('connect-flash');

/* authentication using passport */
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

passport.use(new LocalStrategy((username, password, done) => {
    usersData.getUserByUsername(username).then((userInfo) => {
        usersData.compareCredentials(password, userInfo.hashedPassword).then(() => {
            return done(null, userInfo);
        }, (err) => {
            return done(null, false, { message: err });
        });
    }, (err) => {
        return done(null, false, { message: err });
    });
}));

// user serializer or deserializer for maintaining cookies and sessions
passport.serializeUser(function(user, done) {               // user is receiving all user information from above
 // req.flash('info');
  done(null, user._id);
});

passport.deserializeUser(function(userId, done) {           // getting user id from above
  usersData.getUserById(userId).then((user) => {
    done(null, user);
  }, (err) => {
      
    done(null, false, { message: err });
  });
});

// route for home page
router.get('/', ensureAuthenticated, (req, res) => {
    req.flash('flashValue');

    if (req.session.flash["error"] === undefined) {
        res.render('login/form', { error: req.session.flash.error });   
    } else {
        res.render('login/form', { error: req.session.flash.error.slice(-1)[0] });
    }
});

function ensureAuthenticated(req, res, next) {
    if (req.isAuthenticated()) {
        res.redirect('/private');
    } else {
        return next();
    }
}

// routing for login form submit
router.post('/login',
    passport.authenticate('local', { 
        successRedirect: '/private', 
        failureRedirect: '/', 
        failureFlash: true 
    })
);

// route for private page
router.get('/private', isLoggedIn, (req, res) => {
    res.render('login/private', { user: req.user });
});

function isLoggedIn(req, res, next) {
    if (req.isAuthenticated()) {
        next();
    } else {
        res.status(401).send("Unauthorized Access. Access Denied. Login first.");
    }
}

module.exports = router;