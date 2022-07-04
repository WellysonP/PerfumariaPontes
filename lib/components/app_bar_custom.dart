import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppBarCustom extends StatelessWidget {
  final IconData icon;
  final String text;
  const AppBarCustom({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 17),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(icon, color: Colors.white),
              ),
              Expanded(
                child: SizedBox(
                  height: 30,
                  child: TextField(
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintStyle:
                          TextStyle(color: Color.fromRGBO(150, 146, 146, 1)),
                      hintText: "Procurar no aplicativo",
                      fillColor: Colors.white,
                      filled: true,
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color.fromRGBO(150, 146, 146, 1),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.local_mall_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 17),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
