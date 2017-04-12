const recipesRoutes = require("./recipes");
const commentsRoutes = require("./comments");

const constructorMethod = (app) => {
    // routing
    app.use("/recipes", recipesRoutes);
    app.use("/comments", commentsRoutes);

    // error checking
    app.use("/$/", (req, res) => {
        res.status(200).send("This is the Root Page of http://localhost:3000");
    })

    app.use("*", (req, res) => {
        res.status(404).send("Error 404. Page Not Found");
    });
};

module.exports = constructorMethod;