class Config {
  const Config();

  static const String title = "Husband(c)ry";
  static const String config = "assets/config.json";
  // TODO: Load configuration from json.

  // Directed Acyclic Graph
  static const List dagTitles = ["General", "Programming"];
  static const List dagSubtitles = [
    "Everyday conversation.",
    "Let's talk about programming.",
  ];
  static const List dagIcons = ["chat", "file-code"];
  static const List dagFiles = [
    "assets/conversations/g1.json",
    "assets/conversations/g2.json",
  ];

  // Linked List
  static const List linearTitles = [
    "Conflict Avoider",
    "Validator",
    "Volatile",
  ];

  static const List linearSubtitles = [
    "Do you avoid conflicts?",
    "How much validator are you?",
    "How much volatile are you?",
  ];

  static const List linearIcons = [
    "list-status",
    "list-status",
    "list-status",
  ];

  static const String api = "http://127.0.0.1:8000/agent/rekha/single"

  static const List linearFiles = [
    "assets/books/b1.json",
    "assets/books/b2.1.json",
    "assets/books/b2.2.json",
  ];

  // UI //
  static const double margin = 8.0;
  static const double padding = 8.0;
  static const double maxWidth = 400;
  static const double optionMul = 3 / 5;
}
