import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';
import 'fake_ui.dart' if (dart.library.html) 'real_ui.dart' as ui;
import 'package:http/http.dart' as http;

// import 'package: legist_ahmed/assets/Check.png';
class MailScreen extends StatefulWidget {
  // const MailScreen({Key key}) : super(key: key);

  @override
  _MailScreenState createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  final controllerName = TextEditingController();
  final controllerEmail = TextEditingController(); //Sender's email
  final controllerTo = TextEditingController();
  final controllerSubject = TextEditingController();
  final controllerMessage = TextEditingController();
  js.JsObject connector;
  String createdViewId = Random().nextInt(1000).toString();
  html.IFrameElement element;

  @override
  void initState() {
    js.context["connect_content_to_flutter"] = (js.JsObject content) {
      connector = content;
    };
    element = html.IFrameElement()
      ..src = "/assets/html/editor.html"
      ..style.border = 'none';

    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          child: Row(
            children: [
              if (ResponsiveWidget.isLargeScreen(context))
                Flexible(flex: 1, child: Container()),
              Flexible(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: legistwhite,
                    border:
                        Border.all(color: active.withOpacity(.4), width: .5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(35.0),
                    child: Column(
                      children: [
                        buildTextField(
                            title: 'Your Name:', controller: controllerName),
                        const SizedBox(
                          height: 8,
                        ),
                        buildTextField(
                            title: 'Your Email:', controller: controllerEmail),
                        const SizedBox(
                          height: 8,
                        ),
                        buildTextField(title: 'To:', controller: controllerTo),
                        const SizedBox(height: 8),
                        buildTextField(
                            title: 'Subject:', controller: controllerSubject),
                        const SizedBox(height: 20),
                        /*buildOutlinedTextField(
                          title: '\nMessage:',
                          controller: controllerMessage,
                          maxLines: 20,
                        ),*/
                        //const SizedBox(height: 10),
                        SizedBox(
                          height: 340,
                          child: HtmlElementView(
                            viewType: createdViewId,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          constraints: BoxConstraints(maxWidth: 150),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  alignment: Alignment.center,
                                  minimumSize: Size.fromHeight(50),
                                  textStyle: TextStyle(fontSize: 18),
                                  primary: legistblue),
                              child: Center(
                                child: Row(
                                  children: [
                                    Icon(Icons.send),
                                    SizedBox(width: 10),
                                    Text('SEND'),
                                  ],
                                ),
                              ),
                              onPressed: () => {
                                    sendEmail(
                                      name: controllerName.text,
                                      email: controllerEmail.text,
                                      toEmail: controllerTo.text,
                                      subject: controllerSubject.text,
                                      message: connector.callMethod(
                                        'getValue',
                                      ) as String,
                                    ),
                                    controllerName.clear(),
                                    controllerEmail.clear(),
                                    controllerTo.clear(),
                                    controllerSubject.clear(),
                                    controllerMessage.clear(),
                                  }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (ResponsiveWidget.isLargeScreen(context))
                Flexible(flex: 1, child: Container()),
            ],
          ),
        ),
      );

//TODO: Update later to exclude EmailJS Hosting.
  Future sendEmail({
    @required String name,
    @required String email,
    @required String toEmail,
    @required String subject,
    @required String message,
  }) async {
    final serviceId = 'service_d2e37rn';
    final templateId = 'template_0nat3xc';
    final userId = 'user_XjXBMokldo9BNqVKe6IRB';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        //'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode(
        {
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_name': name,
            'user_email': email,
            'to_email': toEmail,
            'user_subject': subject,
            'user_message': message,
          },
        },
      ),
    );
    if (name == null ||
        email == null ||
        toEmail == null ||
        subject == null ||
        message == null) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Your mail is being sent...'),
      ));
    }
  }

  Widget buildTextField({
    @required String title, // may rm required
    @required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 10.0,
          ),
          const SizedBox(width: 16),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            controller: controller,
            maxLines: maxLines,
          ),
        ],
      );

  Widget buildOutlinedTextField({
    @required String title,
    @required TextEditingController controller,
    int maxLines = 1,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.getFont('Roboto', fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          // Expanded(
          //   child:
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          //const SizedBox(height: 10),
          //HtmlElementView(viewType: createdViewId)
          // )
        ],
      );
}
