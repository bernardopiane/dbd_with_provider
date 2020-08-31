import 'package:dbd_with_provider/models/character.dart';
import 'package:dbd_with_provider/models/perk.dart';
import 'package:dbd_with_provider/widgets/PerkWidget.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({Key key, this.character}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name.trim()),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Center(child: Text(character.name)),
            Image.network(
              character.imageUrl,
              height: 192,
            ),
            _buildPerkDetails(context),
          ],
        ),
      ),
    );
  }

  _buildPerkDetails(context) {
    List<Widget> perks = new List<Widget>();
    character.perks.forEach((element) {
      Widget widget = Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: PerkImage(
          perk: element,
          imageSize: 64,
          displayTitle: true,
        ),
      );
      perks.add(widget);
    });
    return DefaultTabController(
      length: 3,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBar(
            tabs: perks,
          ),
          Container(
            height: 256,
            child: TabBarView(
              children: [
                CardPerkDescription(perk: character.perks.elementAt(0)),
                CardPerkDescription(perk: character.perks.elementAt(1)),
                CardPerkDescription(perk: character.perks.elementAt(2)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardPerkDescription extends StatelessWidget {
  const CardPerkDescription({
    Key key,
    @required this.perk,
  }) : super(key: key);

  final Perk perk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(16),
          child: Text(perk.description),
        ),
      ),
    );
  }
}
