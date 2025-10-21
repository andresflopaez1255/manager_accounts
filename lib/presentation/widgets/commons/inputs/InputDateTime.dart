import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
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
    // Configurar el formato de fecha en español
    final dateFormat = DateFormat("dd/MM/yyyy", "es_ES");

    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ReactiveDateTimePicker(
          formControlName: widget.formControlName,
          dateFormat: dateFormat,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
          locale: const Locale('es', 'ES'), // Cambiar el idioma a español
          decoration: InputDecoration(
            labelText: widget.label,
            labelStyle: const TextStyle(
              fontSize: 14,
           
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.white10,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(
                color: Colors.white10,
                width: 1,
              ),
            ),
            filled: true,
           
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 10.0,
            ),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_today, color: Colors.blue),
              onPressed: () {
                widget.form.control(widget.formControlName).reset();
              },
            ),
          ),
          
        ),
      ),
    );
  }
}