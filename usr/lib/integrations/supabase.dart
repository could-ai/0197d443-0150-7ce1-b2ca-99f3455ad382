// Supabase Configuration
class SupabaseConfig {
  static const String supabaseUrl = 'https://hottegpaveldxtburgal.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhvdHRlZ3BhdmVsZHh0YnVyZ2FsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTI2NjY4NjQsImV4cCI6MjA2ODI0Mjg2NH0.19y0C925x_fXU8Nz5HfsZz-B7giIioa9Bmc4JutuVvU';

  /// Initialize Supabase client with custom configurations
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
      authOptions: const FlutterAuthOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      debug: true,
    );
  }
}