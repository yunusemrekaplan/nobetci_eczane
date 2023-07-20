import 'package:nobetci_eczane/models/pharmacy.dart';
import 'package:web_scraper/web_scraper.dart';

class PharmacyService {

  static Future<List<Pharmacy>> getPharmacies(String district) async {
    List<Pharmacy> pharmacies = [];
    List<String> names = [];
    List<String> addresses = [];
    List<String> numbers = [];

    String webRoute = '';
    webRoute = _buildWebRoute(district);

    await getPharmacyNames(webRoute).then((value) => names = value!);
    await getPharmacyAddresses(webRoute).then((value) => addresses = value!);
    await getPharmacyNumbers(webRoute).then((value) => numbers = value!);

    int k = 0;
    for(int i=0; i<addresses.length; i++) {
      pharmacies.add(Pharmacy(name: names[k], address: addresses[i], number: numbers[i]));
      k += 2;
    }
    print('Pharmacies');
    print(pharmacies);
    return pharmacies;
  }

  static Future<List<String>?> getPharmacyNames(String webRoute) async {
    late List<Map<String, dynamic>> maps;
    final webScraper = WebScraper('https://www.eczaneler.gen.tr');
    if (await webScraper.loadWebPage(webRoute)) {
      maps = webScraper.getElement(
        'div.col-md-9 > div.tab-content > div.active > table.mt-2 > tbody > tr > td.border-bottom > div.row > div.col-lg-3',
        [],
      );
      List<String> names = [];
      for (int i = 0; i < maps.length; i++) {
        names.add(maps[i].values.first.toString());
      }
      return names;
    }
    return null;
  }

  static Future<List<String>?> getPharmacyAddresses(String webRoute) async {
    late List<Map<String, dynamic>> maps;
    final webScraper = WebScraper('https://www.eczaneler.gen.tr');
    if (await webScraper.loadWebPage(webRoute)) {
      maps = webScraper.getElement(
        'div.col-md-9 > div.tab-content > div.active > table.mt-2 > tbody > tr > td.border-bottom > div.row > div.col-lg-6',
        [],
      );
      List<String> addresses = [];
      for (int i = 0; i < maps.length; i++) {
        addresses.add(maps[i].values.first.substring(0, maps[i].values.first.indexOf("İstanbul") + "İstanbul".length));
      }
      //print(addresses[0].substring(0, addresses[0].indexOf("İstanbul") + "İstanbul".length));
      return addresses;
    }
    return null;
  }

  static Future<List<String>?> getPharmacyNumbers(String webRoute) async {
    late List<Map<String, dynamic>> maps;
    final webScraper = WebScraper('https://www.eczaneler.gen.tr');
    if (await webScraper.loadWebPage(webRoute)) {
      maps = webScraper.getElement(
        'div.col-md-9 > div.tab-content > div.active > table.mt-2 > tbody > tr > td.border-bottom > div.row > div.col-lg-3.py-lg-2',
        [],
      );
      List<String> numbers = [];
      for (int i = 0; i < maps.length; i++) {
        numbers.add(maps[i].values.first.toString());
      }
      return numbers;
    }
    return null;
  }

  static String _buildWebRoute(String district) {
    switch (district) {
      case 'Adalar':
        return '/nobetci-istanbul-adalar';
      case 'Arnavutköy':
        return '/nobetci-istanbul-arnavutkoy';
      case 'Ataşehir':
        return '/nobetci-istanbul-atasehir';
      case 'Avcılar':
        return '/nobetci-istanbul-avcilar';
      case 'Bağcılar':
        return '/nobetci-istanbul-bagcilar';
      case 'Bahçelievler':
        return '/nobetci-istanbul-bahcelievler';
      case 'Bakırköy':
        return '/nobetci-istanbul-bakirkoy';
      case 'Başakşehir':
        return '/nobetci-istanbul-basaksehir';
      case 'Bayrampaşa':
        return '/nobetci-istanbul-bayrampasa';
      case 'Beşiktaş':
        return '/nobetci-istanbul-besiktas';
      case 'Beykoz':
        return '/nobetci-istanbul-beykoz';
      case 'Beylikdüzü':
        return '/nobetci-istanbul-beylikduzu';
      case 'Beyoğlu':
        return '/nobetci-istanbul-beyoglu';
      case 'Büyükçekmece':
        return '/nobetci-istanbul-buyukcekmece';
      case 'Çatalca':
        return '/nobetci-istanbul-catalca';
      case 'Çekmeköy':
        return '/nobetci-istanbul-cekmekoy';
      case 'Esenler':
        return '/nobetci-istanbul-esenler';
      case 'Esenyurt':
        return '/nobetci-istanbul-esenyurt';
      case 'Eyüp':
        return '/nobetci-istanbul-eyup';
      case 'Fatih':
        return '/nobetci-istanbul-fatih';
      case 'Gaziosmanpaşa':
        return '/nobetci-istanbul-gaziosmanpasa';
      case 'Güngören':
        return '/nobetci-istanbul-gungoren';
      case 'Kadıköy':
        return '/nobetci-istanbul-kadikoy';
      case 'Kağıthane':
        return '/nobetci-istanbul-kagithane';
      case 'Kartal':
        return '/nobetci-istanbul-kartal';
      case 'Küçükçekmece':
        return '/nobetci-istanbul-kucukcekmece';
      case 'Maltepe':
        return '/nobetci-istanbul-maltepe';
      case 'Pendik':
        return '/nobetci-istanbul-pendik';
      case 'Sancaktepe':
        return '/nobetci-istanbul-sancaktepe';
      case 'Sarıyer':
        return '/nobetci-istanbul-sariyer';
      case 'Şile':
        return '/nobetci-istanbul-sile';
      case 'Silivri':
        return '/nobetci-istanbul-silivri';
      case 'Şişli':
        return '/nobetci-istanbul-sisli';
      case 'Sultanbeyli':
        return '/nobetci-istanbul-sultanbeyli';
      case 'Sultangazi':
        return '/nobetci-istanbul-sultangazi';
      case 'Tuzla':
        return '/nobetci-istanbul-tuzla';
      case 'Ümraniye':
        return '/nobetci-istanbul-umraniye';
      case 'Üsküdar':
        return '/nobetci-istanbul-uskudar';
      case 'Zeytinburnu':
        return '/nobetci-istanbul-zeytinburnu';
    }
    return '';
  }
}
