import 'package:flutter/material.dart';
import 'package:perfumaria/models/bag_model.dart';
import 'package:perfumaria/provider/bag_provider.dart';
import 'package:perfumaria/widgets/app_bar_custom.dart';
import 'package:perfumaria/widgets/subtitle_appbar.dart';
import 'package:provider/provider.dart';

import '../widgets/bag_widget.dart';
import '../widgets/dashe_line_widget.dart';

class BagPage extends StatelessWidget {
  const BagPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bag = Provider.of<BagProvider>(context);
    final sizeDevide = MediaQuery.of(context).size;
    final List<BagModel> items = bag.items.values.toList();
    return Scaffold(
      appBar: AppBarCustom.isArrowBack(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SubtitleAppBar(text: "Sacola"),
          Container(
            alignment: Alignment.topLeft,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Card(
                elevation: 10,
                shadowColor: const Color.fromRGBO(150, 146, 146, 1),
                color: const Color.fromRGBO(251, 235, 196, 1),
                child: Container(
                  height: bag.viewMore
                      ? sizeDevide.height * 0.2 + (bag.items.length * 76)
                      : sizeDevide.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 17),
                        Bag.item(
                          text: "Produtos",
                          total: bag.totalOldPriceAmount,
                        ),
                        const SizedBox(height: 13),
                        Bag.item(text: "Descontos", total: bag.totalDisccount),
                        const SizedBox(height: 13),
                        const DasheLine(),
                        if (bag.viewMore)
                          Expanded(
                            child: ListView.builder(
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
          onTap: () {},
          child: const SizedBox(
            height: 60,
            child: Center(
              child: Text(
                "Finalizar Pedido",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(55, 55, 55, 1),
                ),
              ),
            ),
          ),
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
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        const SizedBox(width: 3),
        Text(
          "R\$ ${total.toStringAsFixed(2)}",
          style: TextStyle(fontSize: isTotal ? 18 : 16),
        )
      ],
    );
  }
}
