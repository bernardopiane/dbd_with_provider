import 'package:flutter/material.dart';

class BlankPerk extends StatelessWidget {
  const BlankPerk({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double padding = 8;
    const double textSize = 24;
    return Padding(
      padding: const EdgeInsets.only(top: padding, left: padding, right: padding, bottom: textSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Image.asset(
            "images/blank.png",
            height: 72,
          ),
        ],
      ),
    );
  }
}