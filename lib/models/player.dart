// ignore_for_file: public_member_api_docs, sort_constructors_first

class PlayerModel {
  final String nickname;
  final String socketId;
  final double points;
  final String playerType;

  PlayerModel(this.nickname, this.socketId, this.points, this.playerType);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nickname': nickname,
      'socketId': socketId,
      'points': points,
      'playerType': playerType,
    };
  }

  factory PlayerModel.fromMap(Map<String, dynamic> map) {
    return PlayerModel(
      map['nickname'] as String,
      map['socketId'] as String,
      (map['points']?.toDouble() ?? 0.0) as double,
      map['playerType'] as String,
    );
  }

  PlayerModel copyWith({
    String? nickname,
    String? socketId,
    double? points,
    String? playerType,
  }) {
    return PlayerModel(
      nickname ?? this.nickname,
      socketId ?? this.socketId,
      points ?? this.points,
      playerType ?? this.playerType,
    );
  }
}
