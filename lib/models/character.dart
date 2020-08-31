import 'package:dbd_with_provider/models/perk.dart';

class Character {
  String imageUrl;
  String name;
  List<Perk> perks = new List<Perk>();
  bool isSurvivor;

  Character(this.name);

  Character.withSurvivor(this.name, this.isSurvivor);

  Character.withImage(this.imageUrl, this.name, this.isSurvivor);

  Character.full(this.imageUrl, this.name, this.perks, this.isSurvivor);

  addPerk(Perk perk) {
    perks.add(perk);
  }
}
