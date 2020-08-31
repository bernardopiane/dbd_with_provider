import 'package:dbd_with_provider/models/data.dart';
import 'package:dbd_with_provider/models/perk.dart';
import 'package:dbd_with_provider/pages/PerkDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerkWidget extends StatelessWidget {
  final int index;
  const PerkWidget({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageSize = 72.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<Data>(
        builder: (context, data, child) {
          return Dismissible(
            key: ValueKey(data.activePerks.elementAt(index).name.trim()),
            background: Container(),
            direction: DismissDirection.vertical,
            onDismissed: (direction) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  "Removed ${data.activePerks.elementAt(index).name.trim()}",
                  style: TextStyle(color: Colors.white),
                ),
              ));
              data.removeActivePerk(index);
            },
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => PerkDetails(perk: data.activePerks.elementAt(index))),
                );
              },
              onLongPress: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.black,
                  action: SnackBarAction(
                    textColor: Colors.red,
                    label: "Remove ${data.activePerks.elementAt(index).name.trim()}",
                    onPressed: () {
                      data.removeActivePerk(index);
                    },
                  ),
                  content: SizedBox(
                    height: 32,
                  ),
                ));
              },
              child: Center(
                child: PerkImage(
                  imageSize: imageSize,
                  perk: data.activePerks.elementAt(index),
                  displayTitle: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PerkImage extends StatelessWidget {
  const PerkImage({Key key, @required this.imageSize, @required this.perk, this.displayTitle = false}) : super(key: key);

  final double imageSize;
  final Perk perk;
  final bool displayTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Image(
              image: AssetImage('images/blank.png'),
              height: imageSize,
            ),
            Image.network(
              perk.imageUrl,
              height: imageSize,
            ),
          ],
        ),
        displayTitle
            ? Text(
                perk.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.center,
              )
            : Container()
      ],
    );
  }
}
