import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class InputDatePicker extends StatefulWidget {
  const InputDatePicker({Key? key}) : super(key: key);

  @override
  State<InputDatePicker> createState() => _InputDatePickerState();
}

class _InputDatePickerState extends State<InputDatePicker> {
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    dateInput.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextField(
      controller: dateInput,
      //editing controller of this TextField
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.white10)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.white10)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1, color: Colors.white10)),
        label: const Text("Fecha de renovacion"),
        filled: true,
        labelStyle: Theme.of(context).textTheme.labelLarge,
      ),
      readOnly: true,
     
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
          
             initialDate: DateTime.now().add(const Duration(days: 30)),
          
            firstDate: DateTime(1950),
          
            lastDate: DateTime(5100));

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

          setState(() {
            dateInput.text =
                formattedDate; //set output date to TextField value.
          });
        } else {}
      },
    ));
  }
}
