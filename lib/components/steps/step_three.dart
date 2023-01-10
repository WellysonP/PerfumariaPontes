import 'package:flutter/material.dart';
import 'package:perfumaria/provider/product_provider.dart';
import '../../provider/company_provider.dart';

Step stepThree(BuildContext context, ProductProvider product,
        CompanyProvider company) =>
    Step(
      isActive: product.currentStep >= 2,
      title: Text(
        "Descrição",
        style: TextStyle(
          color: product.currentStep >= 2
              ? Theme.of(context).colorScheme.primary
              : const Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      content: Form(
        key: product.formKeyStep3,
        child: Column(
          children: [
            product.formData["imageUrl"] == null
                ? product.image == null
                    ? Image.asset("assets/images/Group79.png")
                    : ClipOval(
                        child: Image.file(
                          product.image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                : product.image == null
                    ? ClipOval(
                        child: Image.network(
                          product.formData["imageUrl"].toString(),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.file(
                          product.image!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
            const SizedBox(height: 17),
            SizedBox(
              width: double.infinity,
              child: Text(
                product.formData["name"].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Adicionar aos Destaques",
                      style: TextStyle(
                          fontSize: 15,
                          color: Color.fromRGBO(102, 102, 102, 1)),
                    ),
                    IconButton(
                      onPressed: () {
                        product.toogleEmphasis();
                      },
                      icon: Icon(
                        product.isEmphasis
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 150,
              child: TextFormField(
                initialValue: product.formData["description"]?.toString() ?? "",
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                maxLines: 5,
                minLines: 5,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Descrição do produto",
                  fillColor: Colors.white,
                  filled: true,
                  alignLabelWithHint: true,
                ),
                onSaved: (description) =>
                    product.formData["description"] = description ?? "",
                validator: (_description) {
                  final description = _description ?? "";
                  if (description.trim().isEmpty) {
                    return "Campo Obrigatório";
                  }
                  if (description.trim().length < 10) {
                    return "Necessário descrição com no mínimo 10 letras";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
