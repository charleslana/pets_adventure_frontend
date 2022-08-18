// ignore_for_file: sort_constructors_first

import 'dart:convert';

class ResponseSuccessDto {
  final String success;

  ResponseSuccessDto({
    required this.success,
  });

  ResponseSuccessDto copyWith({
    String? success,
  }) {
    return ResponseSuccessDto(
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory ResponseSuccessDto.fromMap(Map<String, dynamic> map) {
    return ResponseSuccessDto(
      success: map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseSuccessDto.fromJson(String source) =>
      ResponseSuccessDto.fromMap(json.decode(source) as Map<String, dynamic>);
}
