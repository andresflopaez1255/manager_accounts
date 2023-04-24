import 'package:flutter/material.dart';

class ButtonClose extends StatelessWidget {
  const ButtonClose({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flex(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.horizontal,
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFFDFDFDF)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: IconButton(
                  enableFeedback: false,
                  splashRadius: 1,
                  onPressed: () => {
                    Navigator.of(context).pop()
                  },
                  icon: const Icon(Icons.close)),
            ),
          ),
        ]);
  }
}