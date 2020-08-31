import 'package:dbd_with_provider/models/character.dart';
import 'package:dbd_with_provider/models/perk.dart';
import 'package:dbd_with_provider/pages/CharacterDetails.dart';
import 'package:dbd_with_provider/widgets/PerkWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PerkDetails extends StatelessWidget {
  final Perk perk;

  const PerkDetails({Key key, this.perk}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(perk.name.trim()),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            Center(child: Text(perk.name)),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PerkImage(imageSize: 128, perk: perk),
                ),
                _buildPerk(context, perk.character),
              ],
            ),
            SizedBox(height: 32),
            Text(perk.description.trim()),
          ],
        ),
      ),
    );
  }

  _buildPerk(BuildContext context, Character character) {
    if (character.name != "All") {
      return Expanded(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => CharacterDetails(character: perk.character)),
            );
          },
          child: Column(
            children: [
              Image.network(perk.character.imageUrl),
              Text(perk.character.name),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
