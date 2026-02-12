import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/config.dart';

import 'utility.dart';

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
  String _node = "";

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
    _node = "a";
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 1,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(Config.margin),
              padding: EdgeInsets.all(Config.padding),
              alignment: Alignment.center,
              width: Config.maxWidth * 2,
              decoration: BoxDecoration(
                  border: BoxBorder.all(
                      color: Theme.of(context).colorScheme.outline, width: 1),
                  color: (_data[_node]["options"].length > 0)
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context).colorScheme.secondaryContainer),
              child: Text(
                _data[_node]["question"],
                softWrap: true,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  if (_data[_node]["options"].length > 0)
                    for (int i = 0; i < _data[_node]["options"].length; i++)
                      SizedBox(
                          width: Config.maxWidth * Config.optionMul,
                          child: ElevatedButton(
                            onPressed: () => next(i),
                            child: Text(
                              _data[_node]["options"][i],
                              softWrap: true,
                            ),
                          ))
                  else {
                    futureSuggestion = getSuggestion(_data[_node]["question"])
                    FutureBuilder<Suggestion>(
                      future: futureSuggestion,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!.title);
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        return const CircularProgressIndicator();
                      },
                    )
                  }
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: retry,
        tooltip: 'Retry',
        child: Icon(MdiIcons.fromString("redo")),
      ),
    );
  }
}
