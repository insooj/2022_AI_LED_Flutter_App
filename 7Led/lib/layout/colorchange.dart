import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorChange extends StatefulWidget {
  @override
  ColorChangeState createState() => ColorChangeState();
}

Color _color = Color.fromARGB(255, 0, 0, 0);
int RedColor() {
  int r_color = _color.red;
  print(r_color);
  return r_color;
}

int BlueColor() {
  int b_color = _color.blue;
  print(b_color);
  return b_color;
}

int GreenColor() {
  int g_color = _color.green;
  print(g_color);
  return g_color;
}

class ColorChangeState extends State<ColorChange> {
  final referenceDatase = FirebaseDatabase.instance;
  Color RGBColor(Color lastcolor) {
    Color lastcolor = _color;
    int r_color = _color.red;
    int g_color = _color.green;
    int b_color = _color.blue;
    print('RED:$r_color, GREEN:$g_color, BLUE:$b_color');
    Color changecolor = Color.fromARGB(1, r_color, g_color, b_color);
    lastcolor = changecolor;
    return lastcolor;
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatase.reference();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xEC3C7DFF),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: AlignmentDirectional(-0.25, 0),
          child: Text(
            'AI SMART LED LIGHT',
            style:
                TextStyle(fontFamily: 'Jua', fontSize: 20, color: Colors.white),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: _color,
                child: const Center(
                  child: Text(
                    "원하는 조명색을 선택하세요!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ColorPicker(
                pickerColor: _color,
                onColorChanged: (Color color) {
                  setState(() {
                    _color = color;
                    print(_color);
                    RedColor();
                  });
                },
                pickerAreaHeightPercent: 0.9,
                enableAlpha: true,
                paletteType: PaletteType.hsvWithHue,
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 20),
                child: ElevatedButton(
                  onPressed: () {
                    ref.child("LED STATE").set(6).asStream();
                    ref
                        .child('Led Color')
                        .child('Blue')
                        .set(BlueColor())
                        .asStream();
                    ref
                        .child('Led Color')
                        .child('Green')
                        .set(GreenColor())
                        .asStream();
                    ref
                        .child('Led Color')
                        .child('Red')
                        .set(RedColor())
                        .asStream();
                  },
                  child: Text('조명색 변경',
                      style: TextStyle(
                        fontFamily: 'Jua',
                        fontSize: 16,
                        color: const Color(0xFF9D99F8),
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 2,
                    minimumSize: Size(100, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
