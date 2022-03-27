import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../flutter_portal.dart';
import 'portal_theater.dart';

class PortalLink {
  RenderPortalTheater? theater;

  BoxConstraints? get constraints => theater?.constraints;

  final overlays = <PortalLinkOverlay>{};

  @override
  String toString() => 'PortalLink#${shortHash(this)}';
}

@immutable
class PortalLinkOverlay {
  const PortalLinkOverlay(this.overlay, this.anchor);

  final RenderBox overlay;
  final Anchor anchor;

  // ONLY consider overlay, does NOT consider anchor
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PortalLinkOverlay &&
          runtimeType == other.runtimeType &&
          overlay == other.overlay;

  @override
  int get hashCode => overlay.hashCode;
}

class PortalLinkScope extends InheritedWidget {
  const PortalLinkScope({
    Key? key,
    required this.debugName,
    required this.portalLink,
    required this.portalContentPadding,
    required this.portalLabels,
    required Widget child,
  }) : super(key: key, child: child);

  final String? debugName;
  final PortalLink portalLink;
  final EdgeInsets portalContentPadding;
  final List<PortalLabel> portalLabels;

  @override
  bool updateShouldNotify(PortalLinkScope oldWidget) {
    return oldWidget.portalLink != portalLink ||
        !listEquals(oldWidget.portalLabels, portalLabels);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('debugName', debugName));
    properties.add(DiagnosticsProperty('portalLink', portalLink));
    properties
        .add(DiagnosticsProperty('portalContentPadding', portalContentPadding));
    properties.add(DiagnosticsProperty('portalLabel', portalLabels));
  }

  bool linkEquals(PortalLinkScope other) => portalLink == other.portalLink;
}
