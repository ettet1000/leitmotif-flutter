import 'package:flutter/foundation.dart';

class WebsiteInfo {
  final String websiteUrl;
  final String websiteDescription;

  /// Creates a [WebsiteInfo] object containing the url and description
  /// of a website to be displayed or to be navigated to.
  const WebsiteInfo({
    @required this.websiteUrl,
    @required this.websiteDescription,
  }) : assert(
          websiteUrl != null &&
              websiteDescription != null &&
              websiteUrl.length != 0,
        );
}
