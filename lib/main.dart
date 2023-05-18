import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meds_supps/screens/home_page.dart';
import 'package:meds_supps/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: MedSuppliers()));
}

class MedSuppliers extends StatelessWidget {
  const MedSuppliers({super.key});

  final secureStorage = const FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await secureStorage.read(key: 'uid');

    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLoginStatus(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == false) {
          return const WelcomeScreen();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.white, child: const CircularProgressIndicator());
        }
        return const HomePage();
      },
    );
  }
}
