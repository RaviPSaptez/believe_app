import 'package:flutter/foundation.dart';

class TextChanger with ChangeNotifier, DiagnosticableTreeMixin {
  String _addClient = "";
  String get addClient => _addClient;

  void setAddClient(String data) {
    _addClient = data;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('addClient', addClient));
  }

}