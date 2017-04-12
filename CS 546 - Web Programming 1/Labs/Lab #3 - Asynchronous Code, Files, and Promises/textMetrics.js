let testMetics = exports = module.exports;                                          // exporting testMetics and its modules                                          

// method 1: simplify(text)
testMetics.simplify = (text) => {
    return new Promise((resolve, reject) => {
        if (!text)
            throw "No text provided";

        var textLowerCase = text.toLowerCase();                                     // converting text in lower case
        var textAlphanumeric = textLowerCase.replace(/(?!\w|\s)./g,'');             // removing special characters
        var textTrimmed = textAlphanumeric.replace(/\s+/g, ' ').trim();             // removing extra white spaces

        resolve(textTrimmed);                                                       // returning simplified value
    });
};


// method 2: createMetrics(text)
testMetics.createMetrics = (text) => {
    return new Promise((resolve, reject) => {
        if (!text)
            throw "No text provided";                                               // null path reject error

        // calling simplify function to simplify the text
        testMetics.simplify(text)
            .then((textSimplified) => {

                // convertling string into list
                var textList = textSimplified.split(" ");

                // calculating number of letters in the text
                var totalLetters = 0;
                for (var i = 0; i < textList.length; i++) {   
                    totalLetters += textList[i].length;
                }

                // calculating number of words in the text
                var totalWords = textList.length;
        
                // finding number of unique words
                var uniqueWords = new Set();
                for (var i = 0; i < textList.length; i++) {
                    uniqueWords.add(textList[i]);
                }
                
                // calculating number of long words
                var longWords = 0;
                for (var i = 0; i < textList.length; i++) {
                    if (textList[i].length >= 6) {
                        longWords++;
                    }
                }

                // calculating average word length
                var averageWordLength = totalLetters / totalWords;

                // calculating number of occurences of each word
                var wordOccurrences = {};
                for (var i = 0; i < textList.length; i++) {
                    if (!wordOccurrences[textList[i]]) {
                        wordOccurrences[textList[i]] = 1;
                    } else {
                        wordOccurrences[textList[i]]++;
                    }
                }

                // resovling the Promise
                resolve({
                    totalLetters: totalLetters,
                    totalWords: totalWords,
                    uniqueWords: uniqueWords.size,
                    longWords: longWords,
                    averageWordLength: averageWordLength,
                    wordOccurrences: wordOccurrences
                });
            })
            .catch((textSimplifiedError) => {
                console.log(textSimplifiedError);
            });
    }); 
};























