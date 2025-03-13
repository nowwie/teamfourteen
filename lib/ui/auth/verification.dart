import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';
import 'package:team_fourteen/ui/home/humey.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final int _otpLength = 5;
  final List<TextEditingController> _otpControllers =
      List.generate(5, (index) => TextEditingController());

  int _timerSeconds = 30;
  late Timer _timer;
  bool _canResendCode = false;
  bool _isError = false;
  bool _isVerifying = false;
  double _bubbleSize = 50;
  String _email = "Loading...";
  String _generatedOTP = "";

  @override
  void initState() {
    super.initState();
    _getUserEmail();
    _generateAndSendOTP();
    _startTimer();
  }

  /// ✅ Mengambil email pengguna dari Firebase Authentication
  void _getUserEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _email = _maskEmail(user.email ?? "unknown@example.com");
      });
    }
  }

  /// ✅ Membuat kode OTP acak 5 digit
  String _generateOTP() {
    Random random = Random();
    return List.generate(5, (_) => random.nextInt(10).toString()).join();
  }

  /// ✅ Mengaburkan sebagian email untuk tampilan
  String _maskEmail(String email) {
    List<String> parts = email.split('@');
    if (parts.length == 2) {
      String maskedPart =
          parts[0].replaceRange(2, parts[0].length, '*' * (parts[0].length - 2));
      return "$maskedPart@${parts[1]}";
    }
    return email;
  }

  /// ✅ Mengirim kode OTP ke Firestore & Firebase Auth
  Future<void> _generateAndSendOTP() async {
    _generatedOTP = _generateOTP();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Simpan OTP ke Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set({"otp": _generatedOTP}, SetOptions(merge: true));

      print("OTP $_generatedOTP dikirim ke ${user.email}");
    }
  }

  /// ✅ Resend OTP
  void _resendCode() {
    _generateAndSendOTP();
    _startTimer();
    print('Mengirim ulang kode...');
  }

  /// ✅ Timer untuk pengiriman ulang kode
  void _startTimer() {
    setState(() {
      _timerSeconds = 30;
      _canResendCode = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() {
          _timerSeconds--;
        });
      } else {
        setState(() {
          _canResendCode = true;
          _timer.cancel();
        });
      }
    });
  }

  /// ✅ Verifikasi OTP
  Future<void> _verifyCode() async {
    String otpCode =
        _otpControllers.map((controller) => controller.text).join();
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();

      if (snapshot.exists && snapshot.get("otp") == otpCode) {
        setState(() {
          _isError = false;
          _isVerifying = true;
          _bubbleSize = 150;
        });
        Future.delayed(const Duration(seconds: 2), () {
          //navigator home),
          
        });
      } else {
        setState(() {
          _isError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style:
              blackTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
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
            Text(
              'Verification',
              style:
                  blackTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: blackTextStyle.copyWith(fontSize: 14),
                children: [
                  const TextSpan(
                      text: 'We’ve sent an Email with an activation code \nto '),
                  TextSpan(
                    text: _email,
                    style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_otpLength, (index) {
                return Container(
                  width: 50,
                  height: 60,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: _isError ? verif : grey, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    cursorColor: zelow,
                    style: codeTextStyle.copyWith(
                        fontSize: 32, fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                  ),
                );
              }),
            ),
            if (_isError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Wrong code, please try again',
                  style: verifTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            const SizedBox(height: 249),
            if (!_canResendCode)
              Text(
                '00:${_timerSeconds.toString().padLeft(2, '0')}',
                style: blackTextStyle.copyWith(fontSize: 14),
              ),
            if (_canResendCode)
              GestureDetector(
                onTap: _resendCode,
                child: Text('Resend', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            const SizedBox(height: 24),
            if (_isVerifying)
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: _bubbleSize,
                height: _bubbleSize,
                decoration: BoxDecoration(color: zelow, shape: BoxShape.circle),
              ),
            if (!_isVerifying)
              ElevatedButton(
                onPressed: _verifyCode,
                child: Text('Submit', style: whiteTextStyle),
              ),
          ],
        ),
      ),
    );
  }
}
