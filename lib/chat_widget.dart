import 'package:flutter/material.dart';
import 'package:flutter_mqtt_chat/chat_model.dart';

class ChatWidget extends StatelessWidget {
  final ChatModel item;

  const ChatWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: item.isSender?MainAxisAlignment.start:MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: item.isSender ? Colors.grey : Colors.black87,
                border: Border.all(
                  color: item.isSender ? Colors.grey : Colors.black87,
                ),
                borderRadius: item.isSender?const BorderRadius.only(topRight:Radius.circular(20), topLeft: Radius.circular(20),bottomRight:Radius.circular(20)):
                const BorderRadius.only(topRight:Radius.circular(20), topLeft: Radius.circular(20),bottomLeft:Radius.circular(20))),
            child: Text(
              item.message,
              style:  TextStyle(
                  fontWeight: FontWeight.w500, fontSize: 14, color: item.isSender?Colors.black:Colors.white),
            )),
      ],
    );
  }
}
