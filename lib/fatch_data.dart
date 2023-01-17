import 'dart:ffi';

import 'package:ecommerce_api/details.dart';
import 'package:ecommerce_api/models/product_model.dart';
import 'package:ecommerce_api/respositoty/fatch_product_repo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FatchData extends StatefulWidget {
  const FatchData({super.key});

  @override
  State<FatchData> createState() => _FatchDataState();
}

class _FatchDataState extends State<FatchData> {
  late Future<List<Products>> futureProducts;
  @override
  void initState() {
    super.initState();
    futureProducts = ProductRepo().fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'PRODUCTS',
          style: GoogleFonts.anekTelugu(
            color: Colors.black,
            fontSize: 25,
          ),

          // style: TextStyle(
          //     color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          // ignore: prefer_const_constructors
          IconButton(
            onPressed: () {
              ProductRepo().addProduct(
                title: 'fake products',
                description: 'one of the most',
                price: 2599,
                category: 'Shirt',
                image:
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlnEqe2MWIqzcokR5pUaDEdHbVqMk5QLpHqw&usqp=CAU",
                rating: {'rate': 4.9},
              );
            },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Products>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var productData = snapshot.data;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 100,
                  childAspectRatio: 2 / 2,
                  crossAxisSpacing: 2,
                  mainAxisExtent: 400),
              itemCount: productData!.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Details(pro: productData[index]),
                        ));
                  },
                  child: Card(
                    child: Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Container(
                          child: Center(
                            child: Image.network(
                              productData[index].image!,
                              width: 200,
                              height: 200,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productData[index].title!),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(productData[index]
                                      .rating!
                                      .rate
                                      .toString())
                                ],
                              ),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      ProductRepo().updateProduct(
                                          id: productData[index].id.toString(),
                                          title: productData[index].title,
                                          price: productData[index]
                                              .price
                                              .toString());
                                    },
                                    child: const Text('update'),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        ProductRepo().deleteProduct(
                                            id: productData[index]
                                                .id
                                                .toString());
                                      },
                                      child: const Text(
                                        'Delete',
                                      ))
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  // child: ListTile(
                  //     title: Image.network(productData[index].image!),
                  //     subtitle: Column(
                  //       children: [
                  //         const SizedBox(
                  //           height: 20,
                  //         ),
                  //         Text(
                  //           productData[index].title!,
                  //           style: GoogleFonts.alike(),
                  //         ),
                  //         //Text(productData[index].description!)
                  //       ],
                  //     )),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
