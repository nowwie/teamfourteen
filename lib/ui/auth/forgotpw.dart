import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/auth/login_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( // Tambahin ini supaya bisa di-scroll
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Semua teks rata kiri
            children: [
              const SizedBox(height: 28),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15), // Jarak agar teks di bawah tombol back
              Text(
                'Forgot password?',
                style: blackTextStyle.copyWith(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 300, // Biar gak terlalu panjang
                child: Text(
                  'Don’t worry! It happens.\nPlease enter the email associated with your account.',
                  style: greyTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
              const SizedBox(height: 73),
              Text(
                'Email address',
                style: codeTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: box,
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email address',
                    hintStyle: abuInter.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(height: 297),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: zelow,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  ),
                  onPressed: () {
                    // Logika pengiriman kode
                  },
                  child: Text(
                    'Send code',
                    style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Remember password?',
                    style: greyTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginForm()),
                      );
                    },
                    child: Text(
                      'Log in',
                      style: greenTextStyle.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
