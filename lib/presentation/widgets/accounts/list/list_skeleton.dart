import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class ListSkeleton extends StatelessWidget {
  const ListSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 500,
        child: SkeletonListView(

          item: Container(
            margin: const EdgeInsets.only(top: 12),
            color: Colors.red,
            height: 70,
            width: double.infinity,
            child: const Center(child: Text("Content"))),
        ));
  }
}
