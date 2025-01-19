import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_widget/card_container.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isBottomRounded: true,
      isTopRounded: true,
      margin: const EdgeInsets.symmetric(
        horizontal: Dimens.large,
      ).copyWith(bottom: Dimens.large),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(Dimens.medium),
            ),
          ),
          const SizedBox(width: Dimens.large),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Sleek Frozen Chair",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "The automobile layout consists of a front-engine design, with transaxle-type transmissions mounted at the rear of the engine and four wheel drive",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.remove),
                    color: Colors.red,
                  ),
                  const Text(
                    '1',
                    style: TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                  ),
                ],
              ),
              const Text(
                "Stock: 1",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ],
      ),
    );
  }
}
