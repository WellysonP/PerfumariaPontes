import 'package:flutter/material.dart';
import 'package:perfumaria/utils/app_routes.dart';

class AppBarCustom extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isFilter;
  final bool isArrowBack;

  const AppBarCustom.isFilter({
    required this.icon,
    required this.text,
    this.isFilter = true,
    this.isArrowBack = false,
  });

  const AppBarCustom.isArrowBack({
    required this.icon,
    required this.text,
    this.isFilter = false,
    this.isArrowBack = true,
  });

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
                onPressed: () {
                  if (isArrowBack) {
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(icon, color: Colors.white),
              ),
              Expanded(
                child: SizedBox(
                  height: 35,
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
          padding: const EdgeInsets.only(top: 20, left: 17),
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
