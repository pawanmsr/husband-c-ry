import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:husbandry/config.dart';

class Suggestion {
  final String suggestion;
  final String message;

  const Suggestion({required this.suggestion, this.message = ""});

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'suggestion': String suggestion, 'message': String message} =>
        Suggestion(suggestion: suggestion, message: message),
      _ => throw const FormatException('Failed to load suggestion.'),
    };
  }
}

Future<Suggestion> getSuggestion(query) async {
  final response = await http.get(Uri.parse("${Config.api}/${query}"));

  if (response.statusCode == 200) {
    return Suggestion.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Failed to load suggestions');
  }
}
