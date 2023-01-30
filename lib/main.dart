import 'package:flutter/material.dart';
import 'package:geo_contacts/config/PROVIDER_CONFIG.dart';
import 'package:geo_contacts/config/routes_config.dart';
import 'package:geo_contacts/pages/home_page.dart';
import 'package:geo_contacts/pages/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  //await Firebase
  runApp(const MyAppS());
}
class MyAppS extends StatefulWidget {
  const MyAppS({Key? key}) : super(key: key);

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  @override
  State<MyAppS> createState() => MyApp();
}

class MyApp extends State<MyAppS> {
  // const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderConfig.init,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
        routes: RoutesConfig.init,
      ),
    );
  }
}

