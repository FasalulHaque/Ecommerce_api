import 'package:ecommerce_api/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Details extends StatelessWidget {
  Details({super.key, required this.pro});
  Products pro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
        ),
        body: ListView(
          children: [
            SafeArea(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 300,
                    width: 600,
                    alignment: Alignment.center,
                    child: Image.network(pro.image!),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    pro.title!,
                    style: GoogleFonts.anekTelugu(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    pro.description!,
                    style: GoogleFonts.anekTelugu(),
                  ),
                ],
              ),
            ))
          ],
        ));
  }
}
