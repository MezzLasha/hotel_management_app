import 'dart:convert';

class User {
  final int id;
  final String mail;
  final String password;
  final String name;
  final String identification;
  final String phone;
  final String comment;
  final String lang;
  final int active;
  User({
    required this.id,
    required this.mail,
    required this.password,
    required this.name,
    required this.identification,
    required this.phone,
    required this.comment,
    required this.lang,
    required this.active,
  });

  User copyWith({
    int? id,
    String? mail,
    String? password,
    String? name,
    String? identification,
    String? phone,
    String? comment,
    String? lang,
    int? active,
  }) {
    return User(
      id: id ?? this.id,
      mail: mail ?? this.mail,
      password: password ?? this.password,
      name: name ?? this.name,
      identification: identification ?? this.identification,
      phone: phone ?? this.phone,
      comment: comment ?? this.comment,
      lang: lang ?? this.lang,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'U_ID': id,
      'U_MAIL': mail,
      'U_PASS': password,
      'U_NAME': name,
      'U_IDENT': identification,
      'U_TEL': phone,
      'U_COMMENT': comment,
      'U_LANG': lang,
      'U_ACTIVE': active,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['U_ID'] as int,
      mail: map['U_MAIL'] as String,
      password: map['U_PASS'] as String,
      name: map['U_NAME'] as String,
      identification: map['U_IDENT'] as String,
      phone: map['U_TEL'] as String,
      comment: map['U_COMMENT'] as String,
      lang: map['U_LANG'] as String,
      active: map['U_ACTIVE'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(u_id: $id, mail: $mail, password: $password, name: $name, identification: $identification, phone: $phone, comment: $comment, lang: $lang, active: $active)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.mail == mail &&
        other.password == password &&
        other.name == name &&
        other.identification == identification &&
        other.phone == phone &&
        other.comment == comment &&
        other.lang == lang &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        mail.hashCode ^
        password.hashCode ^
        name.hashCode ^
        identification.hashCode ^
        phone.hashCode ^
        comment.hashCode ^
        lang.hashCode ^
        active.hashCode;
  }
}
