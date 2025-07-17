import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client;

  SupabaseService()
      : _client = SupabaseClient(
          SupabaseConfig.supabaseUrl,
          SupabaseConfig.supabaseAnonKey,
        );

  Future<List<Map<String, dynamic>>> getContacts() async {
    final response = await _client
        .from('contacts')
        .select()
        .order('created_at', ascending: true)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }

    return response.data as List<Map<String, dynamic>>;
  }

  Future<void> addContact({
    required String name,
    required String phoneNumber,
    String? email,
    String? gender,
  }) async {
    final response = await _client.from('contacts').insert({
      'name': name,
      'phone_number': phoneNumber,
      'email': email,
      'gender': gender,
    }).execute();

    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> deleteContact(int id) async {
    final response = await _client
        .from('contacts')
        .delete()
        .eq('id', id)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> updateContact(int id, Map<String, dynamic> values) async {
    final response = await _client
        .from('contacts')
        .update(values)
        .eq('id', id)
        .execute();

    if (response.error != null) {
      throw response.error!;
    }
  }
}
