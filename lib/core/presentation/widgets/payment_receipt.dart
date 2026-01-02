import 'package:flutter/material.dart';

class PaymentReceipt extends StatelessWidget {
  final List<Widget> props;
  const PaymentReceipt({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/reciept-bg.png'),
          fit: BoxFit.fill,
        ),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            height: 70,
            alignment: Alignment.center,
            child: const Text(
              'P A Y M E N T   R E C E I P T',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 2,
                color: Color(0xFF555555),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: props),
          ),
        ],
      ),
    );
  }
}
