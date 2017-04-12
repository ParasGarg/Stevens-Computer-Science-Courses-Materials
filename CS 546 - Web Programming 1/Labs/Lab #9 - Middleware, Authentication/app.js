/* express server */
const express = require('express');
const app = express();

/* static */
const static = express.static(__dirname + '/public');
app.use("/public", static);

/* express cookies */ /* connecting to flash */
const flash = require('connect-flash');
const cookieParser = require('cookie-parser');
    
app.use(require('express-session')({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
}));
app.use(flash());
app.use(cookieParser());

/* passport authenticator initialization */
const passport = require('passport');
app.use(passport.initialize());
app.use(passport.session());

/* body parser */
const bodyParser = require("body-parser");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

/* express handlebars configuration */
const exphbs = require("express-handlebars");
app.engine('handlebars', exphbs({ defaultLayout:'main' }));
app.set('view engine', 'handlebars');

/* routing */
const configRoutes = require("./routes");
configRoutes(app);

/* running server on port 3000 */
app.listen(3000, () => {
    console.log("We've now got a server");
    console.log("Your routes will be running on http://localhost:3000");
});