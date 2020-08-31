import 'package:flutter/foundation.dart';

import 'character.dart';

class Perk with ChangeNotifier {
  String _imageUrl;
  String _name;
  String _description;
  Character _character;
  bool _isSurvivor;

  Perk.noImage(
      this._name, this._description, this._character, this._isSurvivor);

  Perk(this._imageUrl, this._name, this._description, this._character,
      this._isSurvivor);

  Perk.minimum(this._name, this._description, this._isSurvivor);

  bool get isSurvivor => _isSurvivor;

  set isSurvivor(bool value) {
    _isSurvivor = value;
    notifyListeners();
  }

  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  Character get character => _character;

  set character(Character value) {
    _character = value;
    notifyListeners();
  }

  String get description => _description;

  set description(String value) {
    _description = value;
    notifyListeners();
  }
}
