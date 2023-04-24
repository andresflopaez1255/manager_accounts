import 'package:reactive_forms/reactive_forms.dart';

final validationsMessages = {
  ValidationMessage.required: (error) => 'Este campo es requerido',
  ValidationMessage.email: (error) => 'Por favor ingrese un correo valido',
};
