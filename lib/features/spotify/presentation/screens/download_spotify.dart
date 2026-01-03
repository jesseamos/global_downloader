import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_downloader/core/config/colors_constant.dart';
import 'package:spotify_downloader/core/icons/vectors_icon.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_appbar.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_button.dart';
import 'package:spotify_downloader/core/presentation/widgets/custom_input_field.dart';
import 'package:spotify_downloader/core/presentation/widgets/helper_widgets.dart'; // Assuming showBottomModal is here
import 'package:spotify_downloader/core/presentation/widgets/state_widgets.dart'; // Assuming AppToast is here
import 'package:spotify_downloader/core/presentation/widgets/svg_icon.dart';
import 'package:spotify_downloader/features/spotify/presentation/cubit/sportify_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadSpotify extends StatefulWidget {
  static const routeName = '/download-spotify';
  const DownloadSpotify({super.key});

  @override
  State<DownloadSpotify> createState() => _DownloadSpotifyState();
}

class _DownloadSpotifyState extends State<DownloadSpotify> {
  final TextEditingController songId = TextEditingController();

  // Define local colors to ensure the dark theme works perfectly
  final Color spotifyBlack = const Color(0xFF191414);
  final Color spotifyDarkGrey = const Color(0xFF121212);
  final Color spotifyGreen = const Color(0xFF1DB954);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows gradient to go behind app bar
      appBar: const CustomAppbar(noLeadingIcon: true),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2E2E2E), // Lighter grey at top
              spotifyBlack, // Deep black at bottom
            ],
          ),
        ),
        child: BlocConsumer<SportifyCubit, SportifyState>(
          listener: (context, state) {
            if (state is SportifyFailure) {
              AppToast.show(
                context,
                message: state.message,
                type: ToastType.error,
              );
            }
            if (state is SportifySuccess) {
              _showSuccessModal(context, state);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const Spacer(flex: 1),
                    // 1. Visual Hero Section
                    _buildHeroSection(),
                    const SizedBox(height: 40),

                    // 2. Input Section
                    Text(
                      'Paste your link below',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 3. Wrapped Input Field for better integration
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: spotifyGreen.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CustomInputField(
                        hintText: 'https://open.spotify.com/track/...',
                        labelText: 'Song URL',
                        textInputType: TextInputType.url,
                        controller: songId,
                        // Ensure your custom input field handles text color correctly
                        // If it doesn't, you might need to adjust the widget itself
                      ),
                    ),

                    const Spacer(flex: 2),

                    // 4. Action Button
                    CustomButton(
                      isLoading: (state is SportifyLoading),
                      btnText: 'Convert & Download',
                      onTap: () {
                        if (songId.text.isNotEmpty) {
                          context.read<SportifyCubit>().downloadSong(
                            songId: songId.text,
                          );
                        } else {
                          AppToast.show(
                            context,
                            message: "Please enter a URL first",
                            type: ToastType.error,
                          );
                        }
                      },
                      bgColor: spotifyGreen,
                      textColor: Colors.white, // ensuring contrast
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper widget for the top icon
  Widget _buildHeroSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: spotifyDarkGrey,
            boxShadow: [
              BoxShadow(
                color: spotifyGreen.withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: SvgIcon(svgPath: spotifyIcon, size: 40),
        ),
        const SizedBox(height: 20),
        const Text(
          'Spotify Downloader',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  // Moved the modal logic here to keep build method clean
  // and applied better styling
  void _showSuccessModal(BuildContext context, SportifySuccess state) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: spotifyGreen.withOpacity(0.2),
                blurRadius: 50,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Modal Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 25),

              // Album Art with Shadow
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    state.data.data.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // Song Details
              Text(
                "Ready to Download",
                style: TextStyle(
                  color: spotifyGreen,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                state
                    .data
                    .data
                    .artist, // Assuming this is Song Name? If artist is name, swap them
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "${state.data.data.album} • ${state.data.data.releaseDate}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[400]),
              ),
              const SizedBox(height: 30),

              // Download Button
              CustomButton(
                btnText: 'Get MP3 File',
                onTap: () {
                  launchUrl(Uri.parse(state.data.data.downloadLink));
                  Navigator.pop(context);
                },
                bgColor: spotifyGreen,
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
