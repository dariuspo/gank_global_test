// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map json) {
  return MessageModel(
    message: json['message'] as String,
    fromUid: json['fromUid'] as String,
    dateTime: json['dateTime'] == null
        ? null
        : DateTime.parse(json['dateTime'] as String),
    channelId: json['channelId'] as String,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'fromUid': instance.fromUid,
      'dateTime': instance.dateTime?.toIso8601String(),
      'channelId': instance.channelId,
    };
