import 'package:flutter/material.dart';
import 'package:perfumaria/components/steps/step_one.dart';
import 'package:perfumaria/components/steps/step_three.dart';
import 'package:perfumaria/components/steps/step_two.dart';
import 'package:perfumaria/models/product_model.dart';
import 'package:perfumaria/provider/company_provider.dart';
import 'package:perfumaria/provider/product_provider.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';
import '../widgets/buttom_custom.dart';

class ProductregistrationPage extends StatefulWidget {
  const ProductregistrationPage({Key? key}) : super(key: key);

  @override
  State<ProductregistrationPage> createState() =>
      _ProductregistrationPageState();
}

class _ProductregistrationPageState extends State<ProductregistrationPage> {
  @override
  void didChangeDependencies() {
    final product = Provider.of<ProductProvider>(context);
    super.didChangeDependencies();
    if (product.formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final loadProduct = arg as ProductModel;
        product.formData["id"] = loadProduct.id;
        product.formData["name"] = loadProduct.name;
        product.formData["company"] = loadProduct.company;
        product.formData["quantity"] = loadProduct.quantity;
        product.formData["cost"] = loadProduct.cost;
        product.formData["oldPrice"] = loadProduct.oldPrice;
        product.formData["newPrice"] = loadProduct.newPrice;
        product.formData["imageUrl"] = loadProduct.imageUrl;
        product.formData["description"] = loadProduct.description;
        product.formData["isFavorite"] = loadProduct.isFavorite;
        product.formData["isEmphasis"] = loadProduct.isEmphasis;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final msg = ScaffoldMessenger.of(context);
    final product = Provider.of<ProductProvider>(context);
    final company = Provider.of<CompanyProvider>(context);

    void _submitForm() {
      if (product.image == null && product.formData.isEmpty) {
        msg.hideCurrentSnackBar();
        msg.showSnackBar(
          SnackBar(
            backgroundColor: const Color.fromRGBO(63, 58, 58, 1),
            duration: const Duration(seconds: 2),
            content: const Text("Imagem Obrigatória"),
            action: SnackBarAction(
              textColor: Theme.of(context).colorScheme.primary,
              label: "Inserir Imagem",
              onPressed: () => product.pickImage(),
            ),
          ),
        );
      }
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
        isBag: false,
        isArrowBackFunction: () {
          if (product.currentStep == 0) {
            Navigator.of(context).pop();
            product.isEmphasis = false;
            product.image = null;
            product.imageList = [];
            product.formData.clear();
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
        stepOne(context, product, company),
        stepTwo(context, product, company),
        stepThree(context, product, company),
      ];
}
