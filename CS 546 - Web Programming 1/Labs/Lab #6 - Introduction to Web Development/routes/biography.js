const express = require('express');
const router = express.Router();

router.get("/about", (req, res) => {

    let aboutJSON = {
        name: "Paras Garg",
        biography: "I lived in the southern Asia: I grew up in Aligarh, Uttar Pradesh, in a hindi-speaking family, earned an undergraduate degree in Information Technology from G L Bajaj Institute of Technology, and worked for two years in Life Insurance Corporation of India, where I worked on information services projects. That led me to Stevens Institute of Technology for Master of Science in Computer Science program. I wanted to create opportunities for future work. MS classes will help me immediately in my job. In my data structure and algorithm class I learned about the impact of a small piece of code, and how to code quality and time complexity matters for higher performance, that’s exactly what we discussed.",
        favoriteShows: ["Friends", "Game of Thrones", "The Crown", "How I Met Your Mother", "Sherlock", "Last Man Standing"],
        hobbies: ["Cooking", "Traveling", "Football"]
    } 

    res.json(aboutJSON);
});

router.get("/story", (req, res) => {

    let storyJSON = {
        storyTitle: "What is the most valuable programming skill at the moment?",
        story: "The most valuable programming skill? It actually hasn’t changed since the 1960s, it’s only become more important, as the size and complexity of the software we develop has increased. The most important skill is: Abstraction -  The ability to recognise common patterns in the desired behaviour of the program and organise your code around them. The ability to design systems and to structure code so that whenever X happens, so does Y. The ability to structure loops so that they’re always executed the right number of times and so each statement is executed always and only when it should be. The ability to structure data so that the requisite parts are always present when they should be, never when they shouldn’t be, and it’s always possible to find the information that may be needed. The ability to document your code in an approachable way, so that the most important parts can be understood without having to understand all the details first. The ability to recognise and apply the appropriate architectural or design patterns for the current situation. All of these things are abstraction. 'Edsger W. Dijkstra observed this in 1972': effective exploitation of his powers of abstraction must be regarded as one of the most vital activities of a competent programmer. He also said that We all know that the only mental tool by means of which a very finite piece of reasoning can cover a myriad cases is called abstraction; as a result the effective exploitation of his powers of abstraction must be regarded as one of the most vital activities of a competent programmer. True in the 1970s, and even more true now."
    }

    res.json(storyJSON);
});

router.get("/education", (req, res) => {
    
    let educationJSON = [
        {
            schoolName: "Stevens Institute of Technology",
            degree: "Master in Science in Computer Science (MSCS)",
            favoriteClass: "Cyber Security",
            favoriteMemory: "A memorable memory was when I performed in festival event."
        },
        {
            schoolName: "G L Bajaj Institute of Technology and Management",
            degree: "Bachelor of Technology in Information Technology",
            favoriteClass: "Algorithms and Data Structures",
            favoriteMemory: "A memorable memory was when I was selected for college level Compter Coding and Innovative team."
        },
        {
            schoolName: "St Fidelis Senior Secondary School",
            degree: "Senior Secondary Certificate",
            favoriteClass: "Compter Science",
            favoriteMemory: "A memorable memory was when I went for tour to Goa with friends."
        }
    ]

    res.json(educationJSON);    
});

router.get("/", (req, res) => {
    // Not implemented
    res.sendStatus(501);
});

module.exports = router;