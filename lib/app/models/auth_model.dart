import 'dart:convert';

class AuthModel {
  AuthModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}
