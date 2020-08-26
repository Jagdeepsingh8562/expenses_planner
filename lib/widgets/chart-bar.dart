import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercent;

  ChartBar(this.label, this.spendingAmount, this.spendingPercent);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder:(ctx,constraints){
          return Column(
        children: [
          Container(
              height: constraints.maxHeight*.125,
              child: FittedBox(
                  child: Text('\₹${spendingAmount.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight*.045),
          Container(
            height: constraints.maxHeight*.6,
            width: 20,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercent,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight*.045),
          Container(height: constraints.maxHeight*.125,child: FittedBox(child: Text(label))),
        ],
      );
  }
    );
}
}