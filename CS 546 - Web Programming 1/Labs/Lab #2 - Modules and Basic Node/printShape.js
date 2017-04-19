/* print shape file */
module.exports = {
    description: "This is a PrintShape file for Lab 2 for CS-546-WS",

    triangle: (lines) => {

        var times = 1;
        while (times <= 10) {                                               // printing output for triangle : loop for 10 times
            // printing triangle
            var left_spaces = "";
            for (var i = 1; i <= lines-1; i++) left_spaces += " ";          // printing blank spaces

            var mid_spaces = "";
            for (var i = 1; i <= lines; i++) {
                console.log(left_spaces + "/"+ mid_spaces + "\\");
                left_spaces = left_spaces.substring(0, left_spaces.length-1);
                mid_spaces += "--";
            }

            times++;                                                        // increamenting times count
            console.log("\n");                                              // adding new blank line in screen;
        }
    },

    square: (lines) => {
        var times = 1;
        while (times <= 10) {                                               // printing output for square : loop for 10 times
            // printing square
            // printing top bar
            var spaces = "";
            for (var i = 1; i <= lines; i++) spaces += "-";                 // printing blank spaces
            console.log("|"+ spaces + "|");

            // printing middle section of square
            var spaces = "";
            for (var i = 1; i <= lines; i++) spaces += " ";                 // printing blank spaces
            for (var i = 1; i <= lines-2; i++) console.log("|"+ spaces + "|");
            
            // printing bottom bar of square
            var spaces = "";
            for (var i = 1; i <= lines; i++) spaces += "-";                 // printing '-'
            console.log("|"+ spaces + "|");
            
            times++;                                                        // increamenting times count
            console.log("\n");                                              // adding new blank line in screen;
        }
    },

    rhombus: (lines) => {
        var times = 1;
        while (times <= 10) {                                               // printing output for rhombus : loop for 10 times
            // printing rhombus
            // printing top bar of rhombus
            var spaces = "";
            for (var i = 1; i <= (lines-2)/2; i++) spaces += " ";           // printing blank spaces
            console.log(spaces + "/"+ "-" + "\\");
            
            // printing middle top section of rhombus  
            var left_spaces = "";
            for (var i = 1; i <= (lines-2)/2 - 1; i++) left_spaces += " ";  // printing blank spaces
            
            var mid_spaces = "   ";
            for (var i = 1; i <= (lines-2)/2; i++) {
                console.log(left_spaces + "/"+ mid_spaces + "\\");
                left_spaces = left_spaces.substring(0, left_spaces.length-1);
                mid_spaces += "  ";
            }

            // printing middle bottom section of rhombus 
            for (var i = 0; i < (lines-2)/2; i++) {
                mid_spaces = mid_spaces.substring(0, mid_spaces.length-2);
                console.log(left_spaces + "\\"+ mid_spaces + "/");
                left_spaces += " ";
            }
            
            // printing bottom bar of rhombus
            var spaces = "";
            for (var i = 1; i <= (lines-2)/2; i++) spaces += " ";           // printing blank spaces
            console.log(spaces + "\\"+ "-" + "/");

            times++;                                                        // increamenting times count
            console.log("\n");                                              // adding new blank line in screen;
        }
    }
};

