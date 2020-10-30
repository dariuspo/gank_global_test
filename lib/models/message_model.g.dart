// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map json) {
  return MessageModel(
    id: json['id'] as String,
    message: json['message'] as String,
    fromUid: json['fromUid'] as String,
    toUid: json['toUid'] as String,
    dateTime: timeStampToDateFromJson(json['dateTime'] as Timestamp),
    channelId: json['channelId'] as String,
    isRead: json['isRead'] as bool,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'fromUid': instance.fromUid,
      'toUid': instance.toUid,
      'dateTime': dateTimeToTimeStampToJson(instance.dateTime),
      'channelId': instance.channelId,
      'isRead': instance.isRead,
    };
