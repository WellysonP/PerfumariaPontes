// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:perfumaria/models/bag_model.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/utils/app_routes.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:provider/provider.dart';
import '../widgets/bag_widget.dart';
import '../widgets/dashe_line_widget.dart';

class BagPage extends StatelessWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<BagProvider>(context);
    final sizeDevice = MediaQuery.of(context).size;
    final List<BagModel> items = bag.items.values.toList();
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(
        text: "Sacola",
        icon: Icons.account_balance_wallet_outlined,
        onTap: () {},
        isArrowBackFunction: () {
          Navigator.of(context).pop();
          bag.viewMore = false;
        },
      ),
      body: ListView(
        children: [
          const SizedBox(height: 17),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Card(
                elevation: 10,
                shadowColor: const Color.fromRGBO(150, 146, 146, 1),
                color: const Color.fromRGBO(251, 235, 196, 1),
                child: SizedBox(
                  height: bag.viewMore
                      ? sizeDevice.height * 0.215 + (bag.items.length * 85)
                      : sizeDevice.height * 0.215,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Bag.item(
                                  text: "Produtos",
                                  total: bag.totalOldPriceAmount,
                                ),
                                const SizedBox(height: 13),
                                Bag.item(
                                    text: "Descontos",
                                    total: bag.totalDisccount),
                              ],
                            ),
                            Column(
                              children: [
                                PayType.pix(
                                  bag: bag,
                                  imageUrl: "assets/images/pix.png",
                                  sizeDevice: sizeDevice,
                                ),
                                PayType.card(
                                  bag: bag,
                                  imageUrl: "assets/images/cartao.png",
                                  sizeDevice: sizeDevice,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 13),
                        const DasheLine(),
                        if (bag.viewMore)
                          SizedBox(
                            height: (bag.items.length * 85),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: bag.items.length,
                              itemBuilder: (ctx, i) =>
                                  BagWidget(bagItem: items[i]),
                            ),
                          ),
                        const SizedBox(height: 2),
                        const Text(
                          "*Descontos válidos apenas para Pagamentos via PIX.",
                          style: TextStyle(
                            color: Color.fromRGBO(55, 55, 55, 1),
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Bag.total(
                              text: "TOTAL",
                              total: bag.isDiscount
                                  ? bag.totalNewPriceAmount
                                  : bag.totalOldPriceAmount,
                            ),
                            IconButton(
                              onPressed: () => bag.listBag(),
                              icon: Stack(
                                children: [
                                  Icon(
                                    Icons.circle,
                                    size: 30,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                  if (bag.viewMore)
                                    const RotatedBox(
                                      quarterTurns: 2,
                                      child: ExpandIcon(),
                                    ),
                                  if (!bag.viewMore) const ExpandIcon(),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {
            print(bag.items.values);
          },
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Prosseguir para Pagamento",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 5),
                Icon(Icons.account_balance_wallet_outlined, size: 35)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PayType extends StatelessWidget {
  final String imageUrl;
  final BagProvider bag;
  final Size sizeDevice;
  final bool isPix;

  const PayType.pix({
    required this.bag,
    required this.imageUrl,
    required this.sizeDevice,
    this.isPix = true,
  });
  const PayType.card({
    required this.bag,
    required this.imageUrl,
    required this.sizeDevice,
    this.isPix = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).colorScheme.primary,
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        if (isPix) {
          bag.isPix();
        } else {
          bag.isCard();
        }
      },
      child: SizedBox(
        width: sizeDevice.width * 0.25,
        height: sizeDevice.height * 0.045,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              bag.isDiscount && isPix || !bag.isDiscount && !isPix
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              size: 20,
            ),
            const SizedBox(width: 15),
            Image.asset(
              imageUrl,
              width: 30,
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class ExpandIcon extends StatelessWidget {
  const ExpandIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.expand_circle_down_outlined,
      size: 30,
      color: Color.fromRGBO(55, 55, 55, 1),
    );
  }
}

class Bag extends StatelessWidget {
  final String text;
  final double total;
  // ignore: prefer_typing_uninitialized_variables
  final isTotal;

  const Bag.item({
    required this.text,
    required this.total,
    this.isTotal = false,
  });
  const Bag.total({
    required this.text,
    required this.total,
    this.isTotal = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$text:",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color.fromRGBO(55, 55, 55, 1),
          ),
        ),
        const SizedBox(width: 3),
        Text(
          "R\$ ${total.toStringAsFixed(2)}",
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            color: const Color.fromRGBO(55, 55, 55, 1),
          ),
        )
      ],
    );
  }
}
