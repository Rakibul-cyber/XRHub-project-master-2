import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/constants/style.dart';

class CreateRFI extends StatelessWidget {
  CreateRFI({Key key, BuildContext context}) : super(key: key);

  // user defined function
  void _showDialog(context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Center(
              child: Text("Create RFI",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
          content: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: const [
                      Text(
                        "Status",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      prefixIcon: Icon(
                        Entypo.flow_line,
                        color: Color.fromARGB(255, 153, 0, 255),
                      ),
                      labelText: 'Draft',
                      suffixIcon: Icon(Entypo.chevron_small_down),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text(
                        "Title",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      Text(
                        "*",
                        style: TextStyle(color: Colors.red),
                      )
                    ],
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Ball in court',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 238, 238, 238),
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Teczo Unity',
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text("Co-reviewers",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.exclamationcircleo,
                          color: Colors.blue,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Search by members,roles or companies',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Due date",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      prefixIcon: Icon(Fontisto.date),
                      labelText: 'Select date',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Location",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select....',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Location details",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Enter location details',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Question",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      contentPadding: EdgeInsets.symmetric(vertical: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Suggested answer",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      contentPadding: EdgeInsets.symmetric(vertical: 40),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: grey),
                        borderRadius: BorderRadius.circular(4)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('References',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: grey),
                                      borderRadius: BorderRadius.circular(2)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Text('Add references',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(Entypo.chevron_small_down),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                                'Add References to others objects or projects files'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Cost impact",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select a member,role,or company',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Schedule impact",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select impact',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Priority",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Normal ',
                      labelStyle: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Discipline",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select discipline',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("Category",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select category',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text("External ID",
                      style: TextStyle(color: Colors.grey, fontSize: 16)),
                  const TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Enter extrnal ID',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Divider(
                    color: grey,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: const [
                      Text("Watchers",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          AntDesign.exclamationcircleo,
                          color: Colors.blue,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: (BorderSide(
                            width: 1,
                            color: Color.fromARGB(255, 155, 154, 154))),
                      ),
                      labelText: 'Select by members,roles or companies',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 214, 212, 212)),
                      suffixIcon: Icon(Entypo.chevron_small_down),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[500],
                maximumSize: const Size(150, 50),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            // usually buttons at the bottom of the dialog
            ElevatedButton(
              child: const Text("Create"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: Text('Create RFI'),
        style: TextButton.styleFrom(
          primary: Colors.blue,
        ),
        onPressed: () {
          _showDialog(context);
        });
  }
}
