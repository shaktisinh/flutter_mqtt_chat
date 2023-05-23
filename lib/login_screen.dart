import 'package:flutter/material.dart';
import 'package:flutter_mqtt_chat/chat_screen.dart';
import 'package:flutter_mqtt_chat/mqtt_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var textEditingController = TextEditingController();
  MqttHandler mqttHandler = MqttHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "Enter your phone number\nand start the conversation...",
                    style: TextStyle(fontSize: 20, color: Colors.black)),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLines: 1,
                  decoration: inputDecoration("Enter phone number"),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                      onPressed: () {
                        if (textEditingController.text.length >= 10) {
                          mqttHandler.connect(textEditingController.text);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    phoneNumber: textEditingController.text,
                                  )));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please enter valid mobile number."),
                          ));
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                      ),
                      child: const Text("Lets Start",
                          style: TextStyle(fontSize: 16, color: Colors.white))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  inputDecoration(String hint) {
    return InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: const BorderSide(
            color: Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
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
