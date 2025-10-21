import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

class InputBase extends StatefulWidget {
  final String formControl;
  final String label;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final String? defaultValue;
  final FormGroup? form;
  final TextInputType? keyboardType;
  const InputBase({
    Key? key,
    this.onChanged,
    required this.label,
    this.padding,
    this.keyboardType,
    this.defaultValue,
    required this.formControl,
    this.form,
  }) : super(key: key);

  @override
  State<InputBase> createState() => _InputBaseState();
}

class _InputBaseState extends State<InputBase> {
  @override
  void initState() {
   
    if (widget.defaultValue != null && widget.defaultValue!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.form?.control(widget.formControl).value = widget.defaultValue;
      });
    }
     super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: 65.h,
        child: ReactiveTextField(
          formControlName: widget.formControl,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
            label: Text(widget.label),
            filled: true,
            labelStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
