import 'package:flutter/material.dart';

import '../../../../core/constants/dimens.dart';
import '../../../../core/shared_widget/card_container.dart';

class CheckoutItemWidget extends StatelessWidget {
  const CheckoutItemWidget({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: Dimens.large),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 14),
              ),
              const Text(
                "Quantity: 4",
                style: TextStyle(fontSize: 12),
              ),
              const Text(
                "26.45",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
