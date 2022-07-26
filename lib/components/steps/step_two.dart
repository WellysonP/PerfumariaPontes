import 'package:flutter/material.dart';

import '../../provider/company_provider.dart';
import '../../provider/product_provider.dart';

Step stepTwo(BuildContext context, ProductProvider product,
        CompanyProvider company) =>
    Step(
      isActive: product.currentStep >= 1,
      title: Text(
        "Controle",
        style: TextStyle(
          color: product.currentStep >= 1
              ? Theme.of(context).colorScheme.primary
              : const Color.fromRGBO(255, 255, 255, 1),
        ),
      ),
      content: Form(
        key: product.formKeyStep2,
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
            TextFormField(
              initialValue: product.formData["quantity"]?.toString() ?? "",
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Quantidade em Estoque",
                fillColor: Colors.white,
                filled: true,
              ),
              onSaved: (quantity) =>
                  product.formData["quantity"] = int.parse(quantity ?? "0"),
              validator: (_quantity) {
                final quantity = _quantity ?? "";
                final finalQuantity = int.tryParse(quantity) ?? 0;
                if (finalQuantity == 0) {
                  return "Campo obrigatório";
                }
                if (finalQuantity < 0) {
                  return "Quantidade inválida";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.formData["cost"]?.toString() ?? "",
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Custo unitário",
                fillColor: Colors.white,
                filled: true,
              ),
              onSaved: (cost) =>
                  product.formData["cost"] = double.parse(cost ?? "0.00"),
              validator: (_cost) {
                final cost = _cost ?? "";
                final price = double.tryParse(cost) ?? 0.00;
                if (price == 0) {
                  return "Campo obrigatório";
                }
                if (price < 0) {
                  return "Preço inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.formData["oldPrice"]?.toString() ?? "",
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Valor Cartão",
                fillColor: Colors.white,
                filled: true,
              ),
              onSaved: (oldPrice) => product.formData["oldPrice"] =
                  double.parse(oldPrice ?? "0.00"),
              validator: (_oldPrice) {
                final oldPrice = _oldPrice ?? "";
                final price = double.tryParse(oldPrice) ?? 0.00;
                if (price == 0) {
                  return "Campo obrigatório";
                }
                if (price < 0) {
                  return "Preço inválido";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: product.formData["newPrice"]?.toString() ?? "",
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Valor Dinheiro",
                fillColor: Colors.white,
                filled: true,
              ),
              onSaved: (newPrice) => product.formData["newPrice"] =
                  double.parse(newPrice ?? "0.00"),
              validator: (_newPrice) {
                final newPrice = _newPrice ?? "";
                final price = double.tryParse(newPrice) ?? 0.00;
                if (price == 0) {
                  return "Campo obrigatório";
                }
                if (price < 0) {
                  return "Preço inválido";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
