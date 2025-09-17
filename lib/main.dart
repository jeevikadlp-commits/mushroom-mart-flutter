import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD7jAifxXQfa5vjthoYWJBtkimdk3ozFFw",
      appId: "1:959002796102:web:3e75e3ea078663912a2a47",
      messagingSenderId: "959002796102",
      projectId: "studio-1995531473-9005c",
      storageBucket: "studio-1995531473-9005c.appspot.com",
    ),
  );

  runApp(const MushroomMartApp());
}

class MushroomMartApp extends StatelessWidget {
  const MushroomMartApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mushroom Mart',
      home: Scaffold(
        appBar: AppBar(title: const Text('Mushroom Mart')),
        body: const ProductList(),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  const ProductList({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final docs = snapshot.data!.docs;
        return ListView(
          children: docs.map((d) {
            final data = d.data() as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name'] ?? 'No name'),
              subtitle: Text('₹${data['price'] ?? ''}'),
            );
          }).toList(),
        );
      },
    );
  }
}
