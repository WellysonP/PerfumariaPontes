import 'package:flutter/material.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';

import '../widgets/buttom_custom.dart';

class ProductregistrationPage extends StatelessWidget {
  const ProductregistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        icon: Icons.arrow_forward,
        onTap: () {},
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
          steps: getSteps(context, product),
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
                  ButtomCustom(
                    product: product,
                    text: product.currentStep == 2 ? "Finalizar" : "Próximo",
                    height: 50,
                    width: product.currentStep == 0 ? 300 : 150,
                    onTap: () {
                      product.currentContinue(context);
                    },
                  ),
                  if (product.currentStep != 0)
                    ButtomCustom(
                      product: product,
                      text: "Anterior",
                      height: 50,
                      width: 150,
                      onTap: () {
                        product.currentCancel();
                      },
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Step> getSteps(BuildContext context, ProductProvider product) => [
        Step(
          isActive: product.currentStep >= 0,
          title: Text(
            "Produto",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          content: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 75,
                child: InkWell(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Image.asset(
                          "assets/images/Group_22.png",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Image.asset("assets/images/Group79.png"),
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
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Nome do Produto",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                    labelText: "Fabricante",
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        Step(
          isActive: product.currentStep >= 1,
          title: Text(
            "Produto",
            style: TextStyle(
              color: product.currentStep >= 1
                  ? Theme.of(context).colorScheme.primary
                  : const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          content: Container(),
        ),
        Step(
          isActive: product.currentStep >= 2,
          title: Text(
            "Produto",
            style: TextStyle(
              color: product.currentStep >= 2
                  ? Theme.of(context).colorScheme.primary
                  : const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
          content: Container(),
        ),
      ];
}
