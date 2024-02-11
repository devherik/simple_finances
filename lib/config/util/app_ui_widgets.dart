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

  Widget iconButtom(dynamic function, String label, IconData icon,
      BuildContext parentContext) {
    return SizedBox(
      width: MediaQuery.of(parentContext).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              icon,
              color: gbl.primaryLight,
            ),
          ),
          Expanded(
            flex: 1,
            child: MaterialButton(
                padding: const EdgeInsets.symmetric(vertical: 18),
                color: Colors.transparent.withOpacity(.1),
                minWidth: MediaQuery.of(parentContext).size.width,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                onPressed: function,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(label,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 15,
                          color: gbl.secondaryLight,
                          letterSpacing: 3)),
                )),
          ),
        ],
      ),
    );
  }

  Widget basicTextForm(String lable, IconData icon,
      TextEditingController controller, TextInputType type) {
    return TextField(
      keyboardType: type,
      controller: controller,
      textAlign: TextAlign.start,
      maxLines: 1,
      style:
          TextStyle(fontSize: 15, letterSpacing: 3, color: gbl.secondaryLight),
      decoration: InputDecoration(
          icon: Icon(icon),
          iconColor: gbl.primaryLight,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          labelText: lable,
          labelStyle: TextStyle(
              fontSize: 15, color: gbl.secondaryLight, letterSpacing: 3),
          filled: true,
          fillColor: Colors.transparent.withOpacity(.1)),
    );
  }

  Widget basicNumberForm(String lable, IconData icon,
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
          icon: Icon(icon),
          iconColor: gbl.primaryLight,
          prefixText: 'R\$',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: .1,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: gbl.primaryLight,
              width: 1,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
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
          fillColor: Colors.transparent.withOpacity(.2)),
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
      backgroundColor: Colors.transparent.withOpacity(.1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }
}
