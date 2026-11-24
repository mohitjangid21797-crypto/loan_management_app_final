enum FailureType {
  validation,
  notFound,
  duplicateMobile,
  activeLoan,
  outOfOrderEmi,
  alreadyPaid,
  database,
  pdf,
}

class AppFailure {
  const AppFailure({
    required this.type,
    required this.messageKey,
    this.detail,
  });

  final FailureType type;
  final String messageKey;
  final String? detail;
}

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isErr => this is Err<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Err<T>() => null,
      };

  AppFailure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Err<T>(:final failure) => failure,
      };
}

class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;
}

class Err<T> extends Result<T> {
  const Err(this.failure);

  final AppFailure failure;
}
