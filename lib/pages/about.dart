import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonArrow(context),
        title: Text('About Us')
        
      ),

    );
  }
}