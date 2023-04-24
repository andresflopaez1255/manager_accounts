// ignore: file_names
import 'package:flutter/material.dart';
import 'package:manager_accounts/presentation/widgets/modals/modals.dart';

class UsersModalController {
  static  Future<dynamic> dialogUser(context) {
      final TextEditingController controllerEmail = TextEditingController();

      return showDialog(
        
          context: context,
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return UserModalContent(size: size, controllerEmail: controllerEmail);
          });
    }
}