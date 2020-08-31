import 'package:dbd_with_provider/models/data.dart';
import 'package:dbd_with_provider/models/perk.dart';
import 'package:dbd_with_provider/pages/PerkDetails.dart';
import 'package:dbd_with_provider/widgets/PerkWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerkDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Consumer<Data>(
        builder: (context, data, child) {
          List<Perk> perks;
          if (data.isSurvivor)
            perks = data.perkList.where((element) => element.isSurvivor).toList();
          else
            perks = data.perkList.where((element) => !element.isSurvivor).toList();
          perks = perks.where((element) => data.activeChars.contains(element.character)).toList();
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
            // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: perks.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  data.addActivePerk(perks.elementAt(index));
                },
                onLongPress: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PerkDetails(perk: perks.elementAt(index))),
                  );
                },
                child: PerkImage(
                  imageSize: 64,
                  perk: perks.elementAt(index),
                  displayTitle: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
