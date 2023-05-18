import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:meds_supps/screens/regular_supplies.dart';
import 'account_page.dart';
import 'emergency_supplies.dart';

String address = '';
double rating = 0;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AccountPage()));
                          },
                          child: const Icon(
                            Icons.account_circle,
                            color: Colors.black54,
                            size: 35.0,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Rate Us"),
                                content: RatingBar(
                                    itemSize: 40.0,
                                    initialRating: 0,
                                    direction: Axis.horizontal,
                                    itemCount: 5,
                                    ratingWidget: RatingWidget(
                                        full: const Icon(Icons.star,
                                            color: Colors.yellow),
                                        half: const Icon(
                                          Icons.star_half,
                                          color: Colors.yellow,
                                        ),
                                        empty: const Icon(
                                          Icons.star_outline,
                                          color: Colors.yellow,
                                        )),
                                    onRatingUpdate: (value) async {
                                      setState(() {
                                        rating = value;
                                      });
                                    }),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text("Done"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.menu,
                            size: 35.0,
                            color: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Hello User 👋🏻',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 23.0,
                          fontFamily: 'Ubuntu-Medium'),
                    ),
                  ),
                  buildCarousel(),
                  const SizedBox(
                    height: 30.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Our Services:',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 18.0,
                          fontFamily: 'Ubuntu-Medium'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegularSupplies()),
                              );
                            },
                            child: buildBlock(
                                Icons.medical_services, 'Regular Supplies')),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const EmergencySupplies()),
                              );
                            },
                            child: buildBlock(
                                Icons.warning, 'Emergency Supplies')),
                        // buildBlock(Icons.directions_car_filled, 'Ambulance')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0, left: 20.0, right: 20.0, bottom: 10.0),
                    child: InkWell(
                      onTap: () {
                        _callNumber();
                      },
                      child: Container(
                        width: 500,
                        height: 110,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.orangeAccent),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.directions_car,
                              size: 40.0,
                              color: Colors.white,
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Ambulance',
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 150,
              ),
              const Center(
                child: Text(
                  '© MedSupps, All rights reserved',
                  style: TextStyle(color: Colors.black38),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildBlock(IconData icon, String text) {
    return Container(
      width: 170,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.orangeAccent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  CarouselSlider buildCarousel() {
    return CarouselSlider(
      items: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://cdn.geckoandfly.com/wp-content/uploads/2017/07/health-quotes-08.jpg'),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://th.bing.com/th/id/OIP.LJV3A8n6bswlcHyqnqtD9AHaHa?pid=ImgDet&rs=1'),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 8),
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    'https://quotefancy.com/media/wallpaper/3840x2160/49243-Laozi-Quote-Health-is-the-greatest-possession.jpg'),
              ),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        height: 200.0,
      ),
    );
  }

  _callNumber() async {
    const number = '7380589383'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);

    print(res);
  }
}
