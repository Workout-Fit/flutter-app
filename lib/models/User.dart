import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'User.g.dart';

@immutable
@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final bool isSignedUp;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phoneNumber;

  const User({
    required this.id,
    this.isSignedUp = false,
    this.email,
    this.phoneNumber,
  });

  static const empty = User(id: '');
  static const boxKeyName = 'user';

  User copyWith({
    String? id,
    String? email,
    String? phoneNumber,
    bool? isSignedUp,
  }) {
    return User(
      id: id ?? this.id,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, email, phoneNumber];
}
