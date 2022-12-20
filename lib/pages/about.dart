

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
        title: Text('About Us')
      ),
    );
  }
}