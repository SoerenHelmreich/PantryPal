class PromptSettings {
  String recipeCreationSystemPrompt =
      """You are a professional chef. The user wants to cook something, but only has a few ingredients available. Please think of a meal that the user can make create. You don't have to use all the ingredients that the user has available, but you can add other ingredents the user might have to buy. You will also get a list of recipes that you have already recommended. Please try to craete something different nwo.
Please keep dietary requirements in mind when they are stated in the description. You create a fitting title, a short description (1-2 sentences) and give an estimated preparation duration. Please return your answer in a json object that can be displayed in a web application.""";

  String recipeDetailsSystemPrompt =
      """You are a professional chef. The user wants to cook something, but only has a few ingredients available. You have already recommended four recipes to the user, and they have selected one of them. You will get the description and the title as a prompt to create the full recipe details. 
You give a list of ingredients needed (in the metric system), add a List of instructions, add the nutritional info for one serving (including calories, fat, carbohydrates, protein) and give a list of tips that might make it easier to cook the dish or give relevant side information.
Please keep dietary requirements in mind when they are stated in the description. Feel free to add other ingredients the user might have to buy. Please return your answer in a json object that can be displayed in a web application.""";

  Object recipeCreationJsonSchema = {
    "type": "json_schema",
    "json_schema": {
      "name": "DetailedRecipe",
      "schema": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "The title of the recipe."
          },
          "description": {
            "type": "string",
            "description": "A brief description of the recipe."
          },
          "duration": {
            "type": "string",
            "description":
                "The duration to prepare the recipe, expressed as a string (e.g., '30 minutes')."
          },
        },
        "required": [
          "title",
          "description",
          "duration",
        ],
        "strict": true,
        "additionalProperties": false
      }
    },
  };

  Object recipeDetailsJsonSchema = {
    "type": "json_schema",
    "json_schema": {
      "name": "DetailedRecipe",
      "schema": {
        "type": "object",
        "properties": {
          "title": {
            "type": "string",
            "description": "The title of the recipe."
          },
          "description": {
            "type": "string",
            "description": "A brief description of the recipe."
          },
          "duration": {
            "type": "string",
            "description":
                "The duration to prepare the recipe, expressed as a string (e.g., '30 minutes')."
          },
          "ingredients": {
            "type": "array",
            "items": {
              "type": "object",
              "properties": {
                "name": {
                  "type": "string",
                  "description": "The name of the ingredient"
                },
                "amount": {
                  "type": "string",
                  "description":
                      "The amount of the ingredient. Prefer metric over imperial messurements"
                }
              }
            },
          },
          "instructions": {
            "type": "array",
            "items": {"type": "string"},
            "description": "Step-by-step instructions to prepare the recipe."
          },
          "NutritionalInfo": {
            "type": "object",
            "properties": {
              "calories": {
                "type": "number",
                "description": "The amount of calories in the recipe."
              },
              "fat": {
                "type": "number",
                "description": "The amount of fat in the recipe (grams)."
              },
              "carbohydrates": {
                "type": "number",
                "description":
                    "The amount of carbohydrates in the recipe (grams)."
              },
              "protein": {
                "type": "number",
                "description": "The amount of protein in the recipe (grams)."
              }
            },
            "additionalProperties": false,
            "required": ["calories", "fat", "carbohydrates", "protein"],
            "description": "Nutritional information for the recipe."
          },
          "tips": {
            "type": "array",
            "items": {"type": "string"},
            "description": "Optional cooking tips or recommendations."
          }
        },
        "required": [
          "title",
          "description",
          "duration",
          "ingredients",
          "instructions",
          "NutritionalInfo",
          "tips"
        ],
        "strict": true,
        "additionalProperties": false
      }
    },
  };
}
