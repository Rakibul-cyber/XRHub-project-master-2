import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/pages/rfis/rfis_form.dart';

class RFIsPage extends StatelessWidget {
  const RFIsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "RFIs",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  AntDesign.menuunfold,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 8,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                Icon(
                  FontAwesome.caret_down,
                  color: Colors.blue,
                  size: 12,
                ),
              ],
            ),
            Divider(color: Color.fromARGB(255, 195, 196, 197)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 45),
                    Image.asset(
                      'assets/images/rfis.png',
                      height: 200,
                      width: 200,
                    ),
                    Center(
                      child: Text(
                        "No RFIs to display",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(''' you don't have any RFIs assigned '''),
                    ),
                    Center(child: Text("or visible to you yet.")),
                    CreateRFI(),
                  ]),
            ),
          ]),
        ));
  }
}
