import 'package:dbd_with_provider/models/perk.dart';
import 'package:flutter/foundation.dart';

import 'character.dart';

class Data extends ChangeNotifier {
  List<Perk> perkList = new List<Perk>();
  List<Character> charList = new List<Character>();
  //
  List<Perk> activePerks = new List<Perk>();
  //
  List<List<Perk>> historyList = new List<List<Perk>>();
  //
  List<List<Perk>> savedList = new List<List<Perk>>();
  //
  List<Character> activeChars = new List<Character>();
  //
  bool isSurvivor = true;
  //Survivors
  List<Character> activeSurvivors = new List<Character>();
  List<Perk> activeSurvivorPerks = new List<Perk>();
  //Killers
  List<Character> activeKillers = new List<Character>();
  List<Perk> activeKillerPerks = new List<Perk>();

  void toggleActiveChar(Character c){
    if(activeChars.contains(c))
      activeChars.remove(c);
    else
      activeChars.add(c);
    notifyListeners();
  }

  void toggleSurvivor(bool value) {
    if (isSurvivor) {
      activeSurvivors = activeChars;
      activeSurvivorPerks = activePerks;
    } else {
      activeKillers = activeChars;
      activeKillerPerks = activePerks;
    }
    isSurvivor = value;
    setActiveChars();
    notifyListeners();
  }

  void setActiveChars() {
    if (isSurvivor) {
      activeChars = activeSurvivors;
      activePerks = activeSurvivorPerks;
    } else {
      activeChars = activeKillers;
      activePerks = activeKillerPerks;
    }
  }

  int getSurvivorPerksLength(){
    return perkList.where((element) => element.isSurvivor).length;
  }

  int getKillerPerksLength(){
    return perkList.where((element) => !element.isSurvivor).length;
  }


  int get survivorLength {
    List<Character> survivors = charList.where((element) => element.isSurvivor).toList();
    return survivors.length;
  }

  List<Character> get survivors {
    return charList.where((element) => element.isSurvivor).toList();
  }

  int get killersLength {
    List<Character> killers = charList.where((element) => !element.isSurvivor).toList();
    return killers.length;
  }

  List<Character> get killers {
    return charList.where((element) => !element.isSurvivor).toList();
  }

  void addCharacter(Character c) {
    charList.add(c);
    notifyListeners();
  }

  void addPerk(Perk p) {
    perkList.add(p);
    notifyListeners();
  }

  void addToHistory(List<Perk> perks) {
    historyList.add(perks);
    notifyListeners();
  }

  void addSaved(List<Perk> perks) {
    savedList.add(perks);
    notifyListeners();
  }

  void addActiveChar(Character c) {
    activeChars.add(c);
    notifyListeners();
  }

  void removeActiveChar(Character c) {
    activeChars.remove(c);
    notifyListeners();
  }

  void addActivePerk(Perk p) {
    if (activePerks.contains(p)) return null;
    if (activePerks.length >= 4) activePerks.removeAt(0);
    activePerks.add(p);
    notifyListeners();
  }

  void removeActivePerk(int index) {
    activePerks.removeAt(index);
    notifyListeners();
  }
}
