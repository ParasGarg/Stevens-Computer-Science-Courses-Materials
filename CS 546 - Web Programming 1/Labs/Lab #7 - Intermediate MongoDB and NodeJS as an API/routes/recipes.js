const express = require('express');
const router = express.Router();
const data = require('../data');
const recipesData = data.recipes;


// route for getting all recipes
router.get("/", (req, res) => {
    recipesData.getAllRecipes().then((recipesList) => {
        //  checking for null value
        if (recipesList.length === 0) {
            return "No recipe found in the record";
        }

        res.json(recipesList);
    }, (err) => {
        res.status(404).json({ error: err });
    });
});


// route for getting recipe by id
router.get("/:id", (req, res) => {
    recipesData.getRecipeById(req.params.id).then((recipeItem) => {
        res.json(recipeItem);
    }).catch((err) => {
        res.status(404).json({ error: err });
    });
});


// route for posting recipe
router.post("/", (req, res) => {
    let newRecipe = req.body;

    if (!newRecipe) {
        res.status(400).json({ error: "No data provide for new recipe." });
        return;
    }

    if (!newRecipe.title) {
        res.status(400).json({ error: "No title of recipe provided." });
        return;
    }

    if (!newRecipe.ingredients) {
        res.status(400).json({ error: "No ingredients of recipe provided." });
        return;
    }

    if (!newRecipe.steps) {
        res.status(400).json({ error: "No ingredients of steps provided." });
        return;
    }

    if (!newRecipe.comments) {
        newRecipe.comments = [];
    }

    // creating new recipe
    recipesData.createRecipe(newRecipe.title, newRecipe.ingredients, newRecipe.steps, newRecipe.comments)
        .then((newRecipeItem) => {

            // validating recipe id
            if (!newRecipeItem) {
                return `Something went wrong`;
            }

            // created message
            console.log("New recipe is added!");
            res.json(newRecipeItem);

        }, (err) => {
            res.status(500).json({ error: err });
        });
});


// route for putting recipe
router.put("/:id", (req, res) => {
    let recipeUpdates = req.body;

    // checking for empty json
    if (Object.keys(recipeUpdates).length === 0) {
        res.status(400).json({ error: "Nothing to update" });
        return;
    }

    recipesData.getRecipeById(req.params.id).then(() => {
        recipesData.updateRecipe(req.params.id, recipeUpdates).then((recipeUpdated) => {
            res.json(recipeUpdated);
        }, (err) => {
            res.status(500).json({ error: err });
        });
    }).catch((err) => {
        res.status(404).json({ error: err });
    });
});


// route for deleting recipe
router.delete("/:id", (req, res) => {
    recipesData.getRecipeById(req.params.id).then(() => {
        recipesData.deleteRecipe(req.params.id).then(() => {
            res.status(200).send(`Recipe of id ${req.params.id} has been deleted`);
        }, (err) => {
            res.status(500).json({ error: err });
        });
    }).catch((err) => {
        res.status(404).json({ error: err });
    });
});

module.exports = router;