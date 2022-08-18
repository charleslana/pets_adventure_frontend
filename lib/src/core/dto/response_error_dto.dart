// ignore_for_file: sort_constructors_first

import 'dart:convert';

class ResponseErrorDto {
  final String error;

  ResponseErrorDto({
    required this.error,
  });

  ResponseErrorDto copyWith({
    String? error,
  }) {
    return ResponseErrorDto(
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
    };
  }

  factory ResponseErrorDto.fromMap(Map<String, dynamic> map) {
    return ResponseErrorDto(
      error: map['error'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseErrorDto.fromJson(String source) =>
      ResponseErrorDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
