import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function()? onPress;
  final Color backgroundColor;
  final ButtonStyle? style;
  final double? width;
  const ButtonWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    this.onPress,
    required this.backgroundColor,
    this.style,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style ??
          ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            )),
          ),
      onPressed: onPress,
      child: SizedBox(
        width: width ?? 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
