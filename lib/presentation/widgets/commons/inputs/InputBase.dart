import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputBase extends StatefulWidget {
  final String formControl;
  final String label;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final String? defaultValue;
  final FormGroup? form;
  final TextInputType? keyboardType;
  const InputBase({
    super.key,
    this.onChanged,
    required this.label,
    this.padding,
    this.keyboardType,
    this.defaultValue,
    required this.formControl,
    this.form,
  });

  @override
  State<InputBase> createState() => _InputBaseState();
}

class _InputBaseState extends State<InputBase> {
  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null && widget.form != null) {
      widget.form?.control(widget.formControl).value = widget.defaultValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 48.sp,
        child: ReactiveTextField(
          formControlName: widget.formControl,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 2,
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                )),
            label: Text(widget.label),
            filled: true,
          ),
        ),
      ),
    );
  }
}
