import 'package:cooking_companion/models/full_recipe_model.dart';
import 'package:flutter/material.dart';

class RecipePreviewCard extends StatefulWidget {
  RecipePreviewCard(
      {super.key, required this.recipe, required this.gotoRecipeDetails});

  final FullRecipeModel recipe;
  final Function gotoRecipeDetails;

  @override
  State<RecipePreviewCard> createState() => _RecipePreviewCardState();
}

class _RecipePreviewCardState extends State<RecipePreviewCard> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Card(
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await widget.gotoRecipeDetails();
                setState(() {
                  isLoading = false;
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              widget.recipe.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                              overflow: TextOverflow.visible,
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withAlpha(50)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              child: Text(widget.recipe.duration,
                                  style: const TextStyle()),
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            widget.recipe.description,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        IconButton.filledTonal(
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await widget.gotoRecipeDetails();
                              setState(() {
                                isLoading = false;
                              });
                            },
                            icon: const Icon(Icons.arrow_right_outlined))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.yellow[100]?.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Generating recipe details")
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
