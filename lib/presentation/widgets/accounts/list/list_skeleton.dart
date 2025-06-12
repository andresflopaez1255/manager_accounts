import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({Key? key, required this.enabled}) : super(key: key);
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 150,
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Container(
              margin: const EdgeInsets.only(top: 12),
              color: Colors.red,
              height: 70,
              width: double.infinity,
              child: const Center(child: Text("Content"))),
        ));
  }
}
