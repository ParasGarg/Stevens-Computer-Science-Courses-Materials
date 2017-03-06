const dbConnection = require("./mongodbConnection");

let getCollectionFn = (collection) => {
    let _col = undefined;

    return () => {
        if (!_col) {
            _col = dbConnection().then(db => {
                return db.collection(collection);
            });
        }

        return _col;
    }
}

/* collection list: */
module.exports = {
    todoItems: getCollectionFn("todoItems")
};