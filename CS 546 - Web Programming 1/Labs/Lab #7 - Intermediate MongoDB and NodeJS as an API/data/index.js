const recipeMethods = require('./recipes');
const commentMethods = require('./comments');

let constructorMethod = (app) => {
    app.use("/recipes", recipeMethods);
    app.use("/comments", commentMethods);
};

module.exports = {
    recipes: require("./recipes"),
    comments: require("./comments")
};