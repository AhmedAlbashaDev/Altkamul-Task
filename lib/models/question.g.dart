// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionModelAdapter extends TypeAdapter<QuestionModel> {
  @override
  final int typeId = 1;

  @override
  QuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionModel(
      tags: (fields[0] as List?)?.cast<String>(),
      owner: fields[1] as Owner?,
      isAnswered: fields[2] as bool?,
      viewCount: fields[3] as int?,
      protectedDate: fields[4] as int?,
      acceptedAnswerId: fields[5] as int?,
      answerCount: fields[6] as int?,
      communityOwnedDate: fields[7] as int?,
      score: fields[8] as int?,
      lastActivityDate: fields[9] as int?,
      creationDate: fields[10] as int?,
      lastEditDate: fields[11] as int?,
      questionId: fields[12] as int?,
      contentLicense: fields[13] as String?,
      link: fields[14] as String?,
      title: fields[15] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionModel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.tags)
      ..writeByte(1)
      ..write(obj.owner)
      ..writeByte(2)
      ..write(obj.isAnswered)
      ..writeByte(3)
      ..write(obj.viewCount)
      ..writeByte(4)
      ..write(obj.protectedDate)
      ..writeByte(5)
      ..write(obj.acceptedAnswerId)
      ..writeByte(6)
      ..write(obj.answerCount)
      ..writeByte(7)
      ..write(obj.communityOwnedDate)
      ..writeByte(8)
      ..write(obj.score)
      ..writeByte(9)
      ..write(obj.lastActivityDate)
      ..writeByte(10)
      ..write(obj.creationDate)
      ..writeByte(11)
      ..write(obj.lastEditDate)
      ..writeByte(12)
      ..write(obj.questionId)
      ..writeByte(13)
      ..write(obj.contentLicense)
      ..writeByte(14)
      ..write(obj.link)
      ..writeByte(15)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
