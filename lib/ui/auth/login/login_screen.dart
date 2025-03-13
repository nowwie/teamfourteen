import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login/login_form.dart';
import 'package:team_fourteen/ui/auth/register_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key}); // Tambahkan super.key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome!',
              style: blackTextStyle.copyWith(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            Text(
              'You are logging in as,',
              style: greyTextStyle.copyWith(fontSize: 17, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 100),
           Image.asset('assets/images/zelowbottom.png', width: 132, height: 162.26),
            SizedBox(height: 100),
            // Pindahkan Container ke sini
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
                ),
                onPressed: () {
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context) => const LoginForm(),));
                },
                child: Text('Log In', style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 12,),
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  side: BorderSide(color: zelow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
                ),
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(builder: (context)=> const RegisterForm()),
                  );
                },
                child: Text('Sign Up', style: greenTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
