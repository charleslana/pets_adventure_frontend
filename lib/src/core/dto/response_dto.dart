// ignore_for_file: sort_constructors_first

import 'dart:convert';

class ResponseDto {
  final String error;

  ResponseDto({
    required this.error,
  });

  ResponseDto copyWith({
    String? error,
  }) {
    return ResponseDto(
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'error': error,
    };
  }

  factory ResponseDto.fromMap(Map<String, dynamic> map) {
    return ResponseDto(
      error: map['error'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseDto.fromJson(String source) =>
      ResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
