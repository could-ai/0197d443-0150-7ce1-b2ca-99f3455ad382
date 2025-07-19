import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/login.dart';
import 'chat_screen.dart';
import 'integrations/supabase.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // å¼ºå¶åå§åå¹¶å¼å§
    await Supabase.initializez(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
      debug: true,
    );
    // å¼ºå¶ç»åºä»¥ç¡®ä¿æ¯æ¬¡é½æ¾ç¤ºç»å½çé¢
    await Supabase.instance.client.auth.signOut();
  } catch (e) {
    debugPrint('â ï¸ Initialization Error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouldAI User Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          error: Colors.redAccent,
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _prepareAuth();
  }

  Future<void> _prepareAuth() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() => _isReady = true);
    } catch (e) {
      debugPrint('ð¡ Auth setup failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.indigo)),
      );
    }
    
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        return snapshot.data?.session != null 
            ? const ChatScreen() 
            : const LoginScreen();
      },
    );
  }
}