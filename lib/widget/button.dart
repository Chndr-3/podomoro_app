import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget{
  final String text;

  final VoidCallback onClicked;


  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
}) : super(key:key);

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(style: ElevatedButton.styleFrom(primary: Colors.white, padding: EdgeInsets.symmetric(horizontal:32, vertical: 16)),onPressed: onClicked, child:
      Text(text,style: const TextStyle(fontSize: 20, color: Colors.amber, fontWeight: FontWeight.bold), ));
}