import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text('My Orders'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Supplies').snapshots(),
          builder: (context, snapshot) {
            getData() {
              if (snapshot.hasData) {
                List<ListTile> supplies = [];

                for (var d in snapshot.data!.docs) {
                  supplies.add(ListTile(
                    title: Text('${d.get('type')}'),
                    subtitle: Text('${d.get('supplies')}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                  ));
                  print(d.get('username'));
                }

                return ListView.separated(
                  itemCount: supplies.length,
                  itemBuilder: (context, index) {
                    return supplies[index];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      thickness: 2,
                    );
                  },
                );
              } else {
                return const Text('Cannot work sorry!');
              }
            }

            try {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : getData();
            } catch (e) {
              print(e);
            }
            return const Center(
              child: Text('No Records Found'),
            );
          }),
    );
  }
}
