import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/database/database_helper.dart';
import 'package:weight_tracker/model/user_weight.dart';
import 'package:weight_tracker/provider/user_provider.dart';
import 'package:weight_tracker/screen/home/item_weight_list.dart';
import 'package:weight_tracker/screen/home/weight_list_bottom_sheet.dart';
import 'package:weight_tracker/screen/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Tracker'),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<UserProvider>(context, listen: false).logOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddWeightBottomSheet();
          },
          child: const Icon(Icons.add)),
      body: StreamBuilder<QuerySnapshot<UserWeight>>(
        stream: DatabaseHelper.getDataFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            const Center(child: CircularProgressIndicator());
          }
          var weights = snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
          return ListView.builder(
            itemBuilder: (context, index) {
              return ItemWeightList(userWeight: weights[index]);
            },
            itemCount: weights.length,
          );
        },
      ),
    );
  }

  void showAddWeightBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => WeightListBottomSheet(),
    );
  }
}
