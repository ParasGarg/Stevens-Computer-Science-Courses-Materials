const biographyRoutes = require("./biography");

const constructorMethod = (app) => {
    app.use("/", biographyRoutes);

    app.use("*", (req, res) => {
        res.sendStatus(404);
    });
};

module.exports = constructorMethod;