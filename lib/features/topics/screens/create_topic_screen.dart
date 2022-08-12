import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_practice_chat_flutter/features/topics/topics.dart';

class CreateTopicScreen extends StatefulWidget {
  const CreateTopicScreen({super.key});

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  bool isAddTopic = false;
  final TextEditingController _textEditingController = TextEditingController();

  void _createTopic() {
    GetIt.I<TopicsCubit>().createTopic(_textEditingController.text);
    _textEditingController.text = '';
    isAddTopic = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isAddTopic = !isAddTopic;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.green,
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.black87,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.green,
                  ),
                ),
                Text(
                  tr('addChat'),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            if (isAddTopic)
              Padding(
                padding: const EdgeInsets.only(
                  top: 5.0,
                  bottom: 10.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          hintText: tr('chatName'),
                          hintStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black87),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40.0,
                      width: 40.0,
                      margin: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.black87,
                      ),
                      child: IconButton(
                        padding: const EdgeInsets.all(5),
                        onPressed: _createTopic,
                        icon: const Icon(
                          Icons.group_add_rounded,
                          size: 20.0,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
