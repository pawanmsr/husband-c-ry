import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/config.dart';

class QS extends StatefulWidget {
  const QS({
    super.key,
    required this.filename,
  });

  final String filename;

  @override
  State<QS> createState() => _QS();
}

class _QS extends State<QS> {
  int _yes = 0;
  int _size = 0;
  int _question = 0;
  Map<String, dynamic> _data = {};

  Future<void> readJson(String filename) async {
    final String response = await rootBundle.loadString(filename);
    final Map<String, dynamic> data = await json.decode(response);
    setState(() {
      _data = data;
      _size = data["questions"].length;
    });
  }

  @override
  void initState() {
    super.initState();
    readJson(widget.filename);
  }

  void retry() {
    setState(() {
      _yes = 0;
      _question = 0;
    });
  }

  void next() {
    setState(() {
      _question++;
    });
  }

  void yes() {
    setState(() {
      _yes++;
      next();
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
          children: _question < _size
              ? <Widget>[
                  Container(
                    margin: EdgeInsets.all(Config.margin),
                    padding: EdgeInsets.all(Config.padding),
                    alignment: Alignment.center,
                    width: Config.maxWidth * 2,
                    decoration: BoxDecoration(
                        border: BoxBorder.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1),
                        color: Theme.of(context).colorScheme.primaryContainer),
                    child: Text(
                      _data["questions"][_question],
                      softWrap: true,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 4,
                      children: [
                        SizedBox(
                          width: Config.maxWidth * Config.optionMul,
                          child: ElevatedButton(
                            onPressed: yes,
                            child: Text('Yes'),
                          ),
                        ),
                        SizedBox(
                          width: Config.maxWidth * Config.optionMul,
                          child: ElevatedButton(
                            onPressed: next,
                            child: Text('No'),
                          ),
                        )
                      ],
                    ),
                  )
                ]
              : <Widget>[
                  Container(
                    margin: EdgeInsets.all(Config.margin),
                    padding: EdgeInsets.all(Config.padding),
                    alignment: Alignment.center,
                    width: Config.maxWidth * 2,
                    decoration: BoxDecoration(
                        border: BoxBorder.all(
                            color: Theme.of(context).colorScheme.outline,
                            width: 1),
                        color:
                            Theme.of(context).colorScheme.secondaryContainer),
                    child: _size == _data["threshold"]
                        ? Text(
                            "${_data["neutral"]} ${(_yes * 100.0 / _size).toStringAsFixed(1)}% ${_data["percent"]}",
                            softWrap: true,
                          )
                        : _yes >= _data["threshold"]
                            ? Text(
                                _data["greater"],
                                softWrap: true,
                              )
                            : Text(
                                _data["lesser"],
                                softWrap: true,
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
