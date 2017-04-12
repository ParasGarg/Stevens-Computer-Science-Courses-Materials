const printShape = require("./printShape");
const prompt = require("prompt");

// shape function
function shapes() {
    prompt.start();                                                         // starting prompting

    const lines = {
        name: 'lines',
        description: 'Enter the number of lines',
        type: 'number',
        required: true
    };

    // getting properties from user
    prompt.get([lines], function(err, result) {

        // console.log(result);
        // result = { lines: 2 }
        if (result) {
            // storing user input in variables
            let lines = result.lines;

            // promises
            // we can either use throw or reject
            let trianglePromise = new Promise(function (resolve, reject) {  // promise for triangle
                if ((lines < 1) || isNaN(lines)) {                          // input validation for triangle : input range and datatype validation
                    throw 'For triangle: input should be any positive integer greater than or equal to 1';
                } else {
                    resolve = printShape.triangle(lines);
                }
            });

            let squarePromise = new Promise(function (resolve, reject) {    // promise for square
                if ((lines < 2) || isNaN(lines)) {                          // input validation for square : input range and datatype validation
                    reject('For square: input should be any positive integer greater than or equal to 2');
                } else {
                    resolve = printShape.square(lines);
                }
            });

            let rhombusPromise = new Promise(function (resolve, reject) {   // promise for rhombus
                if ((lines < 2) || isNaN(lines)) {                          // input validation for rhombus : input range and datatype validation
                    reject('For rhombus: input should be any positive integer greater than or equal to 2');
                } else if (lines % 2 != 0) {                                // input validation for rhombus : input should be multiple of 2
                    throw 'For rhombus: input should be multiple of 2';
                } else {
                    resolve = printShape.rhombus(lines);
                }
            });

            // returing promises
            trianglePromise
                .then(function(resolve) {})
                .catch(function(reject) { console.log(reject) });

            squarePromise
                .then(function(resolve) {})
                .catch(function(reject) { console.log(reject) });

            rhombusPromise
                .then(function(resolve) {})
                .catch(function(reject) { console.log(reject) });

        } else if (err) {
            console.log(err);
        }
        
    });
}

shapes();