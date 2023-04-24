import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class InputDateTime extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Function(DateTime?)? onChanged;
  final EdgeInsetsGeometry? padding;
  const InputDateTime({
    Key? key,
    required this.controller,
    required this.label,
    this.onChanged,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 8),
      child: DateTimeField(
        controller: controller,
        
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1,
                color: Color.fromARGB(255, 220, 218, 218),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0xffABABAB),
              )),
          label: Text(label),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(
            color: Color(0xff656565),
          ),
        ),
        
        format: DateFormat("dd-MM-yyyy"),
        onChanged: onChanged,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              
              helpText: 'Selecciona la fecha de vencimiento',
              cancelText: 'Cancelar',
              confirmText: 'Confirmar',
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    );
  }
}
