import 'package:flutter/material.dart';

class pageColors
{
    Color backgroundColor = const Color(0xFF996DC7);

    backgroundGradient(){
        return new BoxDecoration(
            gradient: new LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                    Color(0xFF0093E9),
                    Color(0xff80D0C7),
                ]
            )
        );
    }

    appBarGradient(){
      return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0093E9),
                  Color(0xff80D0C7),
                ]
            ),
          )
      );
    }

    textFormFieldDecoration(String label){
      return InputDecoration(
        //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )
      );
    }
}