import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/forgotpw.dart';
import 'package:team_fourteen/ui/auth/register_form.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Zelow
            Image.asset('assets/images/zelowbottom.png', width: 132, height: 162.26),
            SizedBox(height: 42),
            
            // Input Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email', style: blackTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Container(
                  width: 328,
                  height: 44,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: box,
                  ),
                  child: TextField(
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: box,
                  ),
                  child: TextField(
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
                    Navigator.push(context,
                     MaterialPageRoute(builder: (context)=> const ForgotPassword()));
                  },
                  child: Text('Forgot password?',
                      style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 116),
            
            // Login Button
            SizedBox(
            width: MediaQuery.of(context).size.width * 0.85, // 85% dari lebar layar
            child: ElevatedButton(
            style: ElevatedButton.styleFrom(
            backgroundColor: zelow,
            minimumSize: const Size(double.infinity, 48), // Lebar penuh dalam SizedBox
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
             ),
            onPressed: () {
            print('Login clicked');
            },
            child: Text(
            'Login',
            style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
               ),
             ),
            ),

            SizedBox(height: 9),
            
            // Divider and Login with Text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 65,
                  child: Expanded(
                    child: Divider(
                      color: grey,
                      thickness: 1,
                      endIndent: 8,
                    ),
                  ),
                ),
                Text(
                  'or login with',
                  style: blackTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Container(
                  width: 65,
                  child: Expanded(
                    child: Divider(
                      color: grey,
                      thickness: 1,
                      indent: 8,
                    ),
                  ),
                ),
              ],
            ),
            // Login with social media (Google and Facebook) buttons
            SizedBox(height: 9),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Google Login Button
                GestureDetector(
                  onTap: () {
                    print("Login with fb");
                    // Implement login with Google here
                  },
                  child: Image.asset(
                    'assets/images/facebook.png',
                    width: 43,
                    height: 41,
                  ),
                ),
                SizedBox(width: 52),
                
                // Facebook Login Button
                GestureDetector(
                  onTap: () {
                    print("Login with google");
                    // Implement login with Facebook here
                  },
                  child: Image.asset(
                    'assets/images/google.png',
                    width: 43,
                    height: 41,
                  ),
                ),
              ],
            ),
            SizedBox(height: 38,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('You don\'t have an account?',
                style: greyTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),),
                
                TextButton(
                  onPressed: () {
                    print('sign up clicked');
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterForm(),));
                  },
                  child: Text('Sign Up',
                  style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
