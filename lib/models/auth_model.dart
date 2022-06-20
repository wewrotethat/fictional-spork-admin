class AuthModel {
  final String id;
  final String token;
  AuthModel({
    required this.id,
    required this.token,
  });

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      id: map['id'] ?? '',
      token: map['token'] ?? '',
    );
  }

  @override
  String toString() => 'AuthModel(id: $id, token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel && other.id == id && other.token == token;
  }

  @override
  int get hashCode => id.hashCode ^ token.hashCode;
}
