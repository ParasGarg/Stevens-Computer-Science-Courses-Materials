const uuid = require('uuid');
const mongodbCollection = require('../config/mongodbCollection');
const recipes = mongodbCollection.recipes;

module.exports = commentsController = {

    // return all comments in a specified recipes
    getCommentsByRecipeId: (recipeId) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.findOne({ _id: recipeId })
                .then((recipeDetails) => {

                    if (!recipeDetails) {                                   // checking recipe
                        return Promise.reject(`No recipe of id ${recipeId} found in records`);
                    } else if (recipeDetails.comments.length === 0) {       // checking comments
                        return Promise.reject(`No comments are in the recipe of id ${recipeId}`);
                    }

                    // adding desired attributes in each comment
                    let comments = recipeDetails.comments;
                    let commentsView = [];
                    for (var loc = 0, n = comments.length; loc < n; loc++) {
                        commentsView[loc] = {
                            "_id": comments[loc]._id,
                            "recipeId": recipeId,
                            "recipeTitle": recipeDetails.title,
                            "poster": comments[loc].poster,
                            "comment": comments[loc].comment
                        }
                    }

                    return commentsView;
                });
        });
    },

    // return comment of specific id
    getCommentById: (id) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.findOne({ "comments._id": id }, { _id: 1, title: 1, comments: 1 })
                .then((recipeItem) => {

                    if (!recipeItem) {                       // checking comment 
                        return Promise.reject(`No comment of id ${id} found in records.`);
                    }

                    // finding comment location in comment array
                    var loc = 0;
                    let comments = recipeItem.comments;
                    while (loc < comments.length) {
                        if (comments[loc]._id === id.toString()) {
                            break;
                        }

                        loc++;
                    }

                    // creating json variable
                    let commentView = {
                        "_id": id,
                        "recipeId": recipeItem._id,
                        "recipeTitle": recipeItem.title,
                        "poster": comments[loc].poster,
                        "comment": comments[loc].comment
                    };

                    return commentView;
                });
        });
    },


    // create a new recipe with specified parameters
    createComment: (recipeId, newComment) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.findOne({ _id: recipeId }).then((recipeItem) => {

                if (!recipeItem) {                              // checking recipe
                    return Promise.reject(`No recipe of id ${recipeId} found in records.`);
                }

                // new comment object
                let addComment = {
                    _id: uuid.v4(),
                };

                if (newComment.poster)
                    addComment['poster'] = newComment.poster;

                if (newComment.comment)
                    addComment['comment'] = newComment.comment;

                return recipesCollection.update({ _id: recipeId }, { $push: { comments: addComment } }).then(() => {
                    return addComment;
                });
            });
        });
    },


    // update a comment of specified recipe
    updateComment: (recipeId, commentId, commentUpdates) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.findOne({ _id: recipeId }).then((recipeItem) => {
                if (!recipeItem) {                           // checking recipe id
                    return Promise.reject(`No recipe of id ${recipeId} is found in records.`);
                }

                // updating comments attributes
                if (commentUpdates.poster) {
                    recipesCollection.update({ "comments._id": commentId }, { $set: { "comments.$.poster": commentUpdates.poster } });
                }

                if (commentUpdates.comment) {
                    recipesCollection.update({ "comments._id": commentId }, { $set: { "comments.$.comment": commentUpdates.comment } });
                }

                var updatedComment = new Promise((resolve, reject) => {
                    setTimeout(() => {
                        resolve(commentsController.getCommentById(commentId));
                    }, 300);
                });

                return updatedComment;
            });
        });
    },


    // delete a comment of specified id
    deleteComment: (id) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.update({ "comments._id": id }, { $pull: { comments: { _id: id } } }).then((deletedCommentInformation) => {
                if (deletedCommentInformation.deletedCount === 0) {
                    return res.status(500).json({ error: `Comment having id ${id} could not be deleted` });
                }
            });
        });
    }
};