import 'package:flutter/material.dart';

class CreateRequest extends StatefulWidget {
  const CreateRequest({Key? key}) : super(key: key);

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create Request'),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
