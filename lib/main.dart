import 'package:flutter/material.dart';
import 'package:flutter_application/states/authen.dart';
import 'package:flutter_application/states/create_account.dart';
import 'package:flutter_application/states/service_admin.dart';
import 'package:flutter_application/states/service_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/serviceAdmin': (BuildContext context) => ServiceAdmin(),
  '/serviceUSer': (BuildContext context) => ServiceUser(),
};

String? initialRoute;

Future<Null> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //หมายความว่าต้องทำthred แรกให้เสร็จก่อน
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? user = preferences.getString('user');
  if (user?.isEmpty ?? true) {
    initialRoute = '/authen';
    runApp(MyApp());
  } else {
    initialRoute = '/serviceUSer';
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: initialRoute,
      title: 'Tisco',
    );
  }
}
