import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login/login_form.dart';
import 'package:team_fourteen/ui/auth/verification.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String _selectedRole = 'User'; // Default role is User
  TextEditingController _emailController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _npwpController = TextEditingController(); // Controller for NPWP
  bool _isLoading = false; 
  
  void _signUp() async {
    setState(() {
      _isLoading = true; // Aktifkan loading saat proses sign-up berjalan
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Simpan data tambahan ke Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'full_name': _fullNameController.text.trim(),
        'username': _usernameController.text.trim(),
        'email': _emailController.text.trim(),
        'role': _selectedRole,
        if (_selectedRole == 'Merchant') 'npwp': _npwpController.text.trim(), // Tambahkan NPWP jika role Merchant
        'created_at': Timestamp.now(),
      });

      // Navigasi ke halaman verifikasi setelah sign-up berhasil
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Verification()),
      );
    } on FirebaseAuthException catch (e) {
      print("Sign Up Error: ${e.message}");
    } finally {
      setState(() {
        _isLoading = false; // Matikan loading setelah selesai
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
                'Sign Up',
              style: blackTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w900),
            ),
            SizedBox(height: 27),
            _buildTextField('Email', 'Email', controller: _emailController),
            SizedBox(height: 12),
            _buildTextField('Full Name', 'Full Name', controller: _fullNameController),
            SizedBox(height: 12),
            _buildTextField('Username', 'Username', controller: _usernameController),
            SizedBox(height: 12),
            _buildTextField('Password', 'Password', obscureText: true, controller: _passwordController),
            SizedBox(height: 12),
            _buildRoleDropdown(),
            if (_selectedRole == 'Merchant') _buildNpwpField(),
            SizedBox(height: 134),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85, // 85% dari lebar layar
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  minimumSize: const Size(double.infinity, 48), // Lebar penuh dalam SizedBox
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: _isLoading ? null : _signUp, // Nonaktifkan tombol saat loading
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white) // Tampilkan loading jika sedang memproses
                    : Text(
                        'Sign Up',
                        style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),),
                
                TextButton(
                  onPressed: () {
                    Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> const LoginForm()),
                  );
                  },
                  child: Text('Log in',
                  style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ),
    );
  }

  Widget _buildTextField(String label, String hintText, {bool obscureText = false, TextEditingController? controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 328,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: box,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: greyTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRoleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Role',
          style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 328,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: box,
          ),
          child: DropdownButton<String>(
            value: _selectedRole,
            isExpanded: true,
            underline: SizedBox(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedRole = newValue!;
              });
            },
            items: <String>['User', 'Merchant']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    value,
                    style: greyTextStyle.copyWith(fontSize: 14),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildNpwpField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NPWP',
          style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          width: 328,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: box,
          ),
          child: TextField(
            controller: _npwpController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'NPWP',
              hintStyle: greyTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ],
    );
  }
}
