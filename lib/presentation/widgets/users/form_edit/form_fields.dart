import 'package:reactive_forms/reactive_forms.dart';

FormGroup formUser() => fb.group(<String, Object>{
      'email_user': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'name_user': FormControl<String>(validators: [Validators.required]),
      'phone_user': [
        Validators.required,
        Validators.minLength(4),
      ],
    });
