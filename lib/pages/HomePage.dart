import 'package:dbd_with_provider/models/character.dart';
import 'package:dbd_with_provider/models/data.dart';
import 'package:dbd_with_provider/models/scrapper.dart';
import 'package:dbd_with_provider/widgets/ActivePerkDisplay.dart';
import 'package:dbd_with_provider/widgets/PerkDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'CharacterDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool loaded = false;
  List<Character> activeChars = new List<Character>();

  bool failed = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      loaded = false;
      failed = false;
    });

    initiate(context).then((bool) {
      if (!bool) {
        setState(() {
          failed = true;
        });
      }
      setState(() {
        loaded = true;
      });
      var survLength = Provider.of<Data>(context, listen: false).survivors.length - 1;
      var killLength = Provider.of<Data>(context, listen: false).killers.length - 1;
      Provider.of<Data>(context, listen: false).activeSurvivors.add(Provider.of<Data>(context, listen: false).survivors.elementAt(survLength));
      Provider.of<Data>(context, listen: false).activeChars.add(Provider.of<Data>(context, listen: false).survivors.elementAt(survLength));
      Provider.of<Data>(context, listen: false).activeKillers.add(Provider.of<Data>(context, listen: false).killers.elementAt(killLength));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: [
          MaterialButton(
            shape: CircleBorder(),
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      child: ModalSliver(),
                    );
                  });
            },
            child: Icon(Icons.filter_list),
          ),
          SurvivorToggle(),
        ],
      ),
      body: SafeArea(child: _buildColumn()),
    );
  }

  Widget _buildColumn() {
    if (loaded) {
      return Column(
        children: [
          SizedBox(height: 8),
          ActivePerkDisplay(),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PerkDisplay(),
          )),
        ],
      );
    } else {
      if (failed) {
        return Center(
          child: Text("Failed to connect to the internet"),
        );
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }
  }
}

class SurvivorToggle extends StatelessWidget {
  const SurvivorToggle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 42;
    return Consumer<Data>(
      builder: (context, data, child) {
        return data.isSurvivor
            ? MaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  data.toggleSurvivor(false);
                },
                child: Image(
                  height: size,
                  image: AssetImage("images/survivor.png"),
                ),
              )
            : MaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  data.toggleSurvivor(true);
                },
                child: Image(
                  height: size,
                  image: AssetImage("images/killer.png"),
                ),
              );
      },
    );
  }
}

class ModalSliver extends StatelessWidget {
  const ModalSliver({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(
      builder: (context, data, child) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150, childAspectRatio: 0.75),
          itemCount: data.isSurvivor ? data.survivorLength : data.killersLength,
          itemBuilder: (context, index) {
            return _buildCharacter(data, index, context);
          },
        );
      },
    );
  }

  InkWell _buildCharacter(Data data, int index, BuildContext context) {
    return InkWell(
      onTap: () {
        data.toggleActiveChar(data.isSurvivor ? data.survivors.elementAt(index) : data.killers.elementAt(index));
      },
      onLongPress: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (context) => CharacterDetails(character: data.isSurvivor ? data.survivors.elementAt(index) : data.killers.elementAt(index))),
        );
      },
      child: data.isSurvivor
          ? data.survivors.elementAt(index).name != "All"
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity:
                          data.activeChars.contains(data.isSurvivor ? data.survivors.elementAt(index) : data.killers.elementAt(index)) ? 1 : 0.25,
                      child: Image.network(data.isSurvivor ? data.survivors.elementAt(index).imageUrl : data.killers.elementAt(index).imageUrl),
                    ),
                    Text(data.isSurvivor ? data.survivors.elementAt(index).name : data.killers.elementAt(index).name)
                  ],
                )
              : Container()
          : data.killers.elementAt(index).name != "All"
              ? Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity:
                          data.activeChars.contains(data.isSurvivor ? data.survivors.elementAt(index) : data.killers.elementAt(index)) ? 1 : 0.25,
                      child: Image.network(data.isSurvivor ? data.survivors.elementAt(index).imageUrl : data.killers.elementAt(index).imageUrl),
                    ),
                    Text(data.isSurvivor ? data.survivors.elementAt(index).name : data.killers.elementAt(index).name)
                  ],
                )
              : Container(),
    );
  }
}
