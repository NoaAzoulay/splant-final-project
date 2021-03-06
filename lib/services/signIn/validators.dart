abstract class StringValidator{
  bool isValid(String value);
}

class NonEmptyStringValidator implements StringValidator{
  bool isValid(String value){
    return value.isNotEmpty;
  }
}

class EmailAndPasswordsValidators{
  final StringValidator emailValidator= NonEmptyStringValidator();
  final StringValidator passwordValidator= NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be empty';
  final String invalidPasswordErrorText = 'Password can\'t be empty';
}