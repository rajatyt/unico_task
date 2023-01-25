import 'package:freezed_annotation/freezed_annotation.dart';

part 'login.state.freezed.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState({
    @Default(false) bool isLoading,
  }) = _LoginPageState;
}
