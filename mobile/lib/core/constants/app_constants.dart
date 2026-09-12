class AppConstants {
  const AppConstants._();

  static const String appName = 'Mercadex';
  static const String homeTitle = 'Mercadex';
  static const String cokeProductId = 'coke-2l';
  static const double tabContentBottomPadding = 40;
}

class AppFormatters {
  const AppFormatters._();

  static String brl(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  static String distance(double km) {
    return '${km.toStringAsFixed(1).replaceAll('.', ',')} km';
  }
}
