// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:nobetci_eczane/models/pharmacy.dart';

class PharmacyMinCardWidget extends StatelessWidget {
  late Pharmacy pharmacy;

  PharmacyMinCardWidget({super.key, required this.pharmacy});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DistrictScreen(districtName: widget.districtName)));
      },
      child: Card(
        color: Colors.white,
        shape: _buildCardShape(),
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: ListTile(
            leading: const Icon(
              Icons.location_on,
              color: Colors.red,
              size: 32,
            ),
            title: Text(
              pharmacy.name,
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            subtitle: Text(pharmacy.address.split(',').first),
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
