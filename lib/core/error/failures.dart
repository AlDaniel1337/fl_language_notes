import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}



class FileSystemFailure extends Failure {
  const FileSystemFailure(super.message);
}



class ParseFailure extends Failure {
  const ParseFailure(super.message);
}