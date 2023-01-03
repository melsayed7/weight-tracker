import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_tracker/model/user_weight.dart';
import 'package:weight_tracker/provider/user_provider.dart';

class EditWeightItem extends StatefulWidget {
  static const String routeName = 'edit-weight-item';

  @override
  State<EditWeightItem> createState() => _EditWeightItemState();
}

class _EditWeightItemState extends State<EditWeightItem> {
  var formKey = GlobalKey<FormState>();

  DateTime selectedTime = DateTime.now();

  TextEditingController weightController = TextEditingController();

  TextEditingController noteController = TextEditingController();

  late UserWeight args;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      args = ModalRoute.of(context)?.settings.arguments as UserWeight;
      weightController.text = args.weight;
      noteController.text = args.note;
      selectedTime = DateTime.fromMillisecondsSinceEpoch(args.time);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Weight'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Edit Weight ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .10,
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
                  args.weight = weightController.text;
                  args.note = noteController.text;
                  args.time = selectedTime.millisecondsSinceEpoch;
                  Provider.of<UserProvider>(context, listen: false)
                      .editWeight(args);
                  Navigator.pop(context);
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
                  'Save Changes',
                ),
              ),
            ),
          ],
        ),
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
