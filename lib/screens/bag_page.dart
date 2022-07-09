import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubtitleAppBar(text: "Sacola"),
            Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              child: Card(
                elevation: 10,
                shadowColor: Color.fromRGBO(150, 146, 146, 1),
                color: Color.fromRGBO(251, 235, 196, 1),
                child: Container(
                  height: bag.viewMore
                      ? sizeDevide.height * 0.2 + (bag.items.length * 76)
                      : sizeDevide.height * 0.2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 17),
                        Bag.Item(text: "Produtos", total: 572.88),
                        SizedBox(height: 13),
                        Bag.Item(text: "Descontos", total: 91.34),
                        SizedBox(height: 13),
                        DasheLine(),
                        if (bag.viewMore)
                          Expanded(
                            child: Container(
                              child: ListView.builder(
                                // itemCount: bag.items.length,
                                itemCount: bag.items.length,
                                itemBuilder: (ctx, i) =>
                                    BagWidget(bagItem: items[i]),
                              ),
                            ),
                          ),
                        SizedBox(height: 2),
                        Text(
                          "*Descontos válidos apenas para Pagamentos via PIX.",
                          style: TextStyle(
                            color: Color.fromRGBO(55, 55, 55, 1),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Bag.Total(text: "TOTAL", total: 481.54),
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
                                  Icon(
                                    Icons.expand_circle_down_outlined,
                                    size: 30,
                                    color: Color.fromRGBO(55, 55, 55, 1),
                                  ),
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
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.primary,
        child: InkWell(
          onTap: () {},
          child: SizedBox(
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

class Bag extends StatelessWidget {
  final String text;
  final double total;
  final isTotal;

  const Bag.Item({
    required this.text,
    required this.total,
    this.isTotal = false,
  });
  const Bag.Total({
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
          "${text}:",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        SizedBox(width: 3),
        Text(
          "R\$ ${total}",
          style: TextStyle(fontSize: isTotal ? 18 : 16),
        )
      ],
    );
  }
}
