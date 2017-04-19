/*
###### ******************************* ######
               Web Programming

        Course		    : CS 546-WS								
		First Name		: PARAS								
		Last Name		: GARG								
		Id		        : 10414982								
		Purpose		    : Lab 1				

###### ******************************* ######
*/

// Sum of Squares
function sumOfSquares(num1, num2, num3) {
    if (typeof(num1) !== "number" || typeof(num2) !== "number" || typeof(num3) !== "number") {
        throw "You missed parameter(s) while calling the function";
    }
    
    return (Math.pow(num1, 2) + Math.pow(num2, 2) + Math.pow(num3, 2));
}


// Say Hello
function sayHello(base) {
    if (arguments.length == 0) {
        throw "no argument found";
    } else if (arguments.length == 1) {
        base = String(base) + "!";
        console.log("Hello,", base);
    } else if (arguments.length == 2) {
        base = String(base) + " " + String(arguments[1]) + ". I hope you are having a good day!";
        console.log("Hello,", base);
    } else if (arguments.length == 3) {
        base = String(arguments[2]) + " " + String(base) + " " + String(arguments[1]) + "! Have a good evening!";
        console.log("Hello,", base);
    }
}


// Cups of Coffee
function cupsOfCoffee(cups) {
    if (cups < 1 || typeof(cups) != "number") {         // when no cup of coffee
        throw "invalid cup(s) of coffee";
    }

    var i = 1;
    if (cups >= 1) {                                    // when cups of coffee are more than or equal to 1
        for (i = cups; i > 1; i--) {
            let song = `${i} cups of coffee on the desk! ${i} cups of coffee!\nPick one up, drink the cup, ${i-1} cups of coffee on the desk! \n`; 
            console.log(song);
        }

        let j = "no more coffee left";                  // when one cup of coffee is left
        let song = `${i} cup of coffee on the desk! ${i} cup of coffee!\nPick one up, drink the cup, ${j} on the desk! \n`; 
        console.log(song);
    }
}


// Occurrences of Substring
function occurrencesOfSubstring(fullString, substring) {
    if (typeof(fullString) != "string" || typeof(substring) != "string") {
        throw "invalid arguments or value passed type";
    }

    var count = 0;
    for (let i = 0; i < fullString.length; i++) {
        if ((substring[0] === fullString[i]) && ((fullString.length-i-1)>= substring.length)) {
            var matchFlag = 1;
            for (let j = 1; j < substring.length; j++) {
                if (substring[j] != fullString[j+i]) {
                    matchFlag = 0;
                    break;
                }
            }
            if (matchFlag == 1) {
                count++;
            }
        }
    }
    return count;
}


// Randomize Sentences
function randomizeSentences(paragraph) {
    // spliting paragraph on the basis of '!' and '.'
    let paraArr = [];
    var paraStr = " ";
    for (var i = 0; i < paragraph.length; i++) {
        if (paragraph[i] === "!" || paragraph[i] === ".") {
            paraStr = paraStr + paragraph[i];
            paraArr.push(`${paraStr}`);
            paraStr = "";
        } else {
            paraStr = paraStr + paragraph[i];
        }
    }

    // filling another array randomly
    let randomParaArr = [];
    while(paraArr.length > 0) { 
        randomIndex = Math.floor(Math.random() * (paraArr.length - 0)) + 0;
        randomParaArr.push(`${paraArr[randomIndex]}`);                      // adding element into an array
        paraArr.splice(randomIndex, 1);                                     // removing element from an array
    }

    // creating a string to return the result
    paragraph = "";
    for (var i = 0; i < randomParaArr.length; i++) {
        paragraph = paragraph + randomParaArr[i];
    }

    return paragraph;
}


/* displaying results on console */
  console.log(`Sum of Squares: ${sumOfSquares(5, 3, 10)}`);               // function 1 : Sum Of Squares

  sayHello("Phil", "Barresi", "Mr.");                                     // function 2 : Say Hello

  cupsOfCoffee(5);                                                        // function 3 : Cups Of Coffee

  console.log(occurrencesOfSubstring("Hellllooo", "ll"));                 // function 4 : Occurrences Of Substring

var paragraph = "Hello, world! I am a paragraph. You can tell that I am a paragraph because there are multiple sentences that are split up by punctuation marks. Grammar can be funny, so I will only put in paragraphs with periods, exclamation marks, and question marks -- no quotations.";
  console.log(randomizeSentences(paragraph));                             // function 5 : Randomize Sentences