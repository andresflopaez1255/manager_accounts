import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputPasswordBase extends StatefulWidget {
  final String formControl;
  final String label;
  final Function(String)? onChanged;
  final EdgeInsetsGeometry? padding;
  final String? defaultValue;
  final FormGroup? form;
  const InputPasswordBase({
    Key? key,
    required this.label,
    this.onChanged,
    this.padding,
    required this.formControl,
    this.defaultValue,
    this.form,
  }) : super(key: key);

  @override
  State<InputPasswordBase> createState() => _InputPasswordBaseState();
}

class _InputPasswordBaseState extends State<InputPasswordBase> {
  var _passwordHide = true;
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
          obscureText: _passwordHide,
          formControlName: widget.formControl,
          decoration: InputDecoration(
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
              label: Text(widget.label),
              filled: true,
              suffixIcon: IconButton(
                icon: Icon(
                  color: const Color(0xffABABAB),
                  _passwordHide ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordHide = !_passwordHide;
                  });
                },
              ),
              fillColor: Colors.white,
              labelStyle: const TextStyle(color: Color(0xff656565))),
        ),
      ),
    );
  }
}
