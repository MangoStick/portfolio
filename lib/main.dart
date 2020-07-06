import 'package:flutter/material.dart';
import 'package:portfolio/ui/about.dart';
import 'package:portfolio/ui/home.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/utils/screen/screen_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio',
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColorBrightness: Brightness.light,
          accentColorBrightness: Brightness.light
      ),
      //home: MyAppChild(),
      initialRoute: Strings.HomeRoute,
      // routes: {
      //   Strings.HomeRoute: (context) => MyAppChild(),
      //   Strings.AboutRoute: (context) => AboutPage()
      // },
      onGenerateRoute: (routeSettings){
        if(routeSettings.name == Strings.HomeRoute){
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => MyAppChild());
        }
        if(routeSettings.name == Strings.AboutRoute){
          return PageRouteBuilder(pageBuilder: (_, a1, a2) => AboutPage());
        }
        else{
          return null;
        }
      },
    );
  }
}

class MyAppChild extends StatefulWidget {

  @override
  _MyAppChildState createState() => _MyAppChildState();
}

class _MyAppChildState extends State<MyAppChild> {
  @override
  Widget build(BuildContext context) {
    // instantiating ScreenUtil singleton instance, as this will be used throughout
    // the app to get screen size and other stuff
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return HomePage();
  }
}
