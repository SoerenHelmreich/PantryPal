import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black, offset: Offset(4, 4))
                ]),
            child: InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                await widget.gotoRecipeDetails();
                setState(() {
                  isLoading = false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //Recipe title
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
                            //Duration container
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(),
                                  color: Colors.amber),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                child: Text(widget.recipe.duration,
                                    style: monoStyleButtonSmall),
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
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: ShapeDecoration(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingAnimationWidget.progressiveDots(
                        color: const Color(0xff202020), size: 40),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("Generating recipe details",
                        style: monoStyleSecondary),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
