import 'package:flutter/material.dart';
import 'package:weight_tracker/database/database_helper.dart';
import 'package:weight_tracker/model/user_weight.dart';

class WeightListBottomSheet extends StatefulWidget {
  @override
  State<WeightListBottomSheet> createState() => _WeightListBottomSheetState();
}

class _WeightListBottomSheetState extends State<WeightListBottomSheet> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedTime = DateTime.now();
  TextEditingController weightController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add new Weight ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please enter weight';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'entre weight'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: noteController,
                  keyboardType: TextInputType.text,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'please note';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(hintText: 'entre note'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('Select Time',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              showTime();
            },
            child: Text(
              '${selectedTime.day} : ${selectedTime.month} : ${selectedTime.year}',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                UserWeight userWeight = UserWeight(
                  weight: weightController.text,
                  note: noteController.text,
                  time: DateUtils.dateOnly(selectedTime).millisecondsSinceEpoch,
                );
                DatabaseHelper.addWeightToFirebase(userWeight)
                    .timeout(const Duration(microseconds: 500), onTimeout: () {
                  Navigator.pop(context);
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Submit',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showTime() async {
    var chosenTime = await showDatePicker(
      context: context,
      initialDate: selectedTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (chosenTime != null) {
      selectedTime = chosenTime;
    }
    setState(() {});
  }
}
