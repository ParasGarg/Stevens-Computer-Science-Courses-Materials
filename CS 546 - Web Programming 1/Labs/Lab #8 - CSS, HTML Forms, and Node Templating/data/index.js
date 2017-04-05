const checkData = require('./check');

let checkMethod = (app) => {
    app.use("/", checkData);
};

module.exports = {
    check: require("./check")
};