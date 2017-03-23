/*
  === GROUP DETAILS ===
  Class Section  : CS 570 LB
  Group Name     : Lab Group 15
  Members Name   : Paras Garg, Pinkel Ganjawala, Dawwei Sun
*/

/*
  Lab Assisgnment 1:
  For each number in the sequence, output the number to the screen.
  However, if the number is divisible by 3, output the word Buzz instead of the number.
  If the number is divisble by 5, output Fizz to the screen instead of the number.
  If the number is divisible by both, output BuzzFizz to the screen instead of the number.
*/

// printing the Question
console.log("\nLab Assisgnment 1:\nFor each number in the sequence, output the number to the screen. However, if the number is divisible by 3, output the word Buzz instead of the number. If the number is divisble by 5, output Fizz to the screen instead of the number. If the number is divisible by both, output BuzzFizz to the screen instead of the number. \n");

// declaration of an Array
var Container = [];

// inputting values in the Array Container
for (var i = 10; i <= 250 ; i++) {
  Container.push(i);
}

// passing the Array to FizzBuzzer function
FizzBuzzer(Container);

// FizzBuzzer function
function FizzBuzzer(ContainerPassed) {
  for (var i = 0; i < ContainerPassed.length; i++) {
    var value = ContainerPassed[i];                   // defining value variable

    if ( (value % 3 == 0) && (value % 5 == 0) ) {
      console.log("BuzzFizz");
    }
    else if ( value % 3 == 0 ) {
      console.log("Buzz");
    }
    else if ( value % 5 == 0 ) {
      console.log("Fizz");
    }
    else {
      console.log(value);
    }
  }
}

/*
  === GROUP DETAILS ===
  Class Section  : CS 570 LB
  Lab Group Name :
  Members Name   : Paras Garg, Pinkel Ganjawala, Dawwei Sun
*/
