import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';

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
            Text(
              'Slogan',
              style: blackTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              'deskripsi',
              style: greyTextStyle.copyWith(fontSize: 17, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 100),
            // Pindahkan Container ke sini
            Container(
              width: 329,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: zelow,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
                ),
                onPressed: () {},
                child: Text('Small/Medium Enterprise', style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ),
            SizedBox(height: 12,),
            Container(
              width: 329,
              height: 44,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  side: BorderSide(color: zelow, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))
                ),
                onPressed: () {},
                child: Text('Customer', style: greenTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
