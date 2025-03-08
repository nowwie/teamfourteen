import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login_form.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String _selectedRole = 'User'; // Default role is User
  TextEditingController _npwpController = TextEditingController(); // Controller for NPWP

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
            _buildTextField('Email', 'Email'),
            SizedBox(height: 12),
            _buildTextField('Full Name', 'Full Name'),
            SizedBox(height: 12),
            _buildTextField('Username', 'Username'),
            SizedBox(height: 12),
            _buildTextField('Password', 'Password', obscureText: true),
            SizedBox(height: 12),
            _buildRoleDropdown(),
            // Menampilkan container NPWP hanya jika role adalah Admin
            if (_selectedRole == 'Merchant') _buildNpwpField(),
            SizedBox(height: 134,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 153, vertical: 11),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  minimumSize: Size(328, 48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: () {
                  print('Sign in clicked');
                },
                child: Text(
                  'Sign Up',
                  style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 4,),
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

  // Fungsi untuk membangun TextField
  Widget _buildTextField(String label, String hintText, {bool obscureText = false}) {
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

  // Fungsi untuk membangun dropdown role
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

  // Fungsi untuk membangun field NPWP
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
