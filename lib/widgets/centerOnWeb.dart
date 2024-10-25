import 'package:flutter/material.dart';

class ConstrainedContainer extends StatelessWidget {
  final Widget child;

  const ConstrainedContainer({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 800), // Set your max width here
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
          ),
          child: child,
        ),
      ),
    );
  }
}
