import 'package:flutter/material.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/icons/bottom_navs_icons.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';

class MainDashboardScreen extends StatefulWidget {
  final int? index;
  static const routeName = '/main-dashboard-screen';
  const MainDashboardScreen({super.key, this.index = 0});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int? _selectedIndex;
  @override
  void didUpdateWidget(covariant MainDashboardScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.index != oldWidget.index) {
      setState(() {
        _selectedIndex = widget.index ?? 0;
      });
    }
  }

  static const List<Widget> _widgetOptions = <Widget>[
    Placeholder(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex ?? 0),
      bottomNavigationBar: SizedBox(
        height: 77,
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgIcon(svgPath: inActiveHomeIcon, size: 24),
              activeIcon: SvgIcon(
                svgPath: activeHomeIcon,
                size: 24,
                color: ColorsConstant.primaryColor,
              ),
              label: 'Spotify',
            ),
            // BottomNavigationBarItem(
            //   icon: SvgIcon(svgPath: locationPinIcon, size: 24),
            //   activeIcon: SvgIcon(svgPath: activeLocationPinIcon, size: 24),
            //   label: 'Map',
            // ),
            BottomNavigationBarItem(
              icon: SvgIcon(svgPath: inactiveRewardClaimIcon, size: 24),
              activeIcon: SvgIcon(svgPath: claimDealIcon, size: 24),
              label: 'Reward',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon(svgPath: inActiveWalletIcon, size: 24),
              activeIcon: SvgIcon(
                svgPath: activeWalletIcon,
                size: 24,
                color: ColorsConstant.primaryColor,
              ),
              label: 'Wallet',
            ),
            BottomNavigationBarItem(
              icon: SvgIcon(svgPath: inActiveProfileIcon, size: 24),
              activeIcon: SvgIcon(
                svgPath: activeProfileIcon,
                size: 24,
                color: ColorsConstant.primaryColor,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex ?? 0,
          selectedItemColor: ColorsConstant.primaryColor,
          unselectedItemColor: ColorsConstant.grey100,
          backgroundColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.transparent
              : Colors.white,
          unselectedFontSize: 12,
          selectedFontSize: 12,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
