import 'package:flutter/material.dart';

class ListTextFieldInputs extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool state){
    _isLoading = state;
  }

  void clearValues() {
    notifyListeners();
  }
}