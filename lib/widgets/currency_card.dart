import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    super.key,
    required this.name,
    required this.code,
    required this.amount,
    required this.icon,
    required this.order,
    this.spacing = -20,
  });

  final String name, code, amount;
  final IconData icon;
  final double order;
  final double spacing;

  final Color _blackColor = const Color(0xFF1F2123);
  final Color whiteColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    final bool isInverted = order % 2 != 0;
    return Transform.translate(
      offset: Offset(0, order * spacing),
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: isInverted ? Colors.white : const Color(0xFF1F2123),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: isInverted ? _blackColor : whiteColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Text(
                          amount,
                          style: TextStyle(
                            color: isInverted ? _blackColor : whiteColor,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          code,
                          style: TextStyle(
                            color: isInverted ? _blackColor : whiteColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    )
                  ]),
              Transform.scale(
                scale: 2.2,
                child: Transform.translate(
                  offset: const Offset(-5, 20),
                  child: Icon(
                    icon,
                    color: isInverted ? _blackColor : whiteColor,
                    size: 88,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
