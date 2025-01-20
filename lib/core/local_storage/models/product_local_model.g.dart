// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_local_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductLocalModelAdapter extends TypeAdapter<ProductLocalModel> {
  @override
  final int typeId = 2;

  @override
  ProductLocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductLocalModel(
      id: fields[0] as int,
      name: fields[1] as String,
      quantity: fields[2] as int,
      description: fields[3] as String,
      image: fields[4] as String,
      price: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, ProductLocalModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductLocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
