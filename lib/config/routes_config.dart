import 'package:geo_contacts/pages/home_page.dart';
import 'package:geo_contacts/pages/login_page.dart';
import 'package:geo_contacts/utility/app_routes.dart';

import '../pages/create_contact.dart';
import '../pages/register_page.dart';

class RoutesConfig {
  static var init = {
    // AppRoutes.Home: (ctx) => const HomePage(),
    AppRoutes.Register: (ctx) => const RegisterPage(),
    AppRoutes.Login: (ctx) => const LoginPage(),
    AppRoutes.Home: (ctx) => const HomePage(),
    AppRoutes.CreateContact: (ctx) => const CreateContactPage(),
  };
}