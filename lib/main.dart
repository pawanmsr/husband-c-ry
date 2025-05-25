import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:english_words/english_words.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:husbandry/qs.dart';
import 'package:husbandry/dag.dart';
import 'package:husbandry/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: Config.title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: Config.title),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: Config.maxWidth,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(Config.padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 1,
              children: <Widget>[
                for (int i = 0; i < Config.dagTitles.length; i++)
                  Card(
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DAG(filename: Config.dagFiles[i])));
                      },
                      child: ListTile(
                        leading: Icon(MdiIcons.fromString(Config.dagIcons[i])),
                        title: Text(Config.dagTitles[i]),
                        subtitle: Text(
                          Config.dagSubtitles[i],
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                for (int i = 0; i < Config.linearTitles.length; i++)
                  Card(
                    elevation: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QS(filename: Config.linearFiles[i])));
                      },
                      child: ListTile(
                        leading:
                            Icon(MdiIcons.fromString(Config.linearIcons[i])),
                        title: Text(Config.linearTitles[i]),
                        subtitle: Text(
                          Config.linearSubtitles[i],
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
