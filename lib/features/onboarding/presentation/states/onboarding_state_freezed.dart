import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_state_freezed.freezed.dart';

@freezed
abstract class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(0) int currentPage,
    @Default([]) List<String> selectedInterests,
    @Default(false) bool isLoading,
    @Default(false) bool isCompleted,
    String? errorMessage,
  }) = _OnboardingState;
}

