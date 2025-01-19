import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salonguru_shop/core/constants/dimens.dart';
import 'package:salonguru_shop/core/shared_widget/card_container.dart';

import '../widgets/checkout_item_widget.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          tr('checkout'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(top: Dimens.large),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return const CheckoutItemWidget();
                  },
                ),
              ),
              const CardContainer(
                isBottomRounded: true,
                isTopRounded: true,
                margin: EdgeInsets.symmetric(horizontal: Dimens.large),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Price",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Euro 24,95",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Dimens.large),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.large),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimens.medium),
                      ),
                    ),
                    child: Text(
                      tr('done'),
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
