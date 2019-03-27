import 'package:flutter/material.dart';

class CompleteWidget extends StatelessWidget{
  
  final Color color;

  CompleteWidget(this.color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: color,
    );
  }

}