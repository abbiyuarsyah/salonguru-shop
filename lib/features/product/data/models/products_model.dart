import 'package:json_annotation/json_annotation.dart';
part 'products_model.g.dart';

@JsonSerializable()
class ProductsModel {
  const ProductsModel(this.statusCode, this.products);

  final int? statusCode;
  final List<ProductModel>? products;

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  const ProductModel(
    this.id,
    this.name,
    this.quantity,
    this.description,
    this.image,
  );

  final int? id;
  final String? name;
  final int? quantity;
  final String? description;
  final String? image;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
