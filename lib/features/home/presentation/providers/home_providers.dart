import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/entities/home_entity.dart';
import '../states/home_state.dart';

// Repository Provider
final homeRepositoryProvider = Provider((ref) {
  return HomeRepositoryImpl(HomeRemoteDataSource());
});

// Home Notifier
class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepositoryImpl _repository;

  HomeNotifier(this._repository) : super(HomeState.initial());

  Future<void> loadHomeData() async {
    state = HomeState.loading();

    try {
      final featured = await _repository.getFeaturedProducts();
      final perfect = await _repository.getPerfectForYou();
      final summer = await _repository.getForThisSummer();
      final categories = await _repository.getCategories();
      final banners = await _repository.getBanners();

      // Mapper: Models (data) → Entity (domain) → State (presentation)
      final entity = HomeEntity(
        featuredProducts: featured,
        perfectForYou: perfect,
        forThisSummer: summer,
        categories: categories,
        banners: banners,
      );

      state = HomeState.success(entity);
    } catch (e) {
      state = HomeState.failure(e.toString());
    }
  }
}

// Home Notifier Provider
final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  return HomeNotifier(repository);
});
