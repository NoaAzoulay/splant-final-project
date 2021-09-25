import 'package:flutter/widgets.dart';
import 'package:noa/services/Auth.dart';
import 'package:noa/services/signIn/validators.dart';

import 'EmailSignInModel.dart';

class EmailSignInChangeModel with EmailAndPasswordsValidators, ChangeNotifier {
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;
  final AuthBase auth;
//cnstr
  EmailSignInChangeModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signIn,
      this.isLoading = false,
      this.submitted = false,
      this.auth});

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        await auth.CreateUserWithEmailAndPassword(
            email, password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'
        : 'Create an Account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Have an Account? Sign In';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {

      this.email= email ?? this.email;
      this.password= password ?? this.password;
      this.formType= formType ?? this.formType;
      this.isLoading= isLoading ?? this.isLoading;
      this.submitted= submitted ?? this.submitted;
      //notify object changed
      notifyListeners();

  }
  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      submitted: false,
      isLoading: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);



}
