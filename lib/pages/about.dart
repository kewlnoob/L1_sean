import 'package:L1_sean/provider/userProvider.dart';
import 'package:L1_sean/widgets/arrows.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:L1_sean/utils/global.dart';

class About extends StatefulWidget {
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ButtonArrow(context, 'home')],
        ),
        title: Text(
          'About Us',
          style: Theme.of(context).textTheme.headline2,
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: ListView(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Our Purpose',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Theme.of(context).iconTheme.color,
                    indent: 150,
                    thickness: 2,
                    endIndent: 150,
                  ),
                  Container(
                    width: 230,
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Text(
                      'Welcome to the toodo list app. Start organizing and plan now! We offer services that allow you to keep track of your study hours!',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    child: Lottie.asset('assets/images/login.json',
                        height: 250, animate: true),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          boxShadow:
                              Theme.of(context).brightness == Brightness.light
                                  ? [
                                      MyShadows.primaryLightShadow,
                                      MyShadows.secondaryLightShadow
                                    ]
                                  : [
                                      MyShadows.primaryDarkShadow,
                                      MyShadows.secondaryDarkShadow
                                    ],
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            launch("tel://21213123123");
                          },
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                                fontFamily: 'SansPro-Bold',
                                fontSize: 18,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? mainBGDarkColor
                                    : mainBGLightColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:
                              Theme.of(context).brightness == Brightness.light
                                  ? [
                                      MyShadows.primaryLightShadow,
                                      MyShadows.secondaryLightShadow
                                    ]
                                  : [
                                      MyShadows.primaryDarkShadow,
                                      MyShadows.secondaryDarkShadow
                                    ],
                        ),
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            var url = 'mailto:201850J@mymai.nyp.edu.sg';
                            if (await canLaunch(url)) {
                              await launch(url);
                            }
                          },
                          child: Text(
                            'Email Us',
                            style: TextStyle(
                                fontFamily: 'SansPro-Bold',
                                fontSize: 18,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? mainBGDarkColor
                                    : mainBGLightColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).scaffoldBackgroundColor,
                            elevation: 0,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
