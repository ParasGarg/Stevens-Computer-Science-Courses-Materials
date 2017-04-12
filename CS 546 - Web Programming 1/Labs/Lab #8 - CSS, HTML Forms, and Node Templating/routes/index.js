const checkRoutes = require("./check");

const constructorMethod = (app) => {
    app.use("/", checkRoutes);

    app.use("*", (req, res) => {
        let routes = path.resolve(`static/about.html`);
        res.sendFile(routes)
    });
};

module.exports = constructorMethod;