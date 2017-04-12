const connection = require("./mongodbConnection.js");
const todo = require('./todo.js')

// creating the first task
todo.createTask("Ponder Dinosaurs", "Has Anyone Really Been Far Even as Decided to Use Even Go Want to do Look More Like?")
    
    // logging the first task and creating the second task
    .then((firstTask) => {           
        console.log("First task created successfully!");
        console.log(firstTask);  
        return todo.createTask("Play Pokemon with Twitch TV", "Should we revive Helix?");                       
    }, (firstTaskError) => {
        console.log(firstTaskError);
    })
   
    // logging the second task and getting all tasks
    .then((secondTask) => {           
        console.log("\nSecond task created successfully!");
        console.log(secondTask);                        
        return todo.getAllTasks();      
    }, (secondTaskError) => {
        console.log(secondTaskError);
    })

    // logging getting all the tasks
    .then((allTasks) => {           
        console.log("\nAll the tasks are logged!");
        console.log(allTasks);
        return allTasks;                        
    }, (allTasksError) => {
        console.log(allTasksError);
    })

    // removing first task and getting all remaining tasks
    .then((allTasks) => {
        console.log("\nTask that is to be removed");
        console.log(allTasks[0]);
        todo.removeTask(allTasks[0]._id);
        console.log("Task removed successfully!");        
        return todo.getAllTasks();      
    }, (allTasksError) => {
        console.log(allTasksError);
    })

    // logging getting all the tasks left
    .then((allTasks) => {           
        console.log("\nAll the tasks after deletion of first task");
        console.log(allTasks);
        return allTasks;                        
    }, (allTasksError) => {
        console.log(allTasksError);
    })

    // completing the remaining task
    .then((allTasks) => {
        for(var i = 0; i < allTasks.length; i++) {
            todo.completeTask(allTasks[i]._id);
        }
        console.log(`\nAll the ${allTasks.length} task(s) completed`);
        return allTasks;
    }, (allTasksError) => {
        console.log(allTasksError);
    })

    // logging all the remaining task after completing them
    .then((allTasks) => {
        for (let i = 0; i < allTasks.length; i++) {
            todo.getTask(allTasks[i]._id)
                .then((task) => {
                    console.log(`\nItem ${i+1}`);
                    console.log(task);
                }, (taskError) => {
                    console.log("All remaining tasks logged successfully!");
                })
                
                // closing connection
                .then(() => {
                    return connection();
                })
                .then((db) => {
                    db.close();
                });
        }
    }, (allTasksError) => {
        console.log(allTasksError);
    });