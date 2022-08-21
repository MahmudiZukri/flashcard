part of 'models.dart';

class FlashcardUser extends Equatable {
  final String id;
  final String? email;
  final String name;

  const FlashcardUser(this.id, this.email, {required this.name});

  @override
  String toString() {
    return "$id, $name, $email";
  }

  @override
  List<Object?> get props => [id, name, email];
}
