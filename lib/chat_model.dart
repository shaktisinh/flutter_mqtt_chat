class UserModel {
  final String phoneNumber;
  final String name;

  const UserModel({required this.phoneNumber, required this.name});
}

class ChatModel {
  final String message;
  final bool isSender;

  const ChatModel({required this.message, required this.isSender});
}