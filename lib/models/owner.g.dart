// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OwnerAdapter extends TypeAdapter<Owner> {
  @override
  final int typeId = 2;

  @override
  Owner read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Owner(
      accountId: fields[0] as int?,
      reputation: fields[1] as int?,
      userId: fields[2] as int?,
      userType: fields[3] as String?,
      acceptRate: fields[4] as int?,
      profileImage: fields[5] as String?,
      displayName: fields[6] as String?,
      link: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Owner obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.accountId)
      ..writeByte(1)
      ..write(obj.reputation)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.userType)
      ..writeByte(4)
      ..write(obj.acceptRate)
      ..writeByte(5)
      ..write(obj.profileImage)
      ..writeByte(6)
      ..write(obj.displayName)
      ..writeByte(7)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
