const fs = require("fs");                                                       // importing fs (file system) library
let fileData = exports = module.exports;                                        // exporting fileData and its modules 


// method 1: getFileAsString(path)
fileData.getFileAsString = (file_path) => {
    return new Promise((resolve, reject) => {                                   // returning a promise
        if (!file_path)                                                         // validating for null path
            throw "No readable path to text file provided";                     // null path reject error
        
        fs.readFile(file_path, "utf-8", (read_error, read_data) => {            // reading file
            if (read_error) {                                                   // validating for read error
                reject("No such readable file or directory exists");            // rejecting read error
                return;                                                         // terminating by null return
            } 

            resolve(read_data);                                                 // returning file data (string)
        });
    });
};


// method 2: getFileAsJSON(path)
fileData.getFileAsJSON = (file_path) => {
    return new Promise((resolve, reject) => {                                   // returning a promise
        if (!file_path)                                                         // validating for null path
            throw "No readable path to json file provided";                     // null path reject error
        
        fs.readFile(file_path, "utf-8", (read_error, read_data) => {            // reading file
            if (read_error) {                                                   // validating for read error
                reject("No such readable file or directory exists");            // rejecting read error
            } 

            try {
                let read_data_json = JSON.parse(read_data);                     // parsing obtained data in string in to javascript object
                resolve(read_data_json);                                        // returning file data (javascript object)
            } catch (parsing_error) {
                reject("There was an parsing error");                           // rejecting parsing error
            }            
        });
    });
};


// method 3: saveStringToFile(path, text)
fileData.saveStringToFile = (file_path, file_data) => {
    return new Promise((resolve, reject) => {                                   // returning a promise
        if (!file_path)                                                         // validating for null path
            throw "No writable path to text file provided";                     // null path reject error
        else if (!file_data)                                                    // validating for null data
            throw "No writable data in text file provided";                     // null path reject error

        fs.writeFile(file_path, file_data, (write_error, write_data) => {       // writing file
            if (write_error) {                                                  // validating for write error
                reject(write_error);                                            // rejecting write error
                return;                                                         // terminating by null return
            } 

            console.log("Text data saved at location " + file_path);            // displaying message            
            resolve(file_data);                                                 // resolving file data (string)
        });
    });
};

// method 4: saveJSONToFile(path, obj)
fileData.saveJSONToFile = (file_path, file_json_data) => {
    return new Promise((resolve, reject) => {                                   // returning a promise
        if (!file_path)                                                         // validating for null path
            throw "No writable path to text file provided";                     // null path reject error
        else if (!file_json_data)                                               // validating for null data
            throw "No writable data in text file provided";                     // null path reject error

        fs.writeFile(file_path, JSON.stringify(file_json_data, null, 4), (write_error, write_data) => {  // writing file
            if (write_error) {                                                  // validating for write error
                reject(write_error);                                            // rejecting write error
                return;                                                         // terminating by null return
            }

            console.log("Json data saved at location " + file_path);            // displaying message
            resolve(file_json_data);                                            // resolving file data (string)
        });
    });
};