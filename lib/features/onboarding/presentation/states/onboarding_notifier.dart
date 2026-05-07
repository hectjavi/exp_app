import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state_freezed.dart';

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() {

    return const OnboardingState();
  }
  void nextPage() {
    if (state.currentPage < 1) {
      state = state.copyWith(currentPage: state.currentPage + 1);
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
      state = state.copyWith(currentPage: state.currentPage - 1);
    }
  }

  void toggleInterest(String interest) {
    final currentInterests = List<String>.from(state.selectedInterests);

    if (currentInterests.contains(interest)) {
      currentInterests.remove(interest);
    } else {
      currentInterests.add(interest);
    }

    state = state.copyWith(selectedInterests: currentInterests);
  }

  void completeOnboarding() {
    state = state.copyWith(isCompleted: true);
  }

  void reset() {
    state = const OnboardingState();
  }
}
final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(
  () => OnboardingNotifier(),
);
