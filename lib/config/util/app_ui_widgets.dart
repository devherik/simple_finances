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
      dropdownColor: gbl.primaryLight,
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

  Widget basicMaterialButtom(dynamic fun, String label, Color backColor,
      Color textColor, context, double minWidth) {
    return MaterialButton(
      onPressed: fun,
      elevation: 4,
      color: backColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      splashColor: textColor,
      onLongPress: null,
      minWidth: minWidth,
      child: Text(
        label,
        style: TextStyle(
            color: textColor,
            fontSize: 15,
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
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
      style:
          TextStyle(fontSize: 15, letterSpacing: 3, color: gbl.secondaryLight),
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          labelText: lable,
          labelStyle: TextStyle(
              fontSize: 15, color: gbl.secondaryLight, letterSpacing: 3),
          hintText: hint,
          hintStyle: TextStyle(
              fontSize: 14, color: gbl.secondaryLight, letterSpacing: 3),
          filled: true,
          fillColor: const Color(0x00ffffff)),
    );
  }

  Widget basicNumberForm(String lable, String hint,
      TextEditingController controller, TextInputType type) {
    return TextField(
      textInputAction: TextInputAction.next,
      keyboardType: type,
      controller: controller,
      textAlign: TextAlign.start,
      maxLines: 1,
      style:
          TextStyle(fontSize: 15, letterSpacing: 3, color: gbl.secondaryLight),
      decoration: InputDecoration(
          prefixText: 'R\$',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          labelText: lable,
          labelStyle: TextStyle(
              fontSize: 15, color: gbl.secondaryLight, letterSpacing: 3),
          hintStyle: TextStyle(
              fontSize: 14, color: gbl.secondaryLight, letterSpacing: 3),
          filled: true,
          fillColor: const Color(0x00ffffff)),
    );
  }

  void showMessage(String label, context) {
    final snack = SnackBar(
      duration: const Duration(seconds: 1),
      content: Text(
        label,
        textAlign: TextAlign.center,
        style:
            TextStyle(letterSpacing: 3, fontSize: 15, color: gbl.primaryLight),
      ),
      backgroundColor: gbl.primaryDark,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
