import 'package:flutter/foundation.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String medicalLicenseId;
  final String email;
  final String phoneNumber;
  final String profileVerificationStatus;
  final String profilePictureUrl;
  final String phoneVerificationStatus;
  final List<String> deviceTokens;
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.medicalLicenseId,
    required this.email,
    required this.phoneNumber,
    required this.profileVerificationStatus,
    required this.profilePictureUrl,
    required this.phoneVerificationStatus,
    required this.deviceTokens,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      medicalLicenseId: map['medicalLicenseId'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profileVerificationStatus: map['profileVerificationStatus'] ?? '',
      profilePictureUrl: map['profilePictureUrl'] ?? '',
      phoneVerificationStatus: map['phoneVerificationStatus'] ?? '',
      deviceTokens: List<String>.from(map['deviceTokens']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.medicalLicenseId == medicalLicenseId &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.profileVerificationStatus == profileVerificationStatus &&
        other.profilePictureUrl == profilePictureUrl &&
        other.phoneVerificationStatus == phoneVerificationStatus &&
        listEquals(other.deviceTokens, deviceTokens);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        medicalLicenseId.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        profileVerificationStatus.hashCode ^
        profilePictureUrl.hashCode ^
        phoneVerificationStatus.hashCode ^
        deviceTokens.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, medicalLicenseId: $medicalLicenseId, email: $email, phoneNumber: $phoneNumber, profileVerificationStatus: $profileVerificationStatus, profilePictureUrl: $profilePictureUrl, phoneVerificationStatus: $phoneVerificationStatus, deviceTokens: $deviceTokens)';
  }
}
