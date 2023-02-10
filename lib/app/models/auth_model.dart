import 'dart:convert';

class AuthModel {
  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
    );
  }

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

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'AuthModel(accessToken: $accessToken, refreshToken: $refreshToken)';
}
