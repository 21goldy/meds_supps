import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meds_supps/screens/my_orders.dart';
import '../constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  Future<void> signOut() async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.delete(key: 'uid');
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        decoration: kBoxDecoration,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'MedSupps',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat-Bold',
                      fontSize: 50,
                    ),
                  ),
                  const Text(
                    'The first wealth is health!',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Ubuntu',
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  optionsView(Icons.edit, 'My Orders', () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyOrders()),
                    );
                  }),
                  const SizedBox(
                    height: 15.0,
                  ),
                  optionsView(Icons.logout, 'Log Out', () {
                    signOut().then((value) async {
                      await Future.delayed(const Duration(seconds: 2));
                    });
                    SystemChannels.platform
                        .invokeMethod<void>('SystemNavigator.pop');
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell optionsView(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.white,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
