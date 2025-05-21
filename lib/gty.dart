import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/config.dart';

class GTY extends StatefulWidget {
  const GTY({
    super.key,
    this.yeses = 0,
    this.nos = 0,
  });

  final int yeses;
  final int nos;

  @override
  State<GTY> createState() => _GTY();
}

class _GTY extends State<GTY> {
  int _question = 1;

  void next() {
    setState(() {
      _question++;
      _question = max(_question, Config.gtynq);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(MdiIcons.fromString("arrow-left")),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(Config.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 1,
        children: <Widget>[
          Text("Add question text from external data."),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 1,
            children: [],
          )
        ],
      ),
    );
  }
}
