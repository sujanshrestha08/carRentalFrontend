import 'package:car_rental/model/product.dart';
import 'package:car_rental/services/searchProduct_api.dart';
import 'package:car_rental/utils/search.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<ProductElement>? products;
  TextEditingController searchP = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              child: searchProduct(),
            ),
            TextField(
              controller: searchP,
            ),
            IconButton(
                onPressed: () {
                  getProduct(
                    searchP.text,
                    context,
                  );
                },
                icon: Icon(Icons.search))
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       itemCount: products?.length,
            //       itemBuilder: (context, index) {
            //         final product = products?[index];
            //         return ListTile(
            //           title: Text((products?[index].name).toString()),
            //         );
            //       }),
            // )
          ],
        ),
      ),
    );
  }

  Widget searchProduct() => Search(
        text: query,
        hintText: "Search...",
        onChanged: product,
      );

  Future product(String query) async {
    final products = await getProduct(query, context);
    if (!mounted) return;
    setState(() {
      this.query = query;
      this.products = products;
    });
  }
}
