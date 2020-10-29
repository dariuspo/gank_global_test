import 'package:json_annotation/json_annotation.dart';

part 'call_model.g.dart';
@JsonSerializable(
  anyMap: true,
  explicitToJson: true,
)
class CallModel {
  String callerId;
  String callerName;
  String receiverId;
  String receiverName;
  String channelId;
  bool hasDialled;

  CallModel({
    this.callerId,
    this.callerName,
    this.receiverId,
    this.receiverName,
    this.channelId,
    this.hasDialled,
  });

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);

  Map<String, dynamic> toJson() => _$CallModelToJson(this);
}
