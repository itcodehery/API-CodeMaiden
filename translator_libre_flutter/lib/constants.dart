import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthenType {
  signIn,
  signUp,
}

final supabase = Supabase.instance.client;
