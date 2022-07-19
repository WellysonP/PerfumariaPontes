import 'package:flutter/material.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';
import '../widgets/buttom_custom.dart';

class ProductregistrationPage extends StatelessWidget {
  const ProductregistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    final company = Provider.of<CompanyProvider>(context);

    void _submitForm() {
      if (product.currentStep == 0) {
        product.submitForm(product.formKeyStep1, context);
      } else if (product.currentStep == 1) {
        product.submitForm(product.formKeyStep2, context);
      } else if (product.currentStep == 2) {
        product.submitForm(product.formKeyStep3, context);
      }
    }

    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        isArrowBackFunction: () {
          if (product.currentStep == 0) {
            Navigator.of(context).pop();
            product.isEmphasis = false;
            product.image = null;
            product.imageList = [];
            product.nameController.text = "";
          } else {
            product.currentCancel();
          }
        },
        icon: Icons.arrow_forward,
        onTap: () {
          _submitForm();
        },
        text: "Cadastrar Produto",
      ),
      body: Theme(
        data: ThemeData(
          canvasColor: const Color.fromRGBO(33, 33, 33, 1),
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: const Color.fromRGBO(242, 134, 12, 1),
              ),
        ),
        child: Stepper(
          elevation: 0,
          type: StepperType.horizontal,
          steps: getSteps(context, product, company),
          currentStep: product.currentStep,
          onStepContinue: () {
            product.currentContinue(context);
          },
          onStepCancel: product.currentCancel,
          controlsBuilder: (context, _) {
            return Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (product.currentStep != 0)
                    ButtomCustom(
                      product: product,
                      text: "Anterior",
                      height: 50,
                      width: 150,
                      onTap: () {
                        product.currentCancel();
                      },
                    ),
                  ButtomCustom(
                    product: product,
                    text: product.currentStep == 2 ? "Finalizar" : "Próximo",
                    height: 50,
                    width: product.currentStep == 0 ? 300 : 150,
                    onTap: () {
                      _submitForm();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps(BuildContext context, ProductProvider product,
          CompanyProvider company) =>
      [
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
                        product.image == null
                            ? Image.asset("assets/images/Group79.png")
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
                  controller: product.nameController,
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                          EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      labelText: "Fabricante",
                      fillColor: Colors.white,
                      filled: true,
                    ),
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
        ),
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
                product.image == null
                    ? Image.asset("assets/images/Group79.png")
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
                    product.nameController.text,
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
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
        ),
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
                product.image == null
                    ? Image.asset("assets/images/Group79.png")
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
                    product.nameController.text,
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
        ),
      ];
}
