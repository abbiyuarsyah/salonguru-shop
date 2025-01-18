// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutModel _$CheckoutModelFromJson(Map<String, dynamic> json) =>
    CheckoutModel(
      (json['statusCode'] as num?)?.toInt(),
      json['checkout'] == null
          ? null
          : CheckouItemModel.fromJson(json['checkout'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CheckoutModelToJson(CheckoutModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'checkout': instance.checkout,
    };

CheckouItemModel _$CheckouItemModelFromJson(Map<String, dynamic> json) =>
    CheckouItemModel(
      (json['total_price'] as num?)?.toDouble(),
      (json['items'] as List<dynamic>)
          .map((e) => ItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckouItemModelToJson(CheckouItemModel instance) =>
    <String, dynamic>{
      'total_price': instance.totalPrice,
      'items': instance.items,
    };

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      json['id'] as String?,
      json['name'] as String?,
      (json['quantity'] as num?)?.toInt(),
      json['description'] as String?,
      json['image'] as String?,
      (json['total_price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'quantity': instance.quantity,
      'description': instance.description,
      'image': instance.image,
      'total_price': instance.totalPrice,
    };
