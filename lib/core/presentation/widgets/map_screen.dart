import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreenWidget extends StatelessWidget {
  final List<Marker>? markers;
  const MapScreenWidget({super.key, this.markers});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(6.5244, 3.3792), // Lagos
        zoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.yourapp.spotify_downloader',
        ),
        if (markers != null) MarkerLayer(markers: markers!),
      ],
    );
  }
}
