import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_model.freezed.dart';
part 'order_item_model.g.dart';

@freezed
class OrderItemModel with _$OrderItemModel {
  const factory OrderItemModel({
    required String productId,
    required String name,
    required double price,
    required int quantity,
    required String image,
  }) = _OrderItemModel;

  factory OrderItemModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$OrderItemModelFromJson(json);
}