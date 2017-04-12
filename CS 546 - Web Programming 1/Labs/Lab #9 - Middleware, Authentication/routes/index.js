const usersRoutes = require("./users");

const  usersMethod = (app) => {
    app.use("/", usersRoutes);

    app.use("*", (req, res) => {
        res.status(404).json({ error: 404 });
    });
};

module.exports = usersMethod;