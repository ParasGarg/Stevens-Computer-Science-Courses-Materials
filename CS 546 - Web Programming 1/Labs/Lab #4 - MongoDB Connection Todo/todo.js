const uuid = require("uuid");
const mongodbCollection = require("./mongodbCollection");
const todoItems = mongodbCollection.todoItems;

let exportedToDoMethods = {

    // createTask(title, description) method
    createTask(title, description) {
        // error validation
        if (!title) {
            return Promise.reject("Enter the valid title");
        } else if (!description) {
            return Promise.reject("Enter the valid description");            
        }

        return todoItems().then((todoItemsCollection) => {
            var newItem = {
                _id: uuid.v4(),
                title: title,
                description: description,
                completed: false,
                completedAt: null
            }

            return todoItemsCollection.insertOne(newItem)
                .then((newTaskInformation) => {
                    return newTaskInformation.insertedId;
                })
                .then((newId) => {
                    return this.getTask(newId);
                });
        });
    },

    //getAllTasks() method
    getAllTasks() {
        return todoItems().then((todoItemsCollection) => {
            return todoItemsCollection.find({}).toArray();
        });
    },

    // getTask(id) method
    getTask(id) {
        // error validation
        if (!id) {
            return Promise.reject("Enter the valid id");
        }

        return todoItems().then((todoItemsCollection) => {
            return todoItemsCollection.findOne({ _id:id });
        }, (findError) => {
            reject(`No such item found having ${id}`);
        });
    },

    // completeTask(taskId) method
    completeTask(taskId) {
        // error validation
        if (!taskId) {
            return Promise.reject("Enter the valid id");
        }

        return todoItems().then((todoItemsCollection) => {
            var updateItem = {
                $set: {
                    completed: true,
                    completedAt: new Date()
                }
            };

            return todoItemsCollection.updateOne({ _id: taskId }, updateItem)
                .then(() => {
                    return this.getTask(taskId);
                }, (updateError) => {
                    Promise.reject(`No such item have id(${taskId}) found to update`);
                });
        });
    },

    // removeTask(id) method
    removeTask(id) {
        // error validation
        if (!id) {
            return Promise.reject("Enter the valid id");
        }

        return todoItems().then((todoItemsCollection) => {
            return todoItemsCollection.removeOne({ _id:id })
                .then((removeInformation) => {
                    if (removeInformation.deletedCount === 0) {
                        throw `Could not remove item having ${id}`;
                    }
                });
        });
    }
}

module.exports = exportedToDoMethods;