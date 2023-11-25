import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_globals.dart' as gbl;

class UiWidgets {
  Widget dropDownSelec(List<String> l) {
    String dropdownValue = l.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.blueGrey,
      ),
      dropdownColor: gbl.lightColor,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        // add here a valuenotifier, because can't use etState
      },
      items: l.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
                fontSize: 15,
                letterSpacing: 3,
                fontFamily: GoogleFonts.raleway().fontFamily),
          ),
        );
      }).toList(),
    );
  }

  Widget basicMaterialButtom(
      dynamic fun, String label, Color c, context, double minWidth) {
    return MaterialButton(
      onPressed: fun,
      elevation: 4,
      color: c,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      splashColor: Colors.white12,
      onLongPress: null,
      minWidth: minWidth,
      child: Text(
        label,
        style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            letterSpacing: 3,
            fontFamily: GoogleFonts.raleway().fontFamily),
      ),
    );
  }

  Widget basicTextForm(String lable, String hint,
      TextEditingController controller, TextInputType type) {
    return TextField(
      keyboardType: type,
      controller: controller,
      textAlign: TextAlign.start,
      maxLines: 1,
      style: const TextStyle(
        fontSize: 15,
        letterSpacing: 3,
      ),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.blueGrey,
              width: 1,
            ),
          ),
          labelText: lable,
          labelStyle:
              TextStyle(fontSize: 15, color: gbl.darkColor, letterSpacing: 3),
          hintText: hint,
          hintStyle:
              TextStyle(fontSize: 14, color: gbl.darkColor, letterSpacing: 3),
          filled: true,
          fillColor: const Color(0x00ffffff)),
    );
  }

  void showMessage(String label, context) {
    final snack = SnackBar(
      content: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(letterSpacing: 3, fontSize: 15),
      ),
      backgroundColor: gbl.redMy,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
