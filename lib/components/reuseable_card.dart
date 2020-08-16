import 'package:flutter/material.dart';

class ReuseableCard extends StatelessWidget {
  ReuseableCard({@required this.colour, this.cardChild});


  final Color colour;
  final Widget cardChild;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          child: cardChild,
          margin: EdgeInsets.all(25.0),
          padding: EdgeInsets.all(25.0),
          decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 6.0,
                ),
              ]
          ),
        )
    );
  }
}