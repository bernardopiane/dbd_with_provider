import 'package:dbd_with_provider/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BlankPerk.dart';
import 'PerkWidget.dart';

class ActivePerkDisplay extends StatelessWidget {
  ActivePerkDisplay();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Consumer<Data>(
          builder: (context, data, child) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: data.activePerks.length > 0 ? PerkWidget(index: 0) : BlankPerk()),
                Expanded(child: data.activePerks.length > 1 ? PerkWidget(index: 1) : BlankPerk()),
                Expanded(child: data.activePerks.length > 2 ? PerkWidget(index: 2) : BlankPerk()),
                Expanded(child: data.activePerks.length > 3 ? PerkWidget(index: 3) : BlankPerk()),
              ],
            );
          },
        ),
      ),
    );
  }
}


