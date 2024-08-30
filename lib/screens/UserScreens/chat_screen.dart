import 'package:dealdiscover/blocs/conversation/conv_events.dart';
import 'package:dealdiscover/screens/UserScreens/bot_screen.dart';
import 'package:dealdiscover/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:intl/intl.dart';

import '../../blocs/conversation/conv_bloc.dart';
import '../../blocs/conversation/conv_states.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ConvBloc Convb;
  bool isLoading = false;
  List<types.Message> _messages = [];
  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );

  final _chatbot = const types.User(
    id: 'Dedi-bot', // Unique ID for the chatbot
    firstName: 'Dedi', // Name of the chatbot
  );

  final TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    Convb=BlocProvider.of<ConvBloc>(context);
    Convb.add(StartConvEvent(messages: []));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final msg=BlocBuilder<ConvBloc,ConvStates>(builder: (context,state){
      if(state is ConvLoadingState){
        return Center(child: CircularProgressIndicator(backgroundColor: Colors.black,),);
      }else{
        return Container();
      }
    });
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          GestureDetector(
            onTap: () {
              loadingHandler(context);
            },
            child: Container(
              margin: EdgeInsets.only(right: 330),
              child: Image.asset(
                'assets/images/arrowL.png',
                width: 45.0,
                height: 45.0,
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      body:BlocConsumer<ConvBloc,ConvStates>(
          listener: (context,state){
            if(state is ConvErrorState ){
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('ERROR:'+state.message)),
              );
            }
          },

          builder: (context,state)
          {
            if (state is ConvdiscussionLoaded){
            return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/chatbg.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Chat(
                messages: state.messages,
                onSendPressed: (types.PartialText message) {},
                user: _user,
                showUserAvatars: true,
                showUserNames: true,
                avatarBuilder: (user) {
                  if (user.id == _chatbot.id) {
                    return _buildChatbotAvatar();
                  } else {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Default color
                      ),
                    );
                  }
                },
                customBottomWidget: _buildInput(state.convID,state.messages),
              ),
            ),
          ],
        ),
      );
          }
          else {return Container();}}),
    );
  }

  Widget _buildInput(String convID,List<types.Message> _messages) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25, horizontal: 25),
                hintText: "Write a message",
                filled: true,
                fillColor: MyColors.backbtn1,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.btnColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: MyColors.btnBorderColor,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                suffixIcon: Container(
                  margin: EdgeInsets.only(right: 7),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: MyColors.btnColor,
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          final text = _controller.text;
                          if (text.isNotEmpty) {
                            Convb.add(SendMButtonPressed(message: _handleSendPressed(text), messages: _messages, convID: convID)) ;

                            _controller.clear();
                          }
                        },
                        child: Image.asset(
                          'assets/images/send.png',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatbotAvatar() {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: MyColors.grey,
        border: Border.all(
          color: MyColors.btnColor,
          width: 3,
        ),
      ),
      child: Image.asset(
        'assets/images/dedi_avatar.png',
        width: 24,
        height: 24,
      ),
    );
  }

  Widget _buildMessage(types.Message message) {
    if (message.author.id == _user.id) {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.blueAccent, // User message background color
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            (message as types.TextMessage).text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    } else if (message.author.id == _chatbot.id) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey[300], // Chatbot message background color
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            (message as types.TextMessage).text,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    return Container(); // Return an empty container for unknown message types
  }

  types.TextMessage _handleSendPressed(String text) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: text,
    );
    return textMessage ;

    // _addMessage(textMessage);

    // Simulate a response from the chatbot after a short delay
    Future.delayed(const Duration(seconds: 1), () {
      _simulateChatbotResponse();
    });
  }

  void _simulateChatbotResponse() {
    final botMessage = types.TextMessage(
      author: _chatbot,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: DateTime.now().toIso8601String(),
      text: 'Hello! I am Dedi, how can I assist you today?', // Example response
    );

    _addMessage(botMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void loadingHandler(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        isLoading = false;
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(
            builder: (_) => const BotScreen(),
          ),
        );
      });
    });
  }
}
