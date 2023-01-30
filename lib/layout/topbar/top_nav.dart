import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:urlnav2/constants/custom_text.dart';
import 'package:urlnav2/constants/style.dart';
import 'package:urlnav2/helpers/reponsiveness.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      toolbarHeight: toolbarheight,
      shape:
          Border.symmetric(horizontal: BorderSide(color: lightGrey, width: .5)),
      leading: ResponsiveWidget.isLargeScreen(context)
          ? Container(
            child: Icon(Ionicons.notifications_outline),
          )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState.openDrawer();
              }),
      title: Container(
        child: Row(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ResponsiveWidget.isLargeScreen(context) ? Container(
              child: Row(
                children: [
                  
                  TextButton(onPressed: (){}, child: Text('Sample Project - Seaport Civic Center'),),
                  Icon(MaterialIcons.public),
                  Icon(MaterialIcons.arrow_drop_down),
                  Icon(MaterialCommunityIcons.star_circle, color: Color(0xFF00AC9E), size: 16,)
                ],
              ),
            ) : Text(''),
            Expanded(child: Container()),
            
           ResponsiveWidget.isLargeScreen(context) ? Row(
              children: [
                ElevatedButton(onPressed: (){}, child: Text('View buying option'), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(blue)),),
                IconButton(
                icon: Icon(
                  AntDesign.questioncircle,
                  color: dark.withOpacity(.7),
                ),
                onPressed: () {}),
                Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
              ],
            ) : Text(''),
            
            /*IconButton(
                icon: Icon(
                  Icons.settings_outlined,
                  color: dark.withOpacity(.7),
                ),
                onPressed: () {
                  showPopover(
                      context: context,
                      transitionDuration: const Duration(milliseconds: 150),
                      bodyBuilder: (context) => const ListItems(),
                      onPop: () {},
                      direction: PopoverDirection.top,
                      width: 200,
                      height: 400,
                      arrowHeight: 15,
                      arrowWidth: 30);
                }),*/
            //SettingsIcons(icon: Icons.settings_outlined),
            //SettingsIcons(icon: Icons.notifications_outlined),
            
            const SizedBox(
              width: 24,
            ),
            //Getusername(),
            const SizedBox(
              width: 16,
            ),
            InkWell(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              child: Container(
                decoration: BoxDecoration(
                    color: active.withOpacity(.5),
                    borderRadius: BorderRadius.circular(30)),
                child: Container(
                  decoration: BoxDecoration(
                      color: legistwhite,
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(2),
                  child: const CircleAvatar(
                    backgroundColor: legistwhite,
                    child: Icon(
                      Icons.person_outline,
                      color: dark,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 5,),
             Text('Teczo Unity', style: TextStyle(
              color: dark,
              fontSize: 15,
             ),),
             SizedBox(width: 5,),

             Icon(AntDesign.caretdown, size: 15,),
          ],
        ),
      ),
      iconTheme: const IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: legistwhite,
    );
