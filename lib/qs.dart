import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/config.dart';

class QS extends StatefulWidget {
  const QS({
    super.key,
    this.yeses = 0,
    this.nos = 0,
  });

  final int yeses;
  final int nos;

  @override
  State<QS> createState() => _QS();
}

class _QS extends State<QS> {
  int _question = 1;

  void next() {
    setState(() {
      _question++;
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
