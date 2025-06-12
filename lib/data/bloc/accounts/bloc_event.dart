import 'package:reactive_forms/reactive_forms.dart';

abstract class AccountEvent {}

class DataListEvent extends AccountEvent {}

class DeleteAccountEvent extends AccountEvent {
   final String idAccount;
  DeleteAccountEvent(this.idAccount);
}

class NewAccountEvent extends AccountEvent {
  final FormGroup data;
  NewAccountEvent(this.data);
}

class UpdateAccountEvent extends AccountEvent {
  final FormGroup data;
  final String id;
  UpdateAccountEvent(this.data, this.id);
}
