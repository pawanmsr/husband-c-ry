import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/config.dart';

class DAG extends StatefulWidget {
  const DAG({
    super.key,
    required this.filename,
  });

  final String filename;

  @override
  State<DAG> createState() => _DAG();
}

class _DAG extends State<DAG> {
  int _value = 0;
  String _node = "a";

  Map<String, dynamic> _data = {};

  Future<void> readJson(String filename) async {
    final String response = await rootBundle.loadString(filename);
    final Map<String, dynamic> data = await json.decode(response);
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson(widget.filename);
  }

  void next(int action) {
    setState(() {
      _value = _value + action;
      final List directions = _data[_node]["directions"];
      _node = directions[_value % directions.length];
    });
  }

  void retry() {
    setState(() {
      _value = 0;
      _node = "a";
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
          Text(_data[_node]["question"]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 4,
            children: [
              if (_data[_node]["options"].length > 0)
                for (int i = 0; i < _data[_node]["options"].length; i++)
                  ElevatedButton(
                    onPressed: () => next(i),
                    child: Text(_data[_node]["options"][i]),
                  ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: retry,
        tooltip: 'Retry',
        child: Icon(MdiIcons.fromString("redo")),
      ),
    );
  }
}
