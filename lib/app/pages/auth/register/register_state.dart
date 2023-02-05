import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'register_state.g.dart';

@match
enum RegisterStatus {
  initial,
  register,
  success,
  error,
}

class RegisterState extends Equatable {
  const RegisterState({
    this.status = RegisterStatus.initial,
  });

  const RegisterState.initial() : status = RegisterStatus.initial;

  final RegisterStatus status;

  RegisterState copyWith({
    RegisterStatus? status,
  }) {
    return RegisterState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status];
}
