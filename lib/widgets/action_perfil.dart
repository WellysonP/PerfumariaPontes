import 'package:flutter/material.dart';

class ActionPerfil extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onPress;
  const ActionPerfil({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizeDevice = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: onPress,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: const Color.fromRGBO(254, 174, 55, 1),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        color: Color.fromRGBO(254, 174, 55, 1),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: sizeDevice.width * 0.75,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 1,
                            color: Color.fromRGBO(254, 174, 55, 1),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15)
          ],
        ),
      ),
    );
  }
}
