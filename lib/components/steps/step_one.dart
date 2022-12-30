import 'package:flutter/material.dart';
import '../../provider/company_provider.dart';
import '../../provider/product_provider.dart';

Step stepOne(BuildContext context, ProductProvider product,
        CompanyProvider company) =>
    Step(
      isActive: product.currentStep >= 0,
      title: Text(
        "Produto",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      content: Form(
        key: product.formKeyStep1,
        child: Column(
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 75,
              child: InkWell(
                borderRadius: BorderRadius.circular(150),
                onTap: () {
                  product.pickImage();
                },
                child: Stack(
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        "assets/images/Group_22.png",
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 17),
            const SizedBox(
              width: double.infinity,
              child: Text(
                "Adicionar Imagens",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              initialValue: product.formData["name"]?.toString(),
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                labelStyle: const TextStyle(
                  fontSize: 15,
                ),
                labelText: "Nome do Produto",
                fillColor: Colors.white,
                filled: true,
              ),
              onSaved: (name) => product.formData["name"] = name ?? "",
              validator: (_name) {
                final name = _name ?? "";
                if (name.trim().isEmpty) {
                  return "Campo Obrigatório";
                }
                if (name.trim().length < 5) {
                  return "Nome inválido";
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.white),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  labelText: "Marca",
                  fillColor: Colors.white,
                  filled: true,
                ),
                value: product.formData.isEmpty
                    ? null
                    : product.formData["company"].toString(),
                items: company.items
                    .map(
                      (item) => DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(item.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  company.value = value;
                },
                onSaved: (company) =>
                    product.formData["company"] = company ?? "",
                validator: (_company) {
                  final company = _company ?? "";
                  if (company.isEmpty) {
                    return "Campo Obrigatório";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
