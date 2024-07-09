import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:rent_hub/core/constants/ads/my_products_constants.dart';
import 'package:rent_hub/core/constants/animation_constants.dart';
import 'package:rent_hub/core/theme/app_theme.dart';
import 'package:rent_hub/features/ads/controller/my_products_controller/my_products_controller.dart';
import 'package:rent_hub/features/ads/view/pages/add_product_page.dart';
import 'package:rent_hub/features/ads/view/widgets/my_product_card/my_product_card_widget.dart';

class MyProductsPage extends ConsumerWidget {
  static const routePath = '/myProducts';
  const MyProductsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lottieConsts = ref.read(animationConstantsProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text(
          ref.watch(myProductsConstantsProvider).txtAppBarTitle,
        ),
        titleTextStyle: context.typography.h2Bold,
        centerTitle: true,
      ),
      body: ref.watch(myProductsProvider).when(
            data: (data) {
              return data.docs.isEmpty
                  ? LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Lottie.asset(
                            lottieConsts.animationEmpty,
                            height: constraints.maxHeight * .4,
                          ),
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: data.docs.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.spaces.space_200,
                            vertical: context.spaces.space_100),
                        child: MyProductCardWidget(
                          editonTap: () {
                            ref
                                .watch(myProductsProvider.notifier)
                                .updateMyProduct(
                                    id: data.docs[index].id,
                                    adsmodel: data.docs[index].data());
                                    
                            context.push(AddProductPage.routePath);
                          },
                          id: data.docs[index].id,
                          description:
                              data.docs[index].data().description ?? "",
                          myProductsOnTap: () {},
                          onSelected: (value) {},
                          Productimage: data.docs[index].data().imagePath[1],
                          poductPrice: data.docs[index].data().price,
                          productName: data.docs[index].data().productName,
                        ),
                      ),
                    );
            },
            error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
            loading: () => SizedBox(),
          ),
    );
  }
}
