import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectInput<T> extends StatefulWidget {
  final String label;
  final Function(Object) onChanged;
  final EdgeInsetsGeometry? padding;
  final String formControl;
  final int? defaultValue;
  final FormGroup? form;
  const SelectInput({
    Key? key,
    required this.items,
    required this.label,
    required this.onChanged,
    this.padding,
    required this.formControl,
    this.defaultValue,
    this.form,
  }) : super(key: key);

  final List<DropdownMenuItem<T>> items;

  @override
  State<SelectInput<T>> createState() => _SelectInputState<T>();
}

class _SelectInputState<T> extends State<SelectInput<T>> {
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
        child: ReactiveDropdownField(
          formControlName: widget.formControl,
          items: widget.items,
          onChanged: (result) {
            widget.onChanged(result);
          },
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xffABABAB),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 2,
                  color: Color(0xffABABAB),
                )),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(
                  width: 1,
                  color: Color(0xffABABAB),
                )),
            label: Text(
              widget.label,
            ),
            filled: true,
            fillColor: Colors.white,
            labelStyle: const TextStyle(
              color: Color(0xff656565),
            ),
          ),
        ),
      ),
    );
  }
}
