import 'dart:async';
import 'package:flutter/material.dart';
import 'package:team_fourteen/ui/auth/constans.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  final int _otpLength = 5;
  List<TextEditingController> _otpControllers = List.generate(5, (index) => TextEditingController());

  int _timerSeconds = 30;
  late Timer _timer;
  bool _canResendCode = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timerSeconds = 30;
    _canResendCode = false;
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

  void _resendCode() {
    setState(() {
      _startTimer();
    });
    // Tambahkan logika pengiriman ulang kode ke email di sini
    print('Resending Code...');
  }

  void _verifyCode() {
    String otpCode = _otpControllers.map((controller) => controller.text).join();
    if (otpCode != "12345") { 
      setState(() {
        _isError = true; 
      });
    } else {
      setState(() {
        _isError = false;
      });
      print('OTP Verified: $otpCode');
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
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w900),
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
              style: blackTextStyle.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 7),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: blackTextStyle.copyWith(fontSize: 14),
                children: [
                  const TextSpan(text: 'Enter the code from the '),
                  TextSpan(
                    text: 'Email',
                    style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Text(
              'we sent you',
              style: TextStyle(fontSize: 14),
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
                    border: Border.all(color: _isError ? verif : grey, width: 1
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    style: codeTextStyle.copyWith(fontSize: 32, fontWeight: FontWeight.w600),
                    decoration: const InputDecoration(
                      counterText: '',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < _otpLength - 1) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 24,),
             if (_isError) 
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Wrong code, please try again',
                  style: verifTextStyle.copyWith( fontSize: 16, fontWeight: FontWeight.normal),
                ),
              ),
            const SizedBox(height: 249),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: _canResendCode ? _resendCode : null,
                  child: Text(
                    'Send Code Again',
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: _canResendCode ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
                Text(
                  _canResendCode ? '' : '00:${_timerSeconds.toString().padLeft(2, '0')}',
                  style: blackTextStyle.copyWith(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _verifyCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: zelow,
                minimumSize: const Size(323, 44),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24),)
              ),
              child: Text(
                'Submit',
                style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
