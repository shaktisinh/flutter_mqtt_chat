import 'package:flutter/material.dart';
import 'package:flutter_mqtt_chat/chat_model.dart';
import 'package:flutter_mqtt_chat/login_screen.dart';
import 'package:flutter_mqtt_chat/message_screen.dart';
import 'package:flutter_mqtt_chat/mqtt_handler.dart';
import 'package:flutter_mqtt_chat/user_widget.dart';

class ChatScreen extends StatefulWidget {
  final String phoneNumber;

  const ChatScreen({super.key, required this.phoneNumber});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<UserModel> users = [];

  var textEditingController = TextEditingController();
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.logout_outlined),
              onPressed: () {
                mqttHandler.unSubscribe(widget.phoneNumber);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LoginScreen()));
              },
            ),
            title: const Text("Chat",
                style: TextStyle(fontSize: 20, color: Colors.black))),
        body: SafeArea(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                MessageScreen(user: users[index], phoneNumber: widget.phoneNumber,)));
                      },
                      child: UserWidget(item: users[index]));
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  height: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _getUsers() {
   //TODO add list of user here
    users.removeWhere((item) => item.phoneNumber == widget.phoneNumber);
  }
}
