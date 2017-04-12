const fd = require("./fileData");                                                               // importing fileData file
const tm = require("./textMetrics");                                                            // importing textMetrics file
const fs = require("fs");                                                                       // importing fs (file system) library


// operation on chapter1
setTimeout(() => {
    fs.exists ("chapter1.result.json", (exists)  => {
        if (exists) {                                                                           // checking for result file
            console.log("Chapter 1 result found. Printing result.");                            // display message
            setTimeout(() => {
                fd.getFileAsJSON("chapter1.result.json")
                    // promise for reading json file
                    .then((chapterJsonData) => { 
                        console.log(chapterJsonData);
                        console.log("\nChapter 1 result printing over.");                       // display message
                    }, (chapterJsonData) => { 
                        console.log(chapterJsonData); 
                    });                
            }, 1000);
        } else if (!exists) {
            setTimeout(() => {
                console.log("Chapter 1 result not found. Performing operations on the file.");  // display message
                fd.getFileAsString("chapter1.txt")                                              // promise for reading text file                
                .then((chapterData) => {                                                        // read text file resolve handler
                    return tm.simplify(chapterData)                                             // promise for simplifying text file              
                    .then((simplifyData) => {                                                   // simplifying text file resolve handler
                        return fd.saveStringToFile("chapter1.debug.txt", simplifyData)          // promise for save text to file                        
                        .then((simplifyData) => {                                               // save text file resolve handler
                            return tm.createMetrics(simplifyData)                               // promise for create metrics
                            .then((metricsData) => {                                            // create metrics resolve handler
                                return fd.saveJSONToFile("chapter1.result.json", metricsData)   // promise for save json to file
                                .then((jsonData) => {                                           // save json file resolve handler
                                    console.log("Chapter 1 result created. Printing result.");  // display message
                                    console.log(jsonData);                                      // display result
                                    console.log("\nChapter 1 result printing over.");           // display message 
                                }, (jsonError) => { console.log(jsonError); });                 // json file print reject
                            })
                            .catch((metricsError) => {                                          // create metrics reject handler
                                console.log(metricsError); 
                            })
                        })
                        .catch((textFilewriteError) => {                                        // save text file reject handler
                            console.log(textFilewriteError); 
                        })            
                    })
                    .catch ((simplifyError) => {                                                // simplifying text file reject handler
                        console.log(simplifyError); 
                    }) 
                })
                .catch((chapterError) => {                                                      // read text file reject handler
                    console.log(chapterError); 
                })  
            }, 1000); 
        } 
    });
}, 0);

// operation on chapter2
setTimeout(() => {
    fs.exists ("chapter2.result.json", (exists)  => {
        if (exists) {                                                                           // checking for result file
            setTimeout(() => {
                console.log("Chapter 2 result found. Printing result.");                        // display message
                fd.getFileAsJSON("chapter2.result.json")
                    // promise for reading json file
                    .then((chapterJsonData) => { 
                        console.log(chapterJsonData);
                        console.log("\nChapter 2 result printing over.");                       // display message
                    }, (chapterJsonData) => { 
                        console.log(chapterJsonData); 
                    });                
            }, 2000);
        } else if (!exists) {
            setTimeout(() => {
                console.log("Chapter 2 result not found. Performing operations on the file.");  // display message
                fd.getFileAsString("chapter2.txt")                                              // promise for reading text file                
                .then((chapterData) => {                                                        // read text file resolve handler
                    return tm.simplify(chapterData)                                             // promise for simplifying text file              
                    .then((simplifyData) => {                                                   // simplifying text file resolve handler
                        return fd.saveStringToFile("chapter2.debug.txt", simplifyData)          // promise for save text to file                        
                        .then((simplifyData) => {                                               // save text file resolve handler
                            return tm.createMetrics(simplifyData)                               // promise for create metrics
                            .then((metricsData) => {                                            // create metrics resolve handler
                                return fd.saveJSONToFile("chapter2.result.json", metricsData)   // promise for save json to file
                                .then((jsonData) => {                                           // save json file resolve handler
                                    console.log("Chapter 2 result created. Printing result.");  // display message
                                    console.log(jsonData);                                      // display result
                                    console.log("\nChapter 2 result printing over.");           // display message 
                                }, (jsonError) => { console.log(jsonError); });                 // json file print reject
                            })
                            .catch((metricsError) => {                                          // create metrics reject handler
                                console.log(metricsError); 
                            })
                        })
                        .catch((textFilewriteError) => {                                        // save text file reject handler
                            console.log(textFilewriteError); 
                        })            
                    })
                    .catch ((simplifyError) => {                                                // simplifying text file reject handler
                        console.log(simplifyError); 
                    }) 
                })
                .catch((chapterError) => {                                                      // read text file reject handler
                    console.log(chapterError); 
                })  
            }, 2000); 
        } 
    });
}, 1500);

// operation on chapter3
setTimeout(() => {
    fs.exists ("chapter3.result.json", (exists)  => {
        if (exists) {                                                                           // checking for result file
            setTimeout(() => {
                console.log("Chapter 3 result found. Printing result.");                        // display message                
                fd.getFileAsJSON("chapter3.result.json")
                    // promise for reading json file
                    .then((chapterJsonData) => { 
                        console.log(chapterJsonData);
                        console.log("\nChapter 3 result printing over.");                       // display message
                    }, (chapterJsonData) => { 
                        console.log(chapterJsonData); 
                    });                
            }, 3000);
        } else if (!exists) {
            setTimeout(() => {
                console.log("Chapter 3 result not found. Performing operations on the file.");  // display message            
                fd.getFileAsString("chapter3.txt")                                              // promise for reading text file                
                .then((chapterData) => {                                                        // read text file resolve handler
                    return tm.simplify(chapterData)                                             // promise for simplifying text file              
                    .then((simplifyData) => {                                                   // simplifying text file resolve handler
                        return fd.saveStringToFile("chapter3.debug.txt", simplifyData)          // promise for save text to file                        
                        .then((simplifyData) => {                                               // save text file resolve handler
                            return tm.createMetrics(simplifyData)                               // promise for create metrics
                            .then((metricsData) => {                                            // create metrics resolve handler
                                return fd.saveJSONToFile("chapter3.result.json", metricsData)   // promise for save json to file
                                .then((jsonData) => {                                           // save json file resolve handler
                                    console.log("Chapter 3 result created. Printing result.");  // display message
                                    console.log(jsonData);                                      // display result
                                    console.log("\nChapter 3 result printing over.");           // display message 
                                }, (jsonError) => { console.log(jsonError); });                 // json file print reject
                            })
                            .catch((metricsError) => {                                          // create metrics reject handler
                                console.log(metricsError); 
                            })
                        })
                        .catch((textFilewriteError) => {                                        // save text file reject handler
                            console.log(textFilewriteError); 
                        })            
                    })
                    .catch ((simplifyError) => {                                                // simplifying text file reject handler
                        console.log(simplifyError); 
                    }) 
                })
                .catch((chapterError) => {                                                      // read text file reject handler
                    console.log(chapterError); 
                })  
            }, 3000); 
        } 
    });
}, 2500);