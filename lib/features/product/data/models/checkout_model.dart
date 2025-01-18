import 'package:json_annotation/json_annotation.dart';
part 'checkout_model.g.dart';

@JsonSerializable()
class CheckoutModel {
  const CheckoutModel(this.statusCode, this.checkout);

  final int? statusCode;
  final CheckouItemModel? checkout;

  factory CheckoutModel.fromJson(Map<String, dynamic> json) =>
      _$CheckoutModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutModelToJson(this);
}

@JsonSerializable()
class CheckouItemModel {
  const CheckouItemModel(this.totalPrice, this.items);

  @JsonKey(name: "total_price")
  final double? totalPrice;
  final List<ItemModel> items;

  factory CheckouItemModel.fromJson(Map<String, dynamic> json) =>
      _$CheckouItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckouItemModelToJson(this);
}

@JsonSerializable()
class ItemModel {
  const ItemModel(
    this.id,
    this.name,
    this.quantity,
    this.description,
    this.image,
    this.totalPrice,
  );

  final String? id;
  final String? name;
  final int? quantity;
  final String? description;
  final String? image;
  @JsonKey(name: "total_price")
  final double? totalPrice;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
