import 'package:dbd_with_provider/models/data.dart';
import 'package:dbd_with_provider/models/perk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
//import 'package:html/dom.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'character.dart';

Future<bool> initiate(BuildContext context) async {
//  dataClass = new DataClass();
  var dataClass = Provider.of<Data>(context, listen: false);
  print("Scrapping");
  var client = Client();
  Response res;
  var response;
  try {
    res = await client.get("https://deadbydaylight.gamepedia.com/Perks");
    response = await http.get("https://deadbydaylight.gamepedia.com/Perks");
  } catch (e) {
    return false;
  }
  if (res.statusCode == 200) {
    var data = parse(res.body);
    var row = data.body.querySelectorAll("table.wikitable.sortable > tbody > tr");
    var isSurvivor = true;

    List<String> names = new List();

    /////////////////////////
    //Criar Character

    row.forEach((row) {
      var perkRow = row.querySelectorAll("th");
      var charName;

//      print("Row: ${row.innerHtml}");

      if (perkRow[2].querySelector("a") != null) {
        charName = perkRow[2].querySelector("a").attributes["title"].trim();
        names.add(charName);
      }
    });

    names = names.toSet().toList();

    dataClass.charList.clear();
    dataClass.perkList.clear();

    names.forEach((name) {
      dataClass.addCharacter(new Character(name));
    });

    dataClass.addCharacter(Character.withSurvivor("All", true));
    dataClass.addCharacter(Character.withSurvivor("All", false));

    row.forEach((row) {
      if (row.querySelector("th").className != "unsortable") {
        var cell = row.querySelectorAll("th");
        cell.forEach((d) {
          if (d.text.trim() == "A Nurse's Calling") {
            isSurvivor = false;
          }
        });

        var perkRow = row.querySelectorAll("th");
        if (perkRow[2].querySelector("a") != null) {
          var charName = perkRow[2].querySelector("a").attributes["title"];
          Character character =
//              charList.firstWhere((item) => item.name == charName.trim());
              dataClass.charList.firstWhere((item) => item.name == charName.trim());

          var perkName = row.querySelectorAll("th");

          var charImage;
          if (perkName[2].querySelector("img") != null) {
            charImage = perkName[2].querySelector("img")?.attributes["srcset"].split(",");
            charImage = charImage[1].split(" ");
            character.imageUrl = charImage[1];
          }

          var perkData = row.querySelectorAll("td");
          var str = row.querySelector("th > a > img").attributes["srcset"].split(",");
          str = str[1].split(" ");
//          dataClass.perkList.add(Perk(str[1], perkName[1].text, perkData[0].text.trim(),
//              character, isSurvivor));
          dataClass.addPerk(Perk(str[1], perkName[1].text, perkData[0].text.replaceAll("\n", "\n\n").trim(), character, isSurvivor));
//          perkList.add(Perk(str[1], perkName[1].text, perkData[0].text.trim(),
//              character, isSurvivor));
          character.addPerk(Perk(str[1], perkName[1].text, perkData[0].text.replaceAll("\n", "\n\n").trim(), character, isSurvivor));
          character.isSurvivor = isSurvivor;
        } else {
          List<Character> list = dataClass.charList.where((item) => item.name.trim() == "All").toList();
//              charList.where((item) => item.name.trim() == "All").toList();
          Character character = list.firstWhere((item) => item.isSurvivor == isSurvivor);

          var perkName = row.querySelectorAll("th");
          var perkData = row.querySelectorAll("td");
          var str = row.querySelector("th > a > img").attributes["srcset"].split(",");
          str = str[1].split(" ");
//          dataClass.perkList.add(Perk(str[1], perkName[1].text, perkData[0].text.trim(),
          dataClass.addPerk(Perk(
              str[1],
              perkName[1].text,
              perkData[0].text.replaceAll("\n", "\n\n").trim(),
//          perkList.add(Perk(str[1], perkName[1].text, perkData[0].text.trim(),
              character,
              isSurvivor));
          character.addPerk(Perk(str[1], perkName[1].text, perkData[0].text.replaceAll("\n", "\n\n").trim(), character, isSurvivor));
          character.isSurvivor = isSurvivor;
          character.imageUrl = "";
        }
      }
    });

//    await db.rawDelete("DELETE FROM perks WHERE name = ?", ['*']);
//    await db.rawDelete("DELETE FROM characters WHERE name = ?", ['*']);

//    dataClass.perkList.forEach((perk) async {
//      var isSurvivor = perk.isSurvivor ? 1 : 0;
//      await db.rawInsert(
//          "INSERT INTO perks(imageUrl, name, description, isSurvivor, character) VALUES (?, ?, ?, ?, ?)",
//          [
//            perk.imageUrl.trim(),
//            perk.name.trim(),
//            perk.description.trim(),
//            isSurvivor,
//            perk.character.name
//          ]);
//    });

    dataClass.charList.forEach((char) async {
      var perksNames;
//      var isSurvivor = char.isSurvivor ? 1 : 0;
      char.perks.forEach((perk) {
        if (perksNames == null)
          perksNames = perk.name + ",";
        else
          perksNames = perksNames + perk.name + ",";
      });
      perksNames = perksNames.trim();
//      var image = char.imageUrl != null ? char.imageUrl.trim() : "";
//      await db.rawInsert(
//          "INSERT INTO characters(imageUrl, name, isSurvivor, perks) VALUES (?, ?, ?, ?)",
//          [image, char.name.trim(), isSurvivor, perksNames.trim()]);
//      print("${char.name} - URL: ${char.imageUrl}");
    });
  } else {
    print("Request failed with status: ${response.statusCode}.");
    return false;
  }

  print("Finished");
  return true;
}
