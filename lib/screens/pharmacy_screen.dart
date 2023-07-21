// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nobetci_eczane/models/pharmacy.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyScreen extends StatelessWidget {
  late Pharmacy pharmacy;
  PharmacyScreen({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        titleSpacing: 5,
        leading: Image.asset(
          'lib/assets/images/logo_img.png',
          width: 50,
          height: 50,
        ),
        title: Text(
          pharmacy.name,
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Card(
                        color: Colors.white,
                        shape: _buildCardShape(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: 32,
                              ),
                              onPressed: () async {
                                Uri url = Uri.parse(
                                    "https://www.google.com/maps/search/?api=1&query=${pharmacy.address}");
                                try {
                                  await launchUrl(url);
                                } on PlatformException catch (e) {
                                  print(
                                      "Failed to make phone call: ${e.message}");
                                }
                              },
                            ),
                            title: Text(
                              pharmacy.address,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        shape: _buildCardShape(),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: ListTile(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.red,
                                size: 32,
                              ),
                              onPressed: () async {
                                Uri url = Uri.parse('tel:${pharmacy.number}');
                                try {
                                  await launchUrl(url);
                                } on PlatformException catch (e) {
                                  print(
                                      "Failed to make phone call: ${e.message}");
                                }
                              },
                            ),
                            title: Text(
                              pharmacy.number,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RoundedRectangleBorder _buildCardShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
  }
}
