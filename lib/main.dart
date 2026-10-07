import 'package:flutter/material.dart';

void main() {
  runApp(const AlayanSS2App());
}

class AlayanSS2App extends StatelessWidget {
  const AlayanSS2App({super.key});

  @mainTheme
  ThemeData get _whatsappDarkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121B22),
        primaryColor: const Color(0xFF00A884),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00A884),
          secondary: Color(0xFF005C4B),
          surface: Color(0xFF1F2C34),
          background: Color(0xFF121B22),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1F2C34),
          elevation: 0,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alayan SS2 Members Group',
      debugShowCheckedModeBanner: false,
      theme: _whatsappDarkTheme,
      home: const AuthScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// AUTHENTICATION SCREEN (Register / Login)
// -----------------------------------------------------------------------------
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  void _submit() {
    // Mock authentication
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_rounded, size: 80, color: Color(0xFF00A884)),
              const SizedBox(height: 16),
              const Text(
                'Alayan SS2 Members',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _isLogin ? 'Login to continue chatting' : 'Register a new account',
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              if (!_isLogin) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Color(0xFF1F2C34),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                  fillColor: Color(0xFF1F2C34),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Color(0xFF1F2C34),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00A884),
                  ),
                  onPressed: _submit,
                  child: Text(_isLogin ? 'Login' : 'Register'),
                ),
              ),
              TextButton(
                onPressed: () => setState(() => _isLogin = !_isLogin),
                child: Text(
                  _isLogin
                      ? "Don't have an account? Register"
                      : "Already have an account? Login",
                  style: const TextStyle(color: Color(0xFF00A884)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// HOME SCREEN (WhatsApp Style Tabs)
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1, // Start on Chats
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Alayan SS2'),
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.group_add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GroupVideoCallScreen()),
                );
              },
            ),
            PopupMenuButton<String>(
              onItemTap: (val) {},
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'settings', child: Text('Settings')),
                PopupMenuItem(
                  value: 'logout',
                  child: const Text('Logout'),
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const AuthScreen()),
                  ),
                ),
              ],
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Color(0xFF00A884),
            labelColor: Color(0xFF00A884),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.camera_alt)),
              Tab(text: 'CHATS'),
              Tab(text: 'CALLS'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Center(child: Text('Camera View', style: TextStyle(color: Colors.white))),
            ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                final isGroup = index == 0;
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF005C4B),
                    child: Icon(isGroup ? Icons.group : Icons.person, color: Colors.white),
                  ),
                  title: Text(
                    isGroup ? 'Alayan SS2 Main Group' : 'Member Friend $index',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    isGroup ? 'Alice: Meeting at 8 PM...' : 'Hey, check out this media!',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: const Text('12:45 PM', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          chatName: isGroup ? 'Alayan SS2 Main Group' : 'Member Friend $index',
                          isGroup: isGroup,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFF005C4B),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text('Friend $index'),
                  subtitle: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.call_received, color: Color(0xFF00A884), size: 16),
                      SizedBox(width: 4),
                      Text('Today, 10:14 AM', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.videocam, color: Color(0xFF00A884)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const DirectVideoCallScreen(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF00A884),
          child: const Icon(Icons.message, color: Colors.white),
          onPressed: () {},
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CHAT SCREEN (WhatsApp Style Messaging & Media)
// -----------------------------------------------------------------------------
class ChatScreen extends StatefulWidget {
  final String chatName;
  final bool isGroup;

  const ChatScreen({super.key, required this.chatName, required this.isGroup});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [
    ChatMessage(text: 'Hello members!', isMe: false, time: '10:00 AM', type: MessageType.text),
    ChatMessage(text: 'Welcome to Alayan SS2!', isMe: true, time: '10:01 AM', type: MessageType.text),
  ];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage(MessageType type, {String content = ''}) {
    setState(() {
      _messages.add(
        ChatMessage(
          text: content.isEmpty ? _controller.text : content,
          isMe: true,
          time: 'Now',
          type: type,
        ),
      );
    });
    _controller.clear();
  }

  void _showAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F2C34),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 180,
          child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildAttachOption(Icons.image, Colors.purple, 'Image', () {
                Navigator.pop(context);
                _sendMessage(MessageType.image, content: '📷 [Image Sent]');
              }),
              _buildAttachOption(Icons.audiotrack, Colors.orange, 'Music', () {
                Navigator.pop(context);
                _sendMessage(MessageType.music, content: '🎵 [Audio File]');
              }),
              _buildAttachOption(Icons.mic, Colors.red, 'Voice Note', () {
                Navigator.pop(context);
                _sendMessage(MessageType.voice, content: '🎤 [Voice Message 0:14]');
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAttachOption(IconData icon, Color color, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Color(0xFF005C4B),
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.chatName,
                style: const TextStyle(fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              if (widget.isGroup) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GroupVideoCallScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const DirectVideoCallScreen()),
                );
              }
            },
          ),
          IconButton(icon: const Icon(Icons.call), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0B141A),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return Align(
                    alignment: msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: msg.isMe ? const Color(0xFF005C4B) : const Color(0xFF202C33),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(msg.text, style: const TextStyle(fontSize: 15)),
                          const SizedBox(height: 4),
                          Text(
                            msg.time,
                            style: const TextStyle(fontSize: 10, color: Colors.white60),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              color: const Color(0xFF1F2C34),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        filled: true,
                        fillColor: const Color(0xFF2A3942),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.emoji_emotions, color: Colors.grey),
                          onPressed: () {},
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.attach_file, color: Colors.grey),
                              onPressed: _showAttachmentSheet,
                            ),
                            IconButton(
                              icon: const Icon(Icons.camera_alt, color: Colors.grey),
                              onPressed: () => _sendMessage(MessageType.image, content: '📷 [Photo]'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFF00A884),
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_controller.text.isNotEmpty) {
                          _sendMessage(MessageType.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum MessageType { text, image, music, voice }

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;
  final MessageType type;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
    required this.type,
  });
}

// -----------------------------------------------------------------------------
// DIRECT VIDEO CALL SCREEN (1-to-1)
// -----------------------------------------------------------------------------
class DirectVideoCallScreen extends StatelessWidget {
  const DirectVideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote User Fullscreen Video Placeholder
          Positioned.fill(
            child: Container(
              color: const Color(0xFF222d34),
              child: const Center(
                child: Icon(Icons.person, size: 120, color: Colors.white24),
              ),
            ),
          ),
          // Local User Thumbnail
          Positioned(
            top: 48,
            right: 16,
            child: Container(
              width: 100,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 1),
              ),
              child: const Center(
                child: Text('You', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          // Controls
          Positioned(
            bottom: 32,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'mic',
                  backgroundColor: Colors.grey[800],
                  onPressed: () {},
                  child: const Icon(Icons.mic, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'end_call',
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
                FloatingActionButton(
                  heroTag: 'switch_cam',
                  backgroundColor: Colors.grey[800],
                  onPressed: () {},
                  child: const Icon(Icons.switch_camera, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// GROUP VIDEO CALL SCREEN (Multiple Friends)
// -----------------------------------------------------------------------------
class GroupVideoCallScreen extends StatelessWidget {
  const GroupVideoCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Alayan SS2 Group Video Call'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              children: List.generate(4, (index) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2C34),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xFF005C4B),
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          index == 0 ? 'You' : 'Member $index',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            color: Colors.black54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.mic, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.videocam, color: Colors.white, size: 30),
                  onPressed: () {},
                ),
                FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}