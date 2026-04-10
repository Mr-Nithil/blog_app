import 'package:blog_app/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    final userMetadata = map['user_metadata'] as Map<String, dynamic>?;
    final rawUserMetaData = map['raw_user_meta_data'] as Map<String, dynamic>?;
    final topLevelName = (map['name'] as String?)?.trim() ?? '';
    final metadataName = (userMetadata?['name'] as String?)?.trim() ?? '';
    final rawMetadataName = (rawUserMetaData?['name'] as String?)?.trim() ?? '';

    final resolvedName = topLevelName.isNotEmpty
        ? topLevelName
        : (metadataName.isNotEmpty ? metadataName : rawMetadataName);

    return UserModel(
      id: map['id'] ?? '',
      name: resolvedName,
      email: map['email'] ?? '',
    );
  }

  UserModel copyWith({String? id, String? name, String? email}) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
