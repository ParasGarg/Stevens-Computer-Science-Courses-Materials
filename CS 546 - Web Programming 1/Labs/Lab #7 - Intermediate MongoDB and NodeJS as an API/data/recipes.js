const uuid = require('uuid');
const mongodbCollection = require('../config/mongodbCollection');
const recipes = mongodbCollection.recipes;

module.exports = recipeControllers = {

    // return all the recipes in the recipesCollection
    getAllRecipes: () => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.find({}, { _id: 1, title: 1 }).toArray();
        });
    },

    // return recipe of specific id
    getRecipeById: (id) => {
        return recipes().then((recipesCollection) => {
            return recipesCollection.findOne({ _id: id })
                .then((recipeItem) => {

                    if (!recipeItem) {               // checking recipe id
                        return Promise.reject(`No recipe of id ${id} is found in records.`);
                    }

                    return recipeItem;
                });
        });
    },

    // create a new recipe with specified parameters
    createRecipe: (title, ingredients, steps, comments) => {
        return recipes().then((recipeCollection) => {

            // new recipe object
            let newRecipe = {
                _id: uuid.v4(),
                title: title,
                ingredients: ingredients,
                steps: steps,
                comments: comments
            };

            return recipeCollection.insertOne(newRecipe)
                .then((newRecipeInformation) => {
                    return newRecipeInformation.insertedId;
                })
                .then((newRecipeId) => {
                    return recipeControllers.getRecipeById(newRecipeId);
                });
        });
    },

    // update a recipe with supplied parameters
    updateRecipe: (id, recipeUpdates) => {
        return recipes().then((recipeCollection) => {

            let recipeChanges = {};                    // new empty object

            if (recipeUpdates.title) {                  // checking and updating title
                recipeChanges['title'] = recipeUpdates.title;
            }

            if (recipeUpdates.ingredients) {            // checking and updating ingredients
                recipeChanges['ingredients'] = recipeUpdates.ingredients;
            }

            if (recipeUpdates.steps) {                  // checking and updating steps
                recipeChanges['steps'] = recipeUpdates.steps;
            }

            if (recipeUpdates.comments) {               // checking and updating comments
                recipeChanges['comments'] = recipeUpdates.comments;
            }

            return recipeCollection.updateOne({ _id: id }, { $set: recipeChanges })
                .then(() => {
                    return recipeControllers.getRecipeById(id);
                });
        });
    },

    // delete a recipe of specified id
    deleteRecipe: (id) => {
        return recipes().then((recipeCollection) => {
            return recipeCollection.removeOne({ _id: id })
                .then((deletedRecipeInformation) => {
                    if (deletedRecipeInformation.deletedCount === 0) {               // validating delete
                        return Promise.reject(`No recipe deleted having id ${id}`);
                    }
                });
        });
    }
};