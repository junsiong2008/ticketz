import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool searchEnabled = false;

  String? query;

  void enableSearch() {
    searchEnabled = true;
    notifyListeners();
  }

  void disableSearch() {
    searchEnabled = false;
    notifyListeners();
  }

  void setQuery(String? query) {
    this.query = query;
    notifyListeners();
  }

  void clearQuery() {
    debugPrint('Clear query called');
    query = null;
    notifyListeners();
  }
}
