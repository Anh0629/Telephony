class Success {
  int? code;
  String? response;

  Success({this.code, this.response});
}

class False {
  int? code;
  String? errresponse;
  False({this.code, this.errresponse});
}

const invalidResponse = 100;
const noInternet = 101;
const invalidFormat = 102;
const unknownError = 103;

class Error {
  int? code;
  Object? message;

  Error({
    this.code,
    this.message,
  });
}
