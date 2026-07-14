import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/auth_notifier.dart';
import '../states/auth_state.dart';

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});