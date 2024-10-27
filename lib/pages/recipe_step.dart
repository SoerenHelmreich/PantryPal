import 'package:flutter/material.dart';
import 'package:pantry_pal/models/full_recipe_model.dart';
import 'package:pantry_pal/utils/constants.dart';
import 'package:pantry_pal/widgets/centerOnWeb.dart';
import 'package:simple_animated_button/elevated_layer_button.dart';

class RecipeStep extends StatefulWidget {
  RecipeStep({super.key, required this.fullRecipe, this.stepNumber = 0});
  final FullRecipeModel fullRecipe;
  int stepNumber = 0;

  @override
  State<RecipeStep> createState() => _RecipeStepState();
}

class _RecipeStepState extends State<RecipeStep> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedContainer(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: ElevatedLayerButton(
              onClick: () => Navigator.of(context).pop(),
              buttonHeight: 50,
              buttonWidth: 50,
              animationDuration: const Duration(milliseconds: 200),
              animationCurve: Curves.ease,
              topDecoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
              topLayerChild: const Icon(Icons.arrow_back),
              baseDecoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(60)),
            ),
          ),
          scrolledUnderElevation: 0.0,
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.fullRecipe.title, style: monoStyleTitle),
              Column(children: [
                Text(
                    "${widget.stepNumber + 1} of ${widget.fullRecipe.instructions.length}",
                    style: monoStyleButtonSmall),
                Text(
                  widget.fullRecipe.instructions[widget.stepNumber],
                  style: const TextStyle(fontSize: 28),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (widget.stepNumber != 0)
                      ? ElevatedLayerButton(
                          onClick: () {
                            if (widget.stepNumber > 0) {
                              setState(() {
                                widget.stepNumber = widget.stepNumber - 1;
                              });
                            }
                          },
                          buttonHeight: 70,
                          buttonWidth: 70,
                          animationDuration: const Duration(milliseconds: 200),
                          animationCurve: Curves.ease,
                          topDecoration: BoxDecoration(
                              color: Colors.amber,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          topLayerChild: const Icon(Icons.arrow_back_ios_new),
                          baseDecoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      : SizedBox(width: 70, height: 70),
                  !endReached()
                      ? ElevatedLayerButton(
                          onClick: () {
                            if (widget.stepNumber <
                                widget.fullRecipe.instructions.length - 1) {
                              setState(() {
                                widget.stepNumber = widget.stepNumber + 1;
                              });
                            }
                          },
                          buttonHeight: 70,
                          buttonWidth: 70,
                          animationDuration: const Duration(milliseconds: 200),
                          animationCurve: Curves.ease,
                          topDecoration: BoxDecoration(
                              color: Colors.amber,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          topLayerChild: const Icon(Icons.arrow_forward_ios),
                          baseDecoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      : SizedBox(width: 70, height: 70),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool endReached() {
    return (widget.stepNumber + 1) == widget.fullRecipe.instructions.length;
  }
}
