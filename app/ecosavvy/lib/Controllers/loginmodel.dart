// login_model.dart
import 'package:flutter/foundation.dart';

class LoginModel extends ChangeNotifier {
  bool _isLoading = false;
  String _errorMessage = "";

  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }
}
