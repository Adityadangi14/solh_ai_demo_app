import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:markdown_widget/config/all.dart';
import 'package:markdown_widget/widget/all.dart';
import 'package:solh_ai_app/chat/services/chat_services.dart';
import 'package:solh_ai_app/helper/shared_prefrences/user_id.dart';
import 'package:solh_ai_app/services/graphql_client.dart';
import 'package:flutter_highlight/themes/a11y-light.dart';
import 'package:stac/stac.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class Message {
  final String body;
  final String author;
  final String dateTime;
  final String authorId;
  final String conversationType;

  Message({
    required this.body,
    required this.author,
    required this.dateTime,
    required this.authorId,
    required this.conversationType,
  });
}

class _ChatScreenState extends State<ChatScreen> {
  final ValueNotifier<List<Message>> _convo = ValueNotifier([]);
  final ValueNotifier<bool> isSendingMessage = ValueNotifier(false);
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  ChatServices chatServices = ChatServices();

  Future<String> getAIResponse() async {

    String? res = await chatServices.sendInitialMessage(
      GraphqlClient.I.client.value,
      userId: UserId.I.userId,
    );
    log(res ?? "", name: "res");
    return res ?? "";
  }

  @override
  void initState() {

    getPreviousChat();
    super.initState();
  }

  Future<void> sendInitialMessage() async {
    String res = await getAIResponse();

    Message message = Message(
      body: res,
      author: "ai",
      dateTime: "",
      authorId: "ai-001",
      conversationType: "text",
    );

    _convo.value = List.from(_convo.value)..add(message);
  }

  Future<void> sendMessage(String query) async {
    isSendingMessage.value = true;

    Message userMessage = Message(
      body: query,
      author: "user",
      dateTime: "",
      authorId: UserId.I.userId,
      conversationType: "text",
    );
    _convo.value = List.from(_convo.value)..add(userMessage);

    String? res = await chatServices.getResponse(
      GraphqlClient.I.client.value,
      query: query,
      userId: UserId.I.userId,
    );

    Message aiMessage = Message(
      body: res ?? "",
      author: "ai",
      dateTime: "",
      authorId: "ai-001",
      conversationType: "text",
    );
    _convo.value = List.from(_convo.value)..add(aiMessage);
    isSendingMessage.value = false;
  }

  void getPreviousChat() async {
    List<Map<String, dynamic>> resposne = await chatServices.getChatByUserId(
      GraphqlClient.I.client.value,
      userId: UserId.I.userId,
    );

    for (var i in resposne) {
      Message aiMessage = Message(
        body: i["answer"],
        author: "ai",
        dateTime: i["timestamp"],
        authorId: "ai-001",
        conversationType: "text",
      );
      _convo.value = List.from(_convo.value)..add(aiMessage);
      if (i["query"] != "") {
        Message userMessage = Message(
          body: i["query"],
          author: "user",
          dateTime: i["timestamp"],
          authorId: "ai-001",
          conversationType: "text",
        );

        _convo.value = List.from(_convo.value)..add(userMessage);
      }
    }
    _convo.value = _convo.value.reversed.toList();
    if (resposne.isEmpty) {
      await sendInitialMessage();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size; // Not directly needed in ChatScreen's build
    return Scaffold(
      appBar: AppBar(title: const Text("Solh AI")),
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: _convo,
            builder: (context, value, child) {
              return Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _convo,
                        builder: (context, value, child) {
                          return ListView.builder(
                            reverse: true,
                            controller: _scrollController,
                            padding: const EdgeInsets.all(12),
                            itemCount: value.length,
                            itemBuilder: (context, index) {
                              final reversedIndex = value.length - 1 - index;
                              final message = value[reversedIndex];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4.0,
                                ),
                                child: MessageTile(message: message),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: isSendingMessage,
                      builder: (context, value, child) {
                        return value
                            ? const Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Thinking...",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: (value) {},
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    if (_textController.text.trim() != "") {
                      sendMessage(_textController.text.trim());
                      _textController.text = "";
                    }
                  },
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    var mess = message.author == 'user'?message.body :jsonDecode(message.body);
    Size size = MediaQuery.of(context).size;
    final isUser = message.author == 'user';
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.width * 0.75,
        ), // Limit the width to 75% of screen width
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color:
              isUser
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(12),
        ),

        // Directly put MarkdownWidget here.
        // The ListView.builder will handle the overall scrolling.
        child:
            isUser
                ? SelectableText(
                  message.body,
                  style: TextStyle(color: Colors.black),
                )
                : Column(
                  children: [
                    Column(
                      children: [
                        MarkdownWidget(
                          data: mess["text"],
                          shrinkWrap: true,
                        
                          config: MarkdownConfig(
                            configs: [
                              PConfig(
                                textStyle: TextStyle(
                                  color: isUser ? Colors.white : Colors.black,
                                  // Ensure text is visible in light theme for AI messages
                                ),
                              ),
                        
                              PreConfig(
                                theme: a11yLightTheme, // Code block theme
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ), // Text color for code blocks
                              ),
                        
                              CodeConfig(
                                style: const TextStyle(
                                  color: Colors.black,
                                ), // Inline code text color
                              ),
                              // Add other configs as needed, e.g., H1Config, H2Config, LinkConfig
                            ],
                          ),
                        ),
                        getRecommendation( mess["recommendation"])
                      ],
                    ),
                  ],
                ),
      ),
    );
  }
}


Widget getRecommendation(List recomm){
  return ListView.separated(shrinkWrap: true,physics: NeverScrollableScrollPhysics() ,itemCount: recomm.length,separatorBuilder: (context, index) {
   return SizedBox(height: 10,);
  }, itemBuilder: (context, index) {
log(recomm[index]["content"].toString(),name: "list");
final content = json.decode(recomm[index]["content"]);
    return Stac.fromJson(content,context);
  },);
}
