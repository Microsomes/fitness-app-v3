import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerMicro extends StatefulWidget {
  
  Function onChange;

  ColorPickerMicro({this.onChange});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ColorPickerMicroState();
  }
}

class ColorPickerMicroState extends State<ColorPickerMicro> {
  bool openColor = false;


  Color prevCol=Colors.red;
  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
          onTap: () {
            print("open color menu");
            setState(() {
              openColor = true;
            });
          },
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: prevCol,
                ),
                height: 30,
                width: 60,
              ),
              openColor == true
                  ? Container(
                      color: Colors.white,
                      child: ColorPicker(
                        pickerColor: Colors.red,
                        onColorChanged: (col) {
                          //determines what happens when color
                          print(col);
                          widget.onChange(col);
                          //call method to let color changer know
                        
                        },
                      ))
                  : Container()
            ],
          )),
    );
  }
}
