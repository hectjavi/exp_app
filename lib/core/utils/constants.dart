class AppConstants {
  // API Endpoints
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';

  // Storage Keys
  static const String cartBoxName = 'cartBox';
  static const String favoritesKey = 'favorites';

  // Pagination
  static const int defaultPageSize = 20;

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);

  // Image Assets
  static const String placeholderImage = 'assets/images/placeholder.png';
  static const String errorImage = 'assets/images/error.png';

  // Currency
  static const String currencySymbol = 'Q';
}
