import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login/forgotpw.dart';
import 'package:team_fourteen/ui/auth/register_form.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // 🔹 Login dengan Email & Password
  Future<void> _loginWithEmail() async {
    setState(() => _isLoading = true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      print("Login berhasil: ${userCredential.user?.email}");
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.message}");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // 🔹 Login dengan Google
  Future<void> _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      await _saveUserToFirestore(userCredential.user);
      print("Login dengan Google berhasil: ${userCredential.user?.email}");
    } catch (e) {
      print("Google Login Error: $e");
    }
  }

  // 🔹 Login dengan Facebook
  Future<void> _loginWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.tokenString);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        await _saveUserToFirestore(userCredential.user);
        print("Login dengan Facebook berhasil: ${userCredential.user?.email}");
      } else {
        print("Facebook Login Gagal: ${result.status}");
      }
    } catch (e) {
      print("Facebook Login Error: $e");
    }
  }

  // 🔹 Simpan data user ke Firestore (jika belum ada)
  Future<void> _saveUserToFirestore(User? user) async {
    if (user == null) return;

    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'full_name': user.displayName ?? '',
        'email': user.email,
        'created_at': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/zelowbottom.png', width: 132, height: 162.26),
            SizedBox(height: 42),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: 328,
                  height: 44,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: box),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'username@gmail.com',
                      hintStyle: greyTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text('Password', style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: 328,
                  height: 44,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: box),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: greyTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                  },
                  child: Text('Forgot password?', style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 116),

            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _isLoading ? null : _loginWithEmail,
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text('Login', style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 9),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 65, child: Divider(color: grey, thickness: 1, endIndent: 8)),
                Text('or login with', style: blackTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                Container(width: 65, child: Divider(color: grey, thickness: 1, indent: 8)),
              ],
            ),

            SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _loginWithFacebook,
                  child: Image.asset('assets/images/facebook.png', width: 43, height: 41),
                ),
                SizedBox(width: 52),
                GestureDetector(
                  onTap: _loginWithGoogle,
                  child: Image.asset('assets/images/google.png', width: 43, height: 41),
                ),
              ],
            ),

            SizedBox(height: 38),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("You don't have an account?", style: greyTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal)),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterForm()));
                  },
                  child: Text('Sign Up', style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
