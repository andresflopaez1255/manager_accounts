import 'package:reactive_forms/reactive_forms.dart';

FormGroup buildForm() => fb.group(<String, Object>{
      'email_account': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'client_id': FormControl<int>(validators: [Validators.required]),
      'pin_account': [
        Validators.required,
        Validators.minLength(4),
      ],
      'expiration_date': FormControl<DateTime>(validators: [
        Validators.required,
      ]),
      'account_profile': [
        Validators.required,
        Validators.minLength(1),
        Validators.maxLength(8)
      ],
      'password': [
        Validators.minLength(4),
      ]
    });
