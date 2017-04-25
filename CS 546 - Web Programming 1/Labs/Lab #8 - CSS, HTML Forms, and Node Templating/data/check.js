const uuid = require('uuid');
const mongodbCollection = require('../config/mongodbCollection');
const check = mongodbCollection.check;

// checking isPalindrome
function isPalindrome(phrase) {

    let str = "";
    var len = phrase.length;

    // omitting special characters
    // converting uppercase to lowercase
    for (var i = 0; i < len; i++) {
        let charCode = phrase.charCodeAt(i);

        if (charCode >= 97 && charCode <= 122) {
            str += phrase.charAt(i);
        } else if (charCode >= 65 && charCode <= 90) {
            charCode += 32 
            str += String.fromCharCode(charCode);
        }
    }

    // checking for palindrome
    len = str.length;
    var palindromeFlag = true;
    for (var i = 0; i < len/2; i++) {
        let front = str.charCodeAt(i);
        let rare = str.charCodeAt(len - i - 1);

        if (front != rare) {
            palindromeFlag = false;
            break;
        }
    }

    return palindromeFlag;
}

module.exports = checkControllers = {

    // return the check string of specific id
    getCheckById: (id) => {
        return check().then((checkCollection) => {
            return checkCollection.findOne({ _id:id }, { phrase:1, status:1 });
        });
    },
    
    // return all the check strings results
    getAllCheck: () => {
        return check().then((checkCollection) => {
            return checkCollection.find({}, { _id: 1, phrase:1, status:1 }).toArray();
        });
    },

    // create a new check with specified parameters
    createCheck: (phrase) => {
        return check().then((checkCollection) => {
            
            // new check object
            let newCheck = {
                _id: uuid.v4(),
                phrase: phrase,
                status: isPalindrome(phrase)
            };

            return checkCollection.insertOne(newCheck)
                .then((newCheckInformation) => {
                    return newCheckInformation.insertedId;
                })
                .then((newCheckId) => {
                    return checkControllers.getCheckById(newCheckId);
                });
        });
    },

    // delete a check of specified id
    deleteCheck: (id) => {
        return check().then((checkCollection) => {
            return checkCollection.removeOne({ _id:id })
                .then((deletedCheckInformation) => {
                    if (deletedCheckInformation.deletedCount === 0) {               // validating delete
                        return Promise.reject(`No result having id ${id}`);
                    }
                });
        });
    }
};