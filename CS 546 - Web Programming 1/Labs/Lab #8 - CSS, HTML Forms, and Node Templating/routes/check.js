const express = require('express');
const router = express.Router();
const data = require('../data');
const checkData = data.check;

// fetching data of specific id
router.get('/:id', (req, res) => {
    checkData.getCheckById(req.params.id).then((checkPhrase) => {
        res.json(checkPhrase);
        //res.render('checker/results', { check: checkPhrases })
    }).catch(() => {
        res.status(404).json({ error: "Not a valid id" });
    });
});

// fetching all data
router.get('/', (req, res) => {
    checkData.getAllCheck().then((checkPhrase) => {
        res.render('checker/results', { check: checkPhrase })
    }).catch(() => {
        res.status(404).json({ error: "No data in our records" });
    });
});

// inserting a data record into database
router.post('/', (req, res) => {
    let newPhrase = req.body;

    // checking null value
    if (!newPhrase.phrase) {
        res.status(400).json({ error: "No phrase provided." });
        return;
    }

    checkData.createCheck(newPhrase.phrase).then((checkPhrase) => {
        res.json(checkPhrase);        
    }).catch(() => {
        res.status(404).json({ error: "No valid inputs" });
    });
});


// deleting a data of specific id from database
router.delete("/:id", (req, res) => {
    checkData.getCheckById(req.params.id).then(() => {
        checkData.deleteCheck(req.params.id).then(() => {
            res.status(200).send(`Pharse of id ${req.params.id} has been deleted`);
        }, (err) => {
            res.status(500).json({ error: err });
        });
    }).catch((err) => {
        res.status(404).json({ error: err });
    });
});

module.exports = router;