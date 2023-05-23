import 'package:flutter/material.dart';
import 'package:flutter_mqtt_chat/chat_model.dart';
import 'package:flutter_mqtt_chat/chat_widget.dart';
import 'package:flutter_mqtt_chat/mqtt_handler.dart';

class MessageScreen extends StatefulWidget {
  final UserModel user;
  final String phoneNumber;

  const MessageScreen(
      {super.key, required this.user, required this.phoneNumber});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  var textEditingController = TextEditingController();
  MqttHandler mqttHandler = MqttHandler();

  @override
  void initState() {
    super.initState();
    mqttHandler.connect(widget.phoneNumber + widget.user.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(widget.user.name,
              style: const TextStyle(fontSize: 20, color: Colors.black))),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<String>(
                builder: (BuildContext context, String value, Widget? child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: mqttHandler.chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ChatWidget(item: mqttHandler.chats[index]),
                      );
                    },
                  );
                },
                valueListenable: mqttHandler.data,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: textEditingController,
                decoration: inputDecoration("Type here..."),
              ),
            ),
          ],
        ),
      ),
    );
  }

  inputDecoration(String hint) {
    return InputDecoration(
        suffixIcon: InkWell(
            onTap: () {
              if (textEditingController.text.isNotEmpty) {
                mqttHandler.publishMessage(textEditingController.text,
                    widget.user.phoneNumber + widget.phoneNumber);
                setState(() {
                  mqttHandler.chats.add(ChatModel(
                      message: textEditingController.text, isSender: false));
                  textEditingController.text="";
                });
              }
            },
            child: const Icon(
              Icons.send,
              color: Colors.black,
            )),
        isDense: true,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        filled: true,
        hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
        hintText: hint,
        counterText: '',
        fillColor: Colors.white);
  }
}
