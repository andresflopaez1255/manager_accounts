import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class InputDateTime extends StatefulWidget {
  final FormGroup form;
  final String formControlName;
  final String label;
  final DateTime? defaultValue;
  final Widget Function(BuildContext, DateTime?)? builder;
  final EdgeInsetsGeometry? padding;

  const InputDateTime({
    Key? key,
    required this.form,
    required this.formControlName,
    required this.label,
    this.builder,
    this.padding,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<InputDateTime> createState() => _InputDateTimeState();
}

class _InputDateTimeState extends State<InputDateTime> {
  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null) {
      widget.form.control(widget.formControlName).value = widget.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 8),
      child: ReactiveDateTimePicker(
        formControlName: widget.formControlName,
        dateFormat: DateFormat("MM/dd/yyyy"),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Color.fromARGB(255, 220, 218, 218),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 1,
              color: Color(0xffABABAB),
            ),
          ),
          labelText: widget.label,
          filled: true,
          fillColor: const Color.fromARGB(255, 241, 240, 240),
          labelStyle: const TextStyle(
            color: Color(0xff656565),
          ),
        ),
      ),
    );
  }
}
