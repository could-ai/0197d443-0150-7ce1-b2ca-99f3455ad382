import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'auth/login.dart';
import 'chat_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Reset auth state for testing
  try {
    await SupabaseConfig.initialize();
    await Supabase.instance.client.auth.signOut();
  } catch (e) {
    debugPrint('Initialization error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CouldAI User App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
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
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _verifyAuth();
  }

  Future<void> _verifyAuth() async {
    try {
      // Force fresh auth state
      final session = Supabase.instance.client.auth.currentSession;
      
      // If you want to guarantee login screen shows:
      // await Supabase.instance.client.auth.signOut();
      
      setState(() => _initialized = true);
    } catch (e) {
      debugPrint('Auth verification error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        // FOR TESTING - Force login screen
        // return const LoginScreen();
        
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return snapshot.data?.session != null
            ? const ChatScreen()
            : const LoginScreen();
      },
    );
  }
}