import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/widgets/commons/SubtitleHeader.dart';
import 'package:manager_accounts/presentation/widgets/users/list/UserList.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 8, right: 8),
        child: Column(
          children: [
            SubtitleHeader(
              title: "Usuarios Registrados",
              onPress: () {
                Navigator.pushNamed(context, '/userForm');
              },
            ),
            const ListUsers(),
          ],
        ),
      )),
    );
  }
}
