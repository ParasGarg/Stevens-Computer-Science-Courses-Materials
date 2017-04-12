const usersData = require('./users');

let usersMethod = (app) => {
    app.use("/", usersData);
};

module.exports = {
    users: require("./users")
};