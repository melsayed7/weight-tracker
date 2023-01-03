import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:weight_tracker/database/database_helper.dart';
import 'package:weight_tracker/model/user_weight.dart';
import 'package:weight_tracker/screen/home/edit_weight_item.dart';

class ItemWeightList extends StatelessWidget {
  UserWeight userWeight;

  ItemWeightList({required this.userWeight});

  @override
  Widget build(BuildContext context) {
    DateTime showTime = DateTime.fromMillisecondsSinceEpoch(userWeight.time);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditWeightItem.routeName,
            arguments: userWeight);
      },
      child: Slidable(
        startActionPane: ActionPane(
            extentRatio: .25,
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (context) {
                  DatabaseHelper.deleteWeightFromFirebase(userWeight);
                },
                borderRadius: BorderRadius.circular(10),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ]),
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Text(
                'Note Weight : ${userWeight.note}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weight : ${userWeight.weight} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    'Day : ${showTime.day} / ${showTime.month} / ${showTime.year} ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
