import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../shared/models/user_model.dart';

part 'auth_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isAuthenticated,
    UserModel? user, // ✅ NUEVO
  }) = _AuthState;

  factory AuthState.initial() => const AuthState();
}