import 'package:flutter/material.dart';
import 'package:perfumaria/models/company_model.dart';

class CompanyItems extends StatelessWidget {
  final CompanyModel companyItem;
  const CompanyItems({Key? key, required this.companyItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(companyItem.imageUrl),
            ),
            const SizedBox(height: 5),
            Text(
              companyItem.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
