import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../../../../shared/models/product_model.dart';
import '../../../../shared/models/category_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    return await _remoteDataSource.getFeaturedProducts();
  }

  @override
  Future<List<ProductModel>> getPerfectForYou() async {
    return await _remoteDataSource.getPerfectForYou();
  }

  @override
  Future<List<ProductModel>> getForThisSummer() async {
    return await _remoteDataSource.getForThisSummer();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await _remoteDataSource.getCategories();
  }

  @override
  Future<List<String>> getBanners() async {
    return await _remoteDataSource.getBanners();
  }
}
