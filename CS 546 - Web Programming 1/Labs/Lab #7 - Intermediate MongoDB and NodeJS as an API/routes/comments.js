const express = require('express');
const router = express.Router();
const data = require('../data');
const commentsData = data.comments;


// routes checking
router.get("/", (req, res) => {
    res.status(200).send("This is the Root Page of Comments");
});

router.get("/recipe", (req, res) => {
    res.sendStatus(501);
});

// route for getting all comments of specified recipe id
router.get("/recipe/:recipeId", (req, res) => {
    commentsData.getCommentsByRecipeId(req.params.recipeId).then((commentsList) => {
        res.json(commentsList);
    }, (err) => {
        res.status(404).json({ error: err });
    });
});


// route for getting comment with specified comment id
router.get("/:commentId", (req, res) => {
    commentsData.getCommentById(req.params.commentId).then((commentItem) => {
        res.json(commentItem);
    }, (err) => {
        res.status(404).json({ error: err });
    });
});


// route for posting comment of specified recipe
router.post("/:recipeId", (req, res) => {
    let newComment = req.body;

    if (Object.keys(newComment).length === 0) {     // checking comment variable for values
        res.status(400).json({ error: "No comment provided" });
        return;
    } else if (!newComment.poster) {                // checking comment poster attribute
        res.status(400).json({ error: "No comment poster provided" });
        return;
    } else if (!newComment.comment) {               // checking comment comment attribute
        res.status(400).json({ error: "No comment body provided" });
        return;
    }

    commentsData.createComment(req.params.recipeId, newComment).then((newComment) => {
        res.json(newComment);
    }, (err) => {
        res.status(404).json({ error: err });
    });
})


// route for putting specified comment of specific recipe
router.put("/:recipeId/:commentId", (req, res) => {
    let commentUpdates = req.body;

    if (Object.keys(commentUpdates).length === 0) {     // checking comment updates values
        res.status(400).json({ error: "No comment updates provided" });
        return;
    }

    commentsData.getCommentById(req.params.commentId).then(() => {
        return commentsData.updateComment(req.params.recipeId, req.params.commentId, commentUpdates).then((updatedComment) => {
            console.log("Comment Updated!");
            res.json(updatedComment);
        }, (err) => {
            res.status(404).json({ error: err });
        });
    }, (err) => {
        res.status(404).json({ error: err });
    });
});


// // route for deleting specified comment
router.delete("/:id", (req, res) => {
    commentsData.getCommentById(req.params.id).then(() => {
        return commentsData.deleteComment(req.params.id).then(() => {
            res.status(200).send(`Comment of id ${req.params.id} has been deleted`);
        }, (err) => {
            res.status(500).json({ error: err });
        });
    }, (err) => {
        res.status(404).json({ error: err });
    });
});

module.exports = router;