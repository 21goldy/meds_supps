import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';
import 'package:meds_supps/components/login_fields.dart';
import 'package:meds_supps/components/rounded_button.dart';

class EmergencySupplies extends StatefulWidget {
  const EmergencySupplies({Key? key}) : super(key: key);

  @override
  State<EmergencySupplies> createState() => _EmergencySuppliesState();
}

class _EmergencySuppliesState extends State<EmergencySupplies> {
  TextEditingController priceController = TextEditingController();
  late TextEditingController localityController = TextEditingController();
  late TextEditingController postalCodeController = TextEditingController();
  late TextEditingController countryController = TextEditingController();

  Location location = Location();
  late LocationData locationData;
  String _cityLocality = '';
  String _postalCode = '';
  String _country = '';
  String username = '';
  String emergency = '';
  bool showSpinner = false;

  void getLocationPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Location Service Not Enabled!"),
            content: const Text("You have raised a Alert Dialog Box"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Location Permission Not Granted"),
            content: const Text("You have raised a Alert Dialog Box"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        );
      }
    }
  }

  void getLocation() async {
    try {
      locationData = await location.getLocation();

      double? lat = locationData.latitude;
      double? long = locationData.longitude;
      List<Placemark> placeMark = await placemarkFromCoordinates(lat!, long!);

      Placemark place = placeMark[0];

      // _address =
      //     '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      _cityLocality = '${place.locality}';
      _postalCode = '${place.postalCode}';
      _country = '${place.country}';
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getLocation();

    localityController;
    postalCodeController;
    countryController;
  }

  @override
  void dispose() {
    super.dispose();
    priceController.dispose();
    localityController.dispose();
    postalCodeController.dispose();
    countryController.dispose();
  }

  FirebaseFirestore firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          title: const Text(
            'Emergency Supplies',
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginFields(
                  formHintText: 'Username',
                  formPrefixIcon: Icons.account_box_rounded,
                  obscureText: false,
                  onChanged: (v) {
                    print(v);
                    username = v;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LoginFields(
                  formHintText: 'Type Your Emergency',
                  formPrefixIcon: Icons.warning,
                  obscureText: false,
                  onChanged: (v) {
                    print(v);
                    emergency = v;
                  }),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Add your address',
                style: TextStyle(color: Colors.black38, fontSize: 18),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: localityController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'City/Locality',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _cityLocality = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: postalCodeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Postal Code',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _postalCode = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Country',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.grey.shade400),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _country = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Set Location"),
                      content: const Text(
                          "Continue With Your Current Location. You can edit it manually if you want!"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            getLocationPermission();
                            getLocation();
                            setState(() {
                              localityController =
                                  TextEditingController(text: _cityLocality);
                              postalCodeController =
                                  TextEditingController(text: _postalCode);
                              countryController =
                                  TextEditingController(text: _country);
                            });
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Okay"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: const Text("Enter Manually"),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.my_location,
                    size: 25.0,
                    color: Colors.grey,
                  ),
                  Text(
                    ' Get My Current Location',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            RoundedButton(
                title: 'Submit',
                color: Colors.white,
                onPressed: () {
                  firebase.collection('Supplies').add({
                    'username': username,
                    'supplies': emergency,
                    'type': 'emergency',
                    'uid': FirebaseAuth.instance.currentUser?.uid,
                    'address':
                        '${localityController.text}, ${postalCodeController.text}, ${countryController.text}',
                  });

                  FocusScopeNode currentFocus = FocusScope.of(context);
                  Navigator.pop(context);
                },
                fontSize: 18)
          ],
        ));
  }
}
