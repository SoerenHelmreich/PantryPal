import 'package:flutter/material.dart';
import 'package:pantry_pal/models/nutri_info_model.dart';
import 'package:pantry_pal/utils/constants.dart';

class NutritionCard extends StatefulWidget {
  const NutritionCard({super.key, required this.nutrients});

  final NutriinfoModel nutrients;

  @override
  State<NutritionCard> createState() => _NutritionCardState();
}

class _NutritionCardState extends State<NutritionCard> {
  bool cardExtended = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.amber,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black, offset: Offset(4, 4))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => setState(() {
                cardExtended = !cardExtended;
              }),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nutritional Information', style: monoStyleButtonBig),
                    !cardExtended
                        ? Icon(Icons.expand_more_sharp, size: 32)
                        : Icon(Icons.expand_less_sharp, size: 32),
                  ],
                ),
              ),
            ),
          ),
          if (cardExtended) nutrientsContent(),
        ],
      ),
    );
  }

  Widget nutrientsContent() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          border:
              TableBorder(horizontalInside: BorderSide(color: Colors.black)),
          children: [
            TableRow(
              children: [
                Text(
                  "Calories",
                  style: nutrientsTableText,
                ),
                Text(
                  "${widget.nutrients.calories}",
                  style: nutrientsTableText,
                )
              ],
            ),
            TableRow(
              children: [
                Text(
                  "Fat",
                  style: nutrientsTableText,
                ),
                Text(
                  "${widget.nutrients.fat} g",
                  style: nutrientsTableText,
                )
              ],
            ),
            TableRow(
              children: [
                Text(
                  "Carbohydrates",
                  style: nutrientsTableText,
                ),
                Text(
                  "${widget.nutrients.carbohydrates} g",
                  style: nutrientsTableText,
                )
              ],
            ),
            TableRow(
              children: [
                Text(
                  "Protein",
                  style: nutrientsTableText,
                ),
                Text(
                  "${widget.nutrients.protein} g",
                  style: nutrientsTableText,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
