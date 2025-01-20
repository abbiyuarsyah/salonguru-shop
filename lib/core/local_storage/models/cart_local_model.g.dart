// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartLocalModelAdapter extends TypeAdapter<CartLocalModel> {
  @override
  final int typeId = 1;

  @override
  CartLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartLocalModel(
      id: fields[0] as int,
      productId: fields[1] as int,
      totalPrice: fields[2] as double,
      quantity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartLocalModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.totalPrice)
      ..writeByte(3)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
