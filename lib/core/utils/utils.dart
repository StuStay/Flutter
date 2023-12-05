


import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../errors/failures/failure.dart';





///Map to left extension
extension TaskX<T extends Either<Object, U>, U> on Task<T> {
  Task<Either<Failure, U>> mapLeftToFailure({String name = ""}) {
    return map(
          (either) => either.leftMap((obj) {
        try {
          debugPrint('function name is : $name');
          return obj as Failure;
        } catch (e) {
          debugPrint('function name is : $name');
          throw obj;
        }
      }),
    );
  }
}