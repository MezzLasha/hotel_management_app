import 'dart:convert';

class Room {
  final String id;
  final String owner;
  final String name;
  final String group;
  final String info;
  final String status;
  final String active;
  final String p_id;
  final String p_obj;
  final String p_user;
  final String p_owner;
  final String p_level;
  final String p_active;
  Room({
    required this.id,
    required this.owner,
    required this.name,
    required this.group,
    required this.info,
    required this.status,
    required this.active,
    required this.p_id,
    required this.p_obj,
    required this.p_user,
    required this.p_owner,
    required this.p_level,
    required this.p_active,
  });

  Room copyWith({
    String? id,
    String? owner,
    String? name,
    String? group,
    String? info,
    String? status,
    String? active,
    String? p_id,
    String? p_obj,
    String? p_user,
    String? p_owner,
    String? p_level,
    String? p_active,
  }) {
    return Room(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      name: name ?? this.name,
      group: group ?? this.group,
      info: info ?? this.info,
      status: status ?? this.status,
      active: active ?? this.active,
      p_id: p_id ?? this.p_id,
      p_obj: p_obj ?? this.p_obj,
      p_user: p_user ?? this.p_user,
      p_owner: p_owner ?? this.p_owner,
      p_level: p_level ?? this.p_level,
      p_active: p_active ?? this.p_active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner': owner,
      'name': name,
      'group': group,
      'info': info,
      'status': status,
      'active': active,
      'p_id': p_id,
      'p_obj': p_obj,
      'p_user': p_user,
      'p_owner': p_owner,
      'p_level': p_level,
      'p_active': p_active,
    };
  }

  factory Room.fromMap(Map<String, dynamic> map) {
    return Room(
      id: map['id'].toString(),
      owner: map['owner'].toString(),
      name: map['name'].toString(),
      group: map['group'].toString(),
      info: map['info'].toString(),
      status: map['status'].toString(),
      active: map['active'].toString(),
      p_id: map['p_id'].toString(),
      p_obj: map['p_obj'].toString(),
      p_user: map['p_user'].toString(),
      p_owner: map['p_owner'].toString(),
      p_level: map['p_level'].toString(),
      p_active: map['p_active'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Room.fromJson(dynamic json) => Room(
        id: json['O_ID'] == 'None' ? 'None' : json['O_ID'].toString(),
        owner: json['O_OWNER'] == 'None' ? 'None' : json['O_OWNER'].toString(),
        name: json['O_NAME'] == 'None' ? 'None' : json['O_NAME'].toString(),
        group: json['O_GROUP'] == 'None' ? 'None' : json['O_GROUP'].toString(),
        info: json['O_INFO'] == 'None' ? 'None' : json['O_INFO'].toString(),
        status:
            json['O_STATUS'] == 'None' ? 'None' : json['O_STATUS'].toString(),
        active: json['O_ACTIV'] == 'None' ? 'None' : json['O_ACTIV'].toString(),
        p_id: json['P_ID'] == 'None' ? 'None' : json['P_ID'].toString(),
        p_obj: json['P_OBJ'] == 'None' ? 'None' : json['P_OBJ'].toString(),
        p_user: json['P_USER'] == 'None' ? 'None' : json['P_USER'].toString(),
        p_owner:
            json['P_OWNER'] == 'None' ? 'None' : json['P_OWNER'].toString(),
        p_level:
            json['P_LEVEL'] == 'None' ? 'None' : json['P_LEVEL'].toString(),
        p_active:
            json['P_ACTIV'] == 'None' ? 'None' : json['P_ACTIV'].toString(),
      );

  @override
  String toString() {
    return 'Room(id: $id, owner: $owner, name: $name, group: $group, info: $info, status: $status, active: $active, p_id: $p_id, p_obj: $p_obj, p_user: $p_user, p_owner: $p_owner, p_level: $p_level, p_active: $p_active)';
  }

  @override
  bool operator ==(covariant Room other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.owner == owner &&
        other.name == name &&
        other.group == group &&
        other.info == info &&
        other.status == status &&
        other.active == active &&
        other.p_id == p_id &&
        other.p_obj == p_obj &&
        other.p_user == p_user &&
        other.p_owner == p_owner &&
        other.p_level == p_level &&
        other.p_active == p_active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        owner.hashCode ^
        name.hashCode ^
        group.hashCode ^
        info.hashCode ^
        status.hashCode ^
        active.hashCode ^
        p_id.hashCode ^
        p_obj.hashCode ^
        p_user.hashCode ^
        p_owner.hashCode ^
        p_level.hashCode ^
        p_active.hashCode;
  }
}
