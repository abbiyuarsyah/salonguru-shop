import 'package:json_annotation/json_annotation.dart';
part 'checkout_request.g.dart';

@JsonSerializable()
class CheckoutRequest {
  const CheckoutRequest({required this.quantity, required this.productId});

  final int quantity;
  @JsonKey(name: "product_id")
  final int? productId;

  factory CheckoutRequest.fromJson(Map<String, dynamic> json) =>
      _$CheckoutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutRequestToJson(this);
}
