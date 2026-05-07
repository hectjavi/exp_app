import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../states/onboarding_notifier.dart';
import '../widgets/onboarding_widgets.dart';

class OnboardingRiverpodView extends ConsumerWidget {
  const OnboardingRiverpodView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: state.currentPage == 0
              ? _OnboardingWelcomePage(
                  key: const ValueKey('welcome'),
                  onNext: notifier.nextPage,
                )
              : _OnboardingInterestsPage(
                  key: const ValueKey('interests'),
                  selectedInterests: state.selectedInterests,
                  onToggleInterest: notifier.toggleInterest,
                  onNext: notifier.completeOnboarding,
                  onBack: notifier.previousPage,
                ),
        ),
      ),
    );
  }
}

/// Pagina 1
class _OnboardingWelcomePage extends StatelessWidget {
  final VoidCallback onNext;

  const _OnboardingWelcomePage({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9:41',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_alt, size: 16, color: Colors.grey[800]),
                  const SizedBox(width: 4),
                  Icon(Icons.wifi, size: 16, color: Colors.grey[800]),
                  const SizedBox(width: 4),
                  Icon(Icons.battery_full, size: 16, color: Colors.grey[800]),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.image_outlined,
              size: 60,
              color: Colors.grey[400],
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Create a prototype in just a few minutes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Pick these pre-made components and worry only about creating the best product ever.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          // Boton Next
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

/// Pagina 2
class _OnboardingInterestsPage extends StatelessWidget {
  final List<String> selectedInterests;
  final Function(String) onToggleInterest;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _OnboardingInterestsPage({
    super.key,
    required this.selectedInterests,
    required this.onToggleInterest,
    required this.onNext,
    required this.onBack,
  });

  final List<String> interests = const [
    'User Interface',
    'User Experience',
    'User Research',
    'UX Writing',
    'User Testing',
    'Service Design',
    'Strategy',
    'Design Systems',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const SizedBox(height: 40),
          // Status bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '9:41',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              Row(
                children: [
                  Icon(Icons.signal_cellular_alt, size: 16, color: Colors.grey[800]),
                  const SizedBox(width: 4),
                  Icon(Icons.wifi, size: 16, color: Colors.grey[800]),
                  const SizedBox(width: 4),
                  Icon(Icons.battery_full, size: 16, color: Colors.grey[800]),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
        
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.5,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 32),
        
          const Text(
            'Personalise your experience',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
       
          Text(
            'Choose your interests.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
         
          Expanded(
            child: ListView.builder(
              itemCount: interests.length,
              itemBuilder: (context, index) {
                final interest = interests[index];
                final isSelected = selectedInterests.contains(interest);
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InterestSelectorWidget(
                    label: interest,
                    isSelected: isSelected,
                    onTap: () => onToggleInterest(interest),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
      
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: selectedInterests.isNotEmpty ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey[300],
                disabledForegroundColor: Colors.grey[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}