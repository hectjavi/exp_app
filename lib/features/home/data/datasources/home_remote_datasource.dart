import '../../../../shared/models/product_model.dart';//'../../../shared/models/product_model.dart';
import '../../../../shared/models/category_model.dart';

class HomeRemoteDataSource {
  // Simulated API calls - replace with real API
  Future<List<ProductModel>> getFeaturedProducts() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockProducts.take(5).toList();
  }

  Future<List<ProductModel>> getPerfectForYou() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockProducts.skip(2).take(4).toList();
  }

  Future<List<ProductModel>> getForThisSummer() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _mockProducts.skip(4).take(4).toList();
  }

  Future<List<CategoryModel>> getCategories() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      const CategoryModel(id: '1', name: 'Men', image: '', productCount: 120),
      // const CategoryModel(id: '2', name: 'Women', image: '', productCount: 150),
      // const CategoryModel(id: '3', name: 'Kids', image: '', productCount: 80),
      // const CategoryModel(id: '4', name: 'Accessories', image: '', productCount: 200),
    ];
  }

  Future<List<String>> getBanners() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
      'https://images.unsplash.com/photo-1483985988355-763728e1935b',
      'https://images.unsplash.com/photo-1445205170230-053b83016050',
    ];
  }

  static final List<ProductModel> _mockProducts = [
    // const ProductModel(
    //   id: '1',
    //   name: 'Amazing T-shirt',
    //   description: 'The perfect T-shirt for when you want to feel comfortable but still stylish. Amazing for all occasions. Made of 100% cotton fabric in four colours. Its modern style gives a lighter look to the outfit. Perfect for the warmest days.',
    //   price: 12.00,
    //   images: [
    //     'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab',
    //     'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a',
    //   ],
    //   sizes: ['XS', 'S', 'M', 'L', 'XL'],
    //   colors: ['#000000', '#4A4A4A', '#C0C0C0', '#FFFFFF'],
    //   category: 'Men',
    //   rating: 4.5,
    //   reviewCount: 128,
    //   brand: 'Fashion Brand',
    //   material: '100% Cotton',
    // ),
    // const ProductModel(
    //   id: '2',
    //   name: 'Fabulous Pants',
    //   description: 'Stylish pants perfect for any occasion. Comfortable fit with modern design.',
    //   price: 15.00,
    //   images: [
    //     'https://images.unsplash.com/photo-1542272604-787c3835535d',
    //   ],
    //   sizes: ['42', '44', '46', '48'],
    //   colors: ['#000080', '#4A4A4A', '#C0C0C0'],
    //   category: 'Men',
    //   rating: 4.3,
    //   reviewCount: 89,
    // ),
    // const ProductModel(
    //   id: '3',
    //   name: 'Spectacular Dress',
    //   description: 'Elegant dress for special occasions. Gold color with premium fabric.',
    //   price: 20.00,
    //   images: [
    //     'https://images.unsplash.com/photo-1595777457583-95e059d581b8',
    //   ],
    //   sizes: ['XS', 'S', 'M', 'L'],
    //   colors: ['#FFD700', '#C0C0C0', '#000000'],
    //   category: 'Women',
    //   rating: 4.8,
    //   reviewCount: 256,
    // ),
    const ProductModel(
      id: '4',
      name: 'Jacket',
      description: 'Perfect for cold weather.',
      price: 18.00,
      images: [
        'https://images.unsplash.com/photo-1551028719-00167b16eac5',
      ],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['#000080', '#000000', '#4A4A4A'],
      category: 'Men',
      rating: 4.6,
      reviewCount: 167,
    ),
    const ProductModel(
      id: '5',
      name: 'hoes',
      description: 'Comfortable and stylish shoes for everyday wear.',
      price: 25.00,
      images: [
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
      ],
      sizes: ['38', '39', '40', '41', '42'],
      colors: ['#008000', '#000000', '#FFFFFF'],
      category: 'Accessories',
      rating: 4.4,
      reviewCount: 134,
    ),
    const ProductModel(
      id: '6',
      name: 'Summer Hat',
      description: 'Hat with UV protection.',
      price: 8.00,
      images: [
        'https://images.unsplash.com/photo-1521369909029-2afed882baee',
      ],
      sizes: ['One Size'],
      colors: ['#F5F5DC', '#FFFFFF', '#000000'],
      category: 'Accessories',
      rating: 4.2,
      reviewCount: 78,
    ),
    const ProductModel(
      id: '7',
      name: 'Beach Shorts',
      description: 'Comfortable beach shorts for summer days.',
      price: 10.00,
      images: [
        'https://images.unsplash.com/photo-1591195853828-11db59a44f6b',
      ],
      sizes: ['S', 'M', 'L', 'XL'],
      colors: ['#000080', '#FF6347', '#FFFFFF'],
      category: 'Men',
      rating: 4.1,
      reviewCount: 95,
    ),
    const ProductModel(
      id: '8',
      name: 'Elegant Blouse',
      description: 'Elegant blouse for professional and casual settings.',
      price: 14.00,
      images: [
        'https://images.unsplash.com/photo-1564257631407-4deb1f99d992',
      ],
      sizes: ['XS', 'S', 'M', 'L'],
      colors: ['#FFFFFF', '#FFC0CB', '#E6E6FA'],
      category: 'Women',
      rating: 4.5,
      reviewCount: 112,
    ),
  ];
}
