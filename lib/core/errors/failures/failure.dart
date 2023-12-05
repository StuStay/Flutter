/// General model of a failure
abstract class FailureAbstract {
  final dynamic type;
  final String description;
  final dynamic errorCode;
  final bool? displayMessage;
  final bool? doAction;
  String toString();
  FailureAbstract(this.type, this.description, this.errorCode , this.displayMessage,this.doAction);
}

class Failure implements FailureAbstract {
  late String _description;
  dynamic _type;
  dynamic _errorCode;
  bool? _displayMessage;
  bool? _doAction;
  @override
  Failure(type, description, errorCode , displayMessage , doAction) {
    _description = description ?? "";
    _type = type;
    _errorCode = errorCode;
    _displayMessage = displayMessage;
    _doAction = doAction;
  }

  @override
  String get description => _description;

  @override
  String toString() {
    return _description;
  }

  @override
  get type => _type;


  get errorCode => _errorCode;

  @override
  bool? get displayMessage => _displayMessage;

  @override
  // TODO: implement doAction
  bool? get doAction => _doAction;
}
