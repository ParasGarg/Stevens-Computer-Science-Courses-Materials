const uuid = require('uuid');
const bcrypt = require('bcrypt');

/* basic data collection module */
const users = [
    {
        _id: uuid.v4(),
        username: "masterdetective123",
        hashedPassword: bcrypt.hashSync("elementarymydearwatson", 10),
        firstName: "Sherlock",
        lastName: "Holmes",
        profession: "Detective",
        bio: "Sherlock Holmes (/ˈʃɜːrlɒk ˈhoʊmz/) is a fictional private detective created by British author Sir Arthur Conan Doyle. Known as a 'consulting detective' in the stories, Holmes is known for a proficiency with observation, forensic science, and logical reasoning that borders on the fantastic, which he employs when investigating cases for a wide variety of clients, including Scotland Yard."
    },
    {
        _id: uuid.v4(),
        username: "lemon",
        hashedPassword: bcrypt.hashSync("damnyoujackdonaghy", 10),
        firstName: "Elizabeth",
        lastName: "Lemon",
        profession: "Writer",
        bio: "Elizabeth Miervaldis 'Liz' Lemon is the main character of the American television series 30 Rock. She created and writes for the fictional comedy-sketch show The Girlie Show or TGS with Tracy Jordan."
    },
    {
        _id: uuid.v4(),
        username: "theboywholived",
        hashedPassword: bcrypt.hashSync("quidditch", 10),
        firstName: "Harry",
        lastName: "Potter",
        profession: "Student",
        bio: "Harry Potter is a series of fantasy novels written by British author J. K. Rowling. The novels chronicle the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry . The main story arc concerns Harry's struggle against Lord Voldemort, a dark wizard who intends to become immortal, overthrow the wizard governing body known as the Ministry of Magic, and subjugate all wizards and Muggles."
    }
];

module.exports = usersController = {

    // return user info from username
    getUserByUsername: (username) => {
        let usersCount = users.length;
        if (usersCount > 0) {                                   // validating for null datasets
            for (var i = 0; i < usersCount; i++) {              // traversing through all data records
                if (users[i].username === username) {           // validating for valid username 
                    return Promise.resolve(users[i]);           // returning user info
                }
            }

            return Promise.reject("Incorrect Username");
        } else {
            return Promise.reject("Empty Collection");
        }
    },

    getUserById: (id) => {
        let usersCount = users.length;
        if (usersCount > 0) {                                   // validating for null datasets
            for (var i = 0; i < usersCount; i++) {              // traversing through all data records
                if (users[i]._id === id) {                      // validating for valid id 
                    return Promise.resolve(users[i]);           // returning user info                    
                }
            }

            return Promise.reject("Incorrect Username's Id");
        } else {
            return Promise.reject("Empty Collection");
        }
    },

    compareCredentials: (password, hashedPassword) => {
        if (bcrypt.compareSync(password, hashedPassword))           // validating for valid password
            return Promise.resolve("Valid Password");        
        return Promise.reject("Incorrect Password");
    }
};