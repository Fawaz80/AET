import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum Sender { user, ai }

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_ChatMessage> _messages = [];
  final TextEditingController _controller = TextEditingController();

  // Bubble colors
  final Color _userColor   = const Color(0xFFD4F1A3);  // light green
  final Color _aiColor     = const Color(0xFFB3C7F9);  // light blue
  final Color _borderGrey  = Colors.grey.shade400;
  final Color _primaryColor= const Color.fromARGB(255, 59, 35, 245);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,          // entire page white
      appBar: AppBar(                         // white bar, no title
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          // Chat area
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'lib/assets/chat_placeholder.png',
                          width: 120,
                          height: 120,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "Talk to your spending",
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _messages.length,
                    itemBuilder: (context, i) {
                      final msg    = _messages[i];
                      final isUser = msg.sender == Sender.user;
                      return Align(
                        alignment: isUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color: isUser ? _userColor : _aiColor,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 16),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Input area with grey border around both TextField and send button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: _borderGrey),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      style: GoogleFonts.inter(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: "Ask Me Anything...",
                        hintStyle: GoogleFonts.inter(color: Colors.black38),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (_) => _handleSend(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    color: _primaryColor,
                    onPressed: _handleSend,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(_ChatMessage(text, Sender.user));
    });
    _controller.clear();

    // Call your AI integration
    _sendToAi(text).then((reply) {
      setState(() {
        _messages.add(_ChatMessage(reply, Sender.ai));
      });
    });
  }

  Future<String> _sendToAi(String prompt) async {
    //  integrate AI API here
    await Future.delayed(const Duration(seconds: 1));
    return "AI response to: \"$prompt\"";
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _ChatMessage {
  final String text;
  final Sender sender;
  _ChatMessage(this.text, this.sender);
}
