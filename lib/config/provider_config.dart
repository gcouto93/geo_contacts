import 'package:flutter/cupertino.dart';
import 'package:geo_contacts/providers/auth_provider.dart';
import 'package:geo_contacts/providers/contact_provider.dart';
import 'package:provider/provider.dart';

class ProviderConfig {
  static var init = [
    ChangeNotifierProvider(
        create: (_) => AuthProvider(),

    ),
    ChangeNotifierProxyProvider<AuthProvider, ContactProvider>(
  create: (_) => ContactProvider(),
  update: (ctx, auth, previous) {
  return ContactProvider();
  },
  ),
  ];
}