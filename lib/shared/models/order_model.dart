import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  const factory OrderModel({
    required String id,
    required String userId,
    required String userEmail,
    required double total,
    required DateTime createdAt,
    required String status,
    required List<OrderItemModel> items,
  }) = _OrderModel;

  factory OrderModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$OrderModelFromJson(json);
}