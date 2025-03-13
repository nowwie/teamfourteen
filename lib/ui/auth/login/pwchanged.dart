import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login/login_form.dart';

class PasswordChanged extends StatelessWidget {
  const PasswordChanged({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: zelow, 
              ),
              child: Icon(
                Icons.check,
                size: 50,
                color: white, 
              ),
            ),
            SizedBox(height: 12,),
            Text(
              'Password Changed',
              style: blackTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold 
              ),
            ),
            SizedBox(height: 12,),
            Text('Your password has been changed \nsuccesfully',
            style: greyTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),),
            SizedBox(height: 223,),
            Container(
              width: double.infinity,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                ),
                onPressed: (){
                  Navigator.push(context,
                   MaterialPageRoute(builder: (context)=> const LoginForm()));
                },
                child: Text('Back to login',
                style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
