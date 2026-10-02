import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

// Web file upload & local storage helper import (guarded for web)
import 'dart:html' as html if (dart.library.io) 'dart:io';

void main() {
  runApp(const CousinCrewApp());
}

// Global Shared Data Store for Gallery Items (Supports Base64 Images & Videos with Permanent LocalStorage)
class GalleryItemModel {
  final String id;
  final String title;
  final String category;
  final String description;
  final String imageUrl; // Image/Video URL, Base64 Data URL or Asset Path
  final bool isVideo;

  GalleryItemModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.imageUrl,
    this.isVideo = false,
  });
}

class GalleryDataStore extends ChangeNotifier {
  static final GalleryDataStore instance = GalleryDataStore._internal();

  GalleryDataStore._internal() {
    _loadFromStorage();
  }

  final List<GalleryItemModel> _items = [
    // 9 Deco Videos from local assets/videos/
    GalleryItemModel(
      id: 'dv1',
      title: 'Royal Wedding Entrance Decor Highlight',
      category: 'WEDDINGS',
      description: 'Live video highlight of royal entrance arch with floral pillars and warm ambient lighting.',
      imageUrl: 'assets/videos/deco_video (1).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv2',
      title: 'Luxury Mandap Setup Reel',
      category: 'STAGE DECOR',
      description: 'Cinematic mandap stage setup with crystal chandeliers and traditional brass lamps.',
      imageUrl: 'assets/videos/deco_video (2).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv3',
      title: 'Sangeet Stage Pyro Special',
      category: 'STAGE DECOR',
      description: 'Concert sound and pyrotechnic cold pyro show for Sangeet couple entry.',
      imageUrl: 'assets/videos/deco_video (3).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv4',
      title: 'Vibrant Haldi Flower Shower Reel',
      category: 'HALDI / MEHNDI',
      description: 'Marigold sunflower photo booth with live flower shower entry for Haldi function.',
      imageUrl: 'assets/videos/deco_video (4).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv5',
      title: 'Royal Birthday Cake Throne Entry',
      category: 'BIRTHDAY',
      description: 'Custom balloon kingdom arch with customized cake throne and LED signage.',
      imageUrl: 'assets/videos/deco_video (5).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv6',
      title: 'Crystal Chandelier Stage Reel',
      category: 'STAGE DECOR',
      description: 'Luxury indoor stage with customized monogram floor and warm mood lighting.',
      imageUrl: 'assets/videos/deco_video (6).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv7',
      title: 'Couple Grand Entry Fireworks',
      category: 'WEDDINGS',
      description: 'Dramatic couple entry walk with smoke fountains and cold sparklers.',
      imageUrl: 'assets/videos/deco_video (7).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv8',
      title: 'Theme Reception Setup Highlights',
      category: 'WEDDINGS',
      description: 'Bespoke reception stage decor with royal silver couches and floral ceiling drapery.',
      imageUrl: 'assets/videos/deco_video (8).MP4',
      isVideo: true,
    ),
    GalleryItemModel(
      id: 'dv9',
      title: 'Silver Anniversary Gala Reel',
      category: 'ANNIVERSARY',
      description: 'Vintage 25th anniversary candlelit stage setup with customized couple initials.',
      imageUrl: 'assets/videos/deco_video (9).MP4',
      isVideo: true,
    ),

    // 22 Birthday Photos from local assets/images/
    GalleryItemModel(
      id: 'b1',
      title: 'Pastel Kingdom Birthday Decor',
      category: 'BIRTHDAY',
      description: 'Royal pastel balloon archway with customized birthday throne and entrance decor in Gujarat.',
      imageUrl: 'assets/images/birthday photo  (1).jpeg',
    ),
    GalleryItemModel(
      id: 'b2',
      title: 'Magical 1st Birthday Setup',
      category: 'BIRTHDAY',
      description: 'Customized milestone photobooth with fairy lights and theme cake table styling.',
      imageUrl: 'assets/images/birthday photo  (2).jpeg',
    ),
    GalleryItemModel(
      id: 'b3',
      title: 'Golden Crown Birthday Celebration',
      category: 'BIRTHDAY',
      description: 'Luxury gold and white theme decor with custom balloon pillars and stage backdrop.',
      imageUrl: 'assets/images/birthday photo  (3).jpeg',
    ),
    GalleryItemModel(
      id: 'b4',
      title: 'Fairytale Princess Theme',
      category: 'BIRTHDAY',
      description: 'Enchanted pink and white castle backdrop with personalized LED birthday signage.',
      imageUrl: 'assets/images/birthday photo  (4).jpeg',
    ),
    GalleryItemModel(
      id: 'b5',
      title: 'Safari Jungle Birthday Decor',
      category: 'BIRTHDAY',
      description: 'Vibrant jungle theme setup with oversized balloon animals and interactive photo corner.',
      imageUrl: 'assets/images/birthday photo  (5).jpeg',
    ),
    GalleryItemModel(
      id: 'b6',
      title: 'Modern Minimalist Birthday Setup',
      category: 'BIRTHDAY',
      description: 'Chic boho-style birthday decor with pampas grass, warm lighting, and nude balloons.',
      imageUrl: 'assets/images/birthday photo  (6).jpeg',
    ),
    GalleryItemModel(
      id: 'b7',
      title: 'Royal Prince Milestone Party',
      category: 'BIRTHDAY',
      description: 'Grand royal velvet backdrop with customized gold crown throne and cake display.',
      imageUrl: 'assets/images/birthday photo  (7).jpeg',
    ),
    GalleryItemModel(
      id: 'b8',
      title: 'Candy Land Birthday Setup',
      category: 'BIRTHDAY',
      description: 'Playful pastel candy theme with custom props, lollipop cutouts, and balloon arch.',
      imageUrl: 'assets/images/birthday photo  (8).jpeg',
    ),
    GalleryItemModel(
      id: 'b9',
      title: 'Celestial Starry Night Party',
      category: 'BIRTHDAY',
      description: 'Dreamy deep blue and gold balloon decor with glowing LED stars and moon backdrop.',
      imageUrl: 'assets/images/birthday photo  (9).jpeg',
    ),
    GalleryItemModel(
      id: 'b10',
      title: 'Under The Sea Birthday Theme',
      category: 'BIRTHDAY',
      description: 'Ocean blue and lavender balloon decor with custom seashell cake throne.',
      imageUrl: 'assets/images/birthday photo  (10).jpeg',
    ),
    GalleryItemModel(
      id: 'b11',
      title: 'Vintage Floral Birthday Gala',
      category: 'BIRTHDAY',
      description: 'Elegant rose and gold theme decoration with personalized couple monogram.',
      imageUrl: 'assets/images/birthday photo  (11).jpeg',
    ),
    GalleryItemModel(
      id: 'b12',
      title: 'Carnival Theme Celebration',
      category: 'BIRTHDAY',
      description: 'Bright red and yellow carnival birthday booth with customized game counters.',
      imageUrl: 'assets/images/birthday photo  (12).jpeg',
    ),
    GalleryItemModel(
      id: 'b13',
      title: 'Butterfly Garden Birthday',
      category: 'BIRTHDAY',
      description: 'Enchanted floral garden setup with 3D glowing butterflies and tea party seating.',
      imageUrl: 'assets/images/birthday photo  (13).jpeg',
    ),
    GalleryItemModel(
      id: 'b14',
      title: 'Superhero Adventure Party',
      category: 'BIRTHDAY',
      description: 'Dynamic superhero cityscape backdrop with interactive props and photobooth.',
      imageUrl: 'assets/images/birthday photo  (14).jpeg',
    ),
    GalleryItemModel(
      id: 'b15',
      title: 'Space Explorer Theme Decor',
      category: 'BIRTHDAY',
      description: 'Galaxy themed dark blue backdrop with LED rockets and planet balloons.',
      imageUrl: 'assets/images/birthday photo  (15).jpeg',
    ),
    GalleryItemModel(
      id: 'b16',
      title: 'Teddy Bear Dreamland',
      category: 'BIRTHDAY',
      description: 'Soft beige and white teddy bear birthday stage decor for toddlers.',
      imageUrl: 'assets/images/birthday photo  (16).jpeg',
    ),
    GalleryItemModel(
      id: 'b17',
      title: 'Neon Glow Milestone Birthday',
      category: 'BIRTHDAY',
      description: 'Futuristic UV neon light setup with customized glow signage and DJ booth.',
      imageUrl: 'assets/images/birthday photo  (17).jpeg',
    ),
    GalleryItemModel(
      id: 'b18',
      title: 'Boho Rainbow Birthday Setup',
      category: 'BIRTHDAY',
      description: 'Soft pastel rainbow balloon arch with wooden dessert table styling.',
      imageUrl: 'assets/images/birthday photo  (18).jpeg',
    ),
    GalleryItemModel(
      id: 'b19',
      title: 'Luxury Silver & White Party',
      category: 'BIRTHDAY',
      description: 'Shimmering metallic silver backdrop with crystal chandeliers and cake throne.',
      imageUrl: 'assets/images/birthday photo  (19).jpeg',
    ),
    GalleryItemModel(
      id: 'b20',
      title: 'Unicorn Fantasy Decor',
      category: 'BIRTHDAY',
      description: 'Magical pastel rainbow theme with customized unicorn photobooth.',
      imageUrl: 'assets/images/birthday photo  (20).jpeg',
    ),
    GalleryItemModel(
      id: 'b21',
      title: 'Traditional Gujarati Milestone Birthday',
      category: 'BIRTHDAY',
      description: 'Rich marigold and brass lamp stage decor for milestone adult birthday celebrations.',
      imageUrl: 'assets/images/birthday photo  (21).jpeg',
    ),
    GalleryItemModel(
      id: 'b22',
      title: 'Grand Birthday Entrance Arch',
      category: 'BIRTHDAY',
      description: 'Royal welcome archway with personalized welcome sign and red carpet walkway.',
      imageUrl: 'assets/images/birthday photo  (22).jpeg',
    ),
  ];

  List<GalleryItemModel> get items => List.unmodifiable(_items);

  void _saveToStorage() {
    if (kIsWeb) {
      try {
        final jsonList = _items.map((item) => {
          'id': item.id,
          'title': item.title,
          'category': item.category,
          'description': item.description,
          'imageUrl': item.imageUrl,
          'isVideo': item.isVideo,
        }).toList();
        html.window.localStorage['cousin_crew_gallery_v3'] = jsonEncode(jsonList);
      } catch (e) {
        print("Storage save error: $e");
      }
    }
  }

  void _loadFromStorage() {
    if (kIsWeb) {
      try {
        final savedJson = html.window.localStorage['cousin_crew_gallery_v3'];
        if (savedJson != null && savedJson.isNotEmpty) {
          final List<dynamic> decoded = jsonDecode(savedJson);
          if (decoded.isNotEmpty) {
            _items.clear();
            for (var map in decoded) {
              _items.add(GalleryItemModel(
                id: map['id'] ?? '',
                title: map['title'] ?? '',
                category: map['category'] ?? 'BIRTHDAY',
                description: map['description'] ?? '',
                imageUrl: map['imageUrl'] ?? '',
                isVideo: map['isVideo'] ?? false,
              ));
            }
          }
        }
      } catch (e) {
        print("Storage load error: $e");
      }
    }
  }

  void addItem(GalleryItemModel item) {
    _items.add(item);
    _saveToStorage();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void updateItem(GalleryItemModel updatedItem) {
    final index = _items.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _items[index] = updatedItem;
      _saveToStorage();
      notifyListeners();
    }
  }
}

// Auto-Playing Video Player Widget with Sound Mute / Unmute Toggle Button
class AutoPlayVideoWidget extends StatefulWidget {
  final String videoUrl;
  const AutoPlayVideoWidget({super.key, required this.videoUrl});

  @override
  State<AutoPlayVideoWidget> createState() => _AutoPlayVideoWidgetState();
}

class _AutoPlayVideoWidgetState extends State<AutoPlayVideoWidget> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _isMuted = true; // Muted by default for browser autoplay compliance

  @override
  void initState() {
    super.initState();
    if (widget.videoUrl.startsWith('http') ||
        widget.videoUrl.startsWith('blob:') ||
        widget.videoUrl.startsWith('data:')) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    } else {
      _controller = VideoPlayerController.asset(widget.videoUrl);
    }

    _controller.initialize().then((_) {
      if (mounted) {
        setState(() => _initialized = true);
        _controller.setLooping(true);
        _controller.setVolume(0.0); // Default Muted
        _controller.play();
      }
    }).catchError((err) {
      print("Video error: $err");
    });
  }

  void _toggleSound() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initialized) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),
            // Sound Mute / Unmute Toggle Button
            Positioned(
              bottom: 10,
              right: 10,
              child: Material(
                color: Colors.black.withAlpha(160),
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: _toggleSound,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _isMuted ? 'Muted' : 'Sound ON',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return Container(
      color: Colors.black12,
      child: const Center(
        child: CircularProgressIndicator(color: Color(0xFFC5A059)),
      ),
    );
  }
}

class CousinCrewApp extends StatelessWidget {
  const CousinCrewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cousin Crews | Wedding & Event Specialists',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC5A059),
          primary: const Color(0xFF0A192F), // Deep Navy
          secondary: const Color(0xFFC5A059), // Gold
          surface: const Color(0xFFFAF9F5), // Warm Cream Surface
        ),
        textTheme: GoogleFonts.playfairDisplayTextTheme().copyWith(
          bodyMedium: GoogleFonts.montserrat(),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/gallery': (context) => const GalleryPage(),
        '/admin': (context) => const AdminPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final String _whatsappNumber = "916354504775";

  final Color primaryColor = const Color(0xFF0A192F);
  final Color secondaryColor = const Color(0xFFC5A059);
  final Color surfaceColor = const Color(0xFFFAF9F5);
  final Color darkBrown = const Color(0xFF4A3728);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedService = 'Full Event Planning';

  bool _showWelcome = true;
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (mounted) {
        setState(() {
          _scrollOffset = _scrollController.offset;
        });
      }
    });

    Future.delayed(const Duration(milliseconds: 2400), () {
      if (mounted) {
        setState(() => _showWelcome = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOutCubic,
    );
  }

  void _openGalleryPage() {
    Navigator.pushNamed(context, '/gallery');
  }

  void _openAdminPage() {
    Navigator.pushNamed(context, '/admin');
  }

  void _launchWhatsApp() {
    String message =
        "Hello Cousin Crews! I would like to enquire about $_selectedService.\nName: ${_nameController.text}\nPhone: ${_phoneController.text}";
    print("Launching WhatsApp to $_whatsappNumber with message: $message");
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: surfaceColor,
      floatingActionButton: _PulsingWhatsAppButton(onPressed: _launchWhatsApp),
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: const Color(0xFFFAF9F5),
                elevation: 1,
                shadowColor: Colors.black.withAlpha(15),
                toolbarHeight: 90,
                title: InkWell(
                  onTap: () => _scrollToSection(0),
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 70,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'COUSIN CREWS',
                              style: GoogleFonts.playfairDisplay(
                                color: primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 26,
                                letterSpacing: 3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            _ShimmerGoldLine(color: secondaryColor),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                actions: isDesktop
                    ? [
                        _navButton('HOME', () => _scrollToSection(0)),
                        _navButton('SERVICES', () => _scrollToSection(850)),
                        _navButton('COLLECTIONS', () => _scrollToSection(2400)),
                        _navButton('GALLERY PAGE', _openGalleryPage),
                        _navButton('REVIEWS', () => _scrollToSection(4500)),
                        _navButton('CONTACT', () => _scrollToSection(5300)),
                        const SizedBox(width: 20),
                        _AnimatedBookButton(
                          onPressed: () => _scrollToSection(5300),
                        ),
                        const SizedBox(width: 20),
                      ]
                    : null,
              ),

              SliverList(
                delegate: SliverChildListDelegate([
                  _buildParallaxHero(isDesktop),
                  _buildAnimatedStats(),
                  _buildInteractiveCollections(isDesktop),
                  _buildAutoScrollingVideoStrip(isDesktop),
                  _buildAnimatedReviews(),
                  _buildLuxuryBookingSection(isDesktop),
                  _buildFooter(),
                ]),
              ),
            ],
          ),

          if (_showWelcome) _AnimatedWelcomeOverlay(isDesktop: isDesktop),
        ],
      ),
    );
  }

  Widget _navButton(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onTap,
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 12,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }

  Widget _buildParallaxHero(bool isDesktop) {
    final double parallaxOffset = _scrollOffset * 0.4;

    return Container(
      height: isDesktop ? 800 : 620,
      width: double.infinity,
      margin: EdgeInsets.all(isDesktop ? 20 : 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isDesktop ? 36 : 20),
        child: Stack(
          children: [
            Positioned.fill(
              top: -parallaxOffset,
              child: Image.network(
                'https://images.unsplash.com/photo-1519225421980-715cb0215aed?auto=format&fit=crop&w=1950&q=80',
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      surfaceColor.withAlpha(235),
                      surfaceColor.withAlpha(160),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? 80 : 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _FadeSlideEntrance(
                    delayMs: 100,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: secondaryColor.withAlpha(30),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: secondaryColor.withAlpha(100)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, size: 14, color: secondaryColor),
                          const SizedBox(width: 8),
                          Text(
                            'PREMIUM EVENT SPECIALISTS',
                            style: GoogleFonts.montserrat(
                              color: darkBrown,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  _FadeSlideEntrance(
                    delayMs: 300,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Events That\n',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: isDesktop ? 88 : 46,
                              fontWeight: FontWeight.w900,
                              color: darkBrown,
                              height: 1.05,
                            ),
                          ),
                          TextSpan(
                            text: 'Define You',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: isDesktop ? 96 : 52,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF8B4513),
                              height: 1.05,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  _FadeSlideEntrance(
                    delayMs: 500,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 520),
                      child: Text(
                        'Tailored wedding planning, luxury stage decor, birthday parties & anniversary galas crafted with elegance in Gujarat.',
                        style: GoogleFonts.montserrat(
                          fontSize: 17,
                          color: Colors.black87,
                          height: 1.7,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  _FadeSlideEntrance(
                    delayMs: 700,
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 15,
                      children: [
                        _HoverScaleButton(
                          text: 'BOOK AN EVENT',
                          bgColor: darkBrown,
                          textColor: Colors.white,
                          onPressed: () => _scrollToSection(5300),
                        ),
                        _HoverScaleButton(
                          text: 'EXPLORE GALLERY',
                          bgColor: Colors.transparent,
                          textColor: darkBrown,
                          borderColor: darkBrown,
                          onPressed: _openGalleryPage,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedStats() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 20),
      color: Colors.white,
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        spacing: 40,
        runSpacing: 40,
        children: const [
          _CountingStatCard(targetValue: 500, label: 'EVENTS MANAGED', suffix: '+'),
          _CountingStatCard(targetValue: 150, label: 'LUXURY WEDDINGS', suffix: '+'),
          _CountingStatCard(targetValue: 15, label: 'YEARS EXPERIENCE', suffix: '+'),
        ],
      ),
    );
  }

  Widget _buildInteractiveCollections(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 110,
        horizontal: isDesktop ? 80 : 20,
      ),
      color: surfaceColor,
      child: Column(
        children: [
          _FadeSlideEntrance(
            child: Column(
              children: [
                Text(
                  'Signature Services',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isDesktop ? 46 : 32,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                Container(height: 3, width: 70, color: secondaryColor),
                const SizedBox(height: 15),
                Text(
                  'Weddings, Birthday Celebrations, Anniversaries & Corporate Galas',
                  style: GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),

          _InteractiveProjectCard(
            isDesktop: isDesktop,
            title: 'Full Event Planning',
            subtitle: 'End-to-End Luxury Management',
            description:
                'Complete peace of mind. From initial concept, venue selection, theme decor, catering, to on-site coordination.',
            imageUrl:
                'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
            imgLeft: true,
            onDetailsPressed: () => _openDetailsDialog(
              context,
              'Full Event Planning',
              'Comprehensive, luxury start-to-finish event planning. We handle budgets, vendor negotiations, timeline execution, and guest logistics so you can enjoy your celebration.',
              'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
            ),
          ),
          const SizedBox(height: 70),

          _InteractiveProjectCard(
            isDesktop: isDesktop,
            title: 'Birthday & Anniversary Specials',
            subtitle: 'Unforgettable Milestone Celebrations',
            description:
                'Bespoke balloon arches, customized cake thrones, LED dance floors, and romantic candlelit anniversary galas.',
            imageUrl:
                'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?auto=format&fit=crop&w=800&q=80',
            imgLeft: false,
            onDetailsPressed: () => _openDetailsDialog(
              context,
              'Birthday & Anniversary Specials',
              'Tailored theme celebrations for all ages! We design balloon decor, photobooths, customized stage lighting, and luxury catering to make your milestone unforgettable.',
              'https://images.unsplash.com/photo-1530103862676-de8c9debad1d?auto=format&fit=crop&w=800&q=80',
            ),
          ),
          const SizedBox(height: 70),

          _InteractiveProjectCard(
            isDesktop: isDesktop,
            title: 'Event Management',
            subtitle: 'Flawless On-the-Day Coordination',
            description:
                'Ensure your big day runs smoothly. We manage on-site vendors, timeline flow, and emergency logistics.',
            imageUrl:
                'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=800&q=80',
            imgLeft: true,
            onDetailsPressed: () => _openDetailsDialog(
              context,
              'Event Management',
              'Flawless on-the-day coordination. From vendor arrival management to stage cues and guest welcome, we take care of everything behind the scenes.',
              'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=800&q=80',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoScrollingVideoStrip(bool isDesktop) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 100),
      color: Colors.white,
      child: Column(
        children: [
          _FadeSlideEntrance(
            child: Column(
              children: [
                Text(
                  'Live Event Reels',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isDesktop ? 46 : 32,
                    fontWeight: FontWeight.w900,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 3, width: 70, color: secondaryColor),
                const SizedBox(height: 15),
                Text(
                  'Auto-playing live highlights from our Gujarat weddings & celebrations',
                  style: GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 60),
          const _AutoScrollingVideoReelsStrip(),
        ],
      ),
    );
  }

  void _openDetailsDialog(BuildContext context, String title, String fullDesc, String imgUrl) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(35),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(imgUrl, height: 250, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 25),
              Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                fullDesc,
                style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey[700], height: 1.7),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Close', style: TextStyle(color: Colors.grey[600])),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _scrollToSection(5300);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    ),
                    child: const Text('Enquire Now'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedReviews() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 110),
      color: surfaceColor,
      child: Column(
        children: [
          Text(
            'Client Experiences',
            style: GoogleFonts.playfairDisplay(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'What our beautiful couples and hosts say about us',
            style: GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 70),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: const [
                _HoverReviewCard(
                  name: 'Hardik & Sneha',
                  review: 'Cousin Crews handled our corporate gala & wedding functions seamlessly. Unmatched attention to detail!',
                ),
                _HoverReviewCard(
                  name: 'Meera Shah',
                  review: 'The dream Haldi & Birthday decor I always wanted! Dhruv and the team are true magicians.',
                ),
                _HoverReviewCard(
                  name: 'Karan Joshi',
                  review: 'Extremely professional on-site management. Everything ran strictly on schedule without any stress.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLuxuryBookingSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 120,
        horizontal: isDesktop ? 80 : 20,
      ),
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          image: const NetworkImage(
            'https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1950&q=80',
          ),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(primaryColor.withAlpha(235), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Begin Your Story With Us',
            style: GoogleFonts.playfairDisplay(
              fontSize: isDesktop ? 56 : 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            'Fill in your details below and our specialist team will connect via WhatsApp instantly.',
            style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 15),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 70),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: Container(
              padding: EdgeInsets.all(isDesktop ? 60 : 30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(50),
                    blurRadius: 50,
                    offset: const Offset(0, 20),
                  )
                ],
              ),
              child: isDesktop
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildFormInputs()),
                        const SizedBox(width: 70),
                        Expanded(child: _buildInfoColumn()),
                      ],
                    )
                  : Column(
                      children: [
                        _buildFormInputs(),
                        const SizedBox(height: 50),
                        _buildInfoColumn(),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormInputs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _formLabel('FULL NAME'),
        _formTextField('Enter your name...', _nameController),
        _formLabel('WHATSAPP NUMBER'),
        _formTextField('+91 63545 04775', _phoneController),
        _formLabel('EVENT CATEGORY'),
        DropdownButtonFormField<String>(
          value: _selectedService,
          style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 15),
          decoration: InputDecoration(
            filled: true,
            fillColor: surfaceColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
          items: [
            'Full Event Planning',
            'Partial Event Planning',
            'Birthday Party',
            'Anniversary Celebration',
            'Event Management',
            'Content Creation'
          ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
          onChanged: (v) => setState(() => _selectedService = v!),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _launchWhatsApp,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: const Text(
              'SEND INQUIRY VIA WHATSAPP',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact & Support',
          style: GoogleFonts.playfairDisplay(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 30),
        _contactDetailRow(Icons.location_on_outlined, 'Ahmedabad, Gujarat, India'),
        _contactDetailRow(Icons.phone_outlined, '+91 63545 04775'),
        _contactDetailRow(Icons.email_outlined, 'hello@cousincrews.com'),
        const SizedBox(height: 40),
        Text(
          'Service Hours',
          style: GoogleFonts.playfairDisplay(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Monday - Sunday: 09:00 AM - 08:00 PM',
          style: GoogleFonts.montserrat(color: Colors.grey[600], height: 1.8, fontSize: 15),
        ),
      ],
    );
  }

  Widget _contactDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: secondaryColor, size: 24),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLabel(String label) => Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 10),
        child: Text(
          label,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w800,
            fontSize: 11,
            letterSpacing: 2,
            color: Colors.grey[700],
          ),
        ),
      );

  Widget _formTextField(String hint, TextEditingController controller) => TextField(
        controller: controller,
        style: GoogleFonts.montserrat(fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: surfaceColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      );

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
      color: primaryColor,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 90,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Text(
              'COUSIN CREWS',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIconButton(Icons.facebook),
              _socialIconButton(Icons.camera_alt_outlined),
              _socialIconButton(Icons.share_outlined),
            ],
          ),
          const SizedBox(height: 50),
          const Divider(color: Colors.white10),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onLongPress: _openAdminPage, // Discreet Long Press for Admin Login
                child: Text(
                  '© 2026 COUSIN CREWS.',
                  style: GoogleFonts.montserrat(
                    color: Colors.white38,
                    fontSize: 12,
                    letterSpacing: 3,
                  ),
                ),
              ),
              Row(
                children: [
                  Text('PRIVACY POLICY', style: GoogleFonts.montserrat(color: Colors.white24, fontSize: 11, letterSpacing: 2)),
                  const SizedBox(width: 30),
                  Text('TERMS OF SERVICE', style: GoogleFonts.montserrat(color: Colors.white24, fontSize: 11, letterSpacing: 2)),
                  const SizedBox(width: 30),
                  GestureDetector(
                    onTap: _openAdminPage,
                    child: const Icon(Icons.lock_outline, color: Colors.white24, size: 16),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialIconButton(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Icon(icon, color: Colors.white60, size: 28),
    );
  }
}

// Auto-scrolling Video Reels Strip Widget with 9 Deco Videos & Sound Toggle
class _AutoScrollingVideoReelsStrip extends StatefulWidget {
  const _AutoScrollingVideoReelsStrip();

  @override
  State<_AutoScrollingVideoReelsStrip> createState() => _AutoScrollingVideoReelsStripState();
}

class _AutoScrollingVideoReelsStripState extends State<_AutoScrollingVideoReelsStrip> {
  late ScrollController _scrollController;

  final List<Map<String, String>> _reels = const [
    {
      'title': 'Royal Wedding Entrance Decor',
      'url': 'assets/videos/deco_video (1).MP4',
    },
    {
      'title': 'Luxury Floral Mandap Highlights',
      'url': 'assets/videos/deco_video (2).MP4',
    },
    {
      'title': 'Sangeet Stage Pyro Show',
      'url': 'assets/videos/deco_video (3).MP4',
    },
    {
      'title': 'Vibrant Haldi Flower Shower',
      'url': 'assets/videos/deco_video (4).MP4',
    },
    {
      'title': 'Birthday Cake Throne Celebration',
      'url': 'assets/videos/deco_video (5).MP4',
    },
    {
      'title': 'Crystal Chandelier Stage Lighting',
      'url': 'assets/videos/deco_video (6).MP4',
    },
    {
      'title': 'Royal Couple Entry Fireworks',
      'url': 'assets/videos/deco_video (7).MP4',
    },
    {
      'title': 'Theme Wedding Reception Setup',
      'url': 'assets/videos/deco_video (8).MP4',
    },
    {
      'title': 'Grand Anniversary Gala Highlights',
      'url': 'assets/videos/deco_video (9).MP4',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted && _scrollController.hasClients) {
        _animateScroll();
      }
    });
  }

  void _animateScroll() {
    if (!mounted || !_scrollController.hasClients) return;
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.offset;
    if (currentScroll >= maxScroll - 10) {
      _scrollController.jumpTo(0);
    }
    _scrollController
        .animateTo(
          _scrollController.offset + 180,
          duration: const Duration(seconds: 2),
          curve: Curves.linear,
        )
        .then((_) {
      if (mounted) {
        _animateScroll();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 380,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _reels.length * 50,
        itemBuilder: (context, index) {
          final reel = _reels[index % _reels.length];
          return Container(
            width: 280,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: AutoPlayVideoWidget(videoUrl: reel['url']!),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFC5A059),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Text(
                              'LIVE REEL',
                              style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      reel['title']!,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0A192F),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Full Interactive Gallery Page Component
class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  String _selectedCategory = 'ALL';

  @override
  void initState() {
    super.initState();
    GalleryDataStore.instance.addListener(_onStoreChanged);
  }

  @override
  void dispose() {
    GalleryDataStore.instance.removeListener(_onStoreChanged);
    super.dispose();
  }

  void _onStoreChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;
    final List<String> categories = [
      'ALL',
      'BIRTHDAY',
      'ANNIVERSARY',
      'WEDDINGS',
      'HALDI / MEHNDI',
      'STAGE DECOR',
      'CATERING'
    ];

    final allItems = GalleryDataStore.instance.items;
    final filteredItems = _selectedCategory == 'ALL'
        ? allItems
        : allItems.where((item) => item.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        title: Image.asset(
          'assets/images/logo.png',
          height: 50,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            'COUSIN CREWS GALLERY',
            style: GoogleFonts.playfairDisplay(
              color: const Color(0xFF0A192F),
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF0A192F)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 60,
          horizontal: isDesktop ? 80 : 20,
        ),
        child: Column(
          children: [
            Text(
              'Our Event Portfolio',
              style: GoogleFonts.playfairDisplay(
                fontSize: isDesktop ? 48 : 32,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0A192F),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Explore Birthdays, Anniversaries, Weddings & Custom Theme Setups in Gujarat',
              style: GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Category Filters
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(
                    cat,
                    style: GoogleFonts.montserrat(
                      color: isSelected ? Colors.white : const Color(0xFF0A192F),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 1,
                    ),
                  ),
                  selected: isSelected,
                  selectedColor: const Color(0xFFC5A059),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Color(0xFFC5A059), width: 1),
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _selectedCategory = cat);
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 50),

            filteredItems.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Text(
                      'No media added yet in this category.',
                      style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[500]),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isDesktop ? 3 : 1,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 4 / 3.5,
                    ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return _GalleryPhotoCard(
                        item: item,
                        onTap: () => _openPhotoLightbox(context, item),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void _openPhotoLightbox(BuildContext context, GalleryItemModel item) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: item.isVideo
                    ? AutoPlayVideoWidget(videoUrl: item.imageUrl)
                    : item.imageUrl.startsWith('http') ||
                            item.imageUrl.startsWith('blob:') ||
                            item.imageUrl.startsWith('data:')
                        ? Image.network(item.imageUrl, height: 400, width: double.infinity, fit: BoxFit.cover)
                        : Image.asset(item.imageUrl, height: 400, width: double.infinity, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0A192F),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC5A059).withAlpha(40),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      item.category,
                      style: GoogleFonts.montserrat(
                        color: const Color(0xFF4A3728),
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                item.description,
                style: GoogleFonts.montserrat(fontSize: 15, color: Colors.grey[700], height: 1.6),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0A192F),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GalleryPhotoCard extends StatefulWidget {
  final GalleryItemModel item;
  final VoidCallback onTap;

  const _GalleryPhotoCard({required this.item, required this.onTap});

  @override
  State<_GalleryPhotoCard> createState() => _GalleryPhotoCardState();
}

class _GalleryPhotoCardState extends State<_GalleryPhotoCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(_hovering ? 25 : 8),
                blurRadius: _hovering ? 25 : 10,
                offset: const Offset(0, 10),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: AnimatedScale(
                          scale: _hovering ? 1.05 : 1.0,
                          duration: const Duration(milliseconds: 300),
                          child: widget.item.isVideo
                              ? AutoPlayVideoWidget(videoUrl: widget.item.imageUrl)
                              : widget.item.imageUrl.startsWith('http') ||
                                      widget.item.imageUrl.startsWith('blob:') ||
                                      widget.item.imageUrl.startsWith('data:')
                                  ? Image.network(
                                      widget.item.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      widget.item.imageUrl,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                        ),
                      ),
                      if (widget.item.isVideo)
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.black.withAlpha(160),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.play_circle_fill, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'VIDEO REEL',
                                  style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.item.title,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0A192F),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.item.isVideo ? 'Auto-playing Video Reel' : 'Click to view details & photo',
                        style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Protected Admin Portal Page Component
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool _isLoggedIn = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _loginError = '';

  // Form Controllers for Adding/Editing Photo or Video
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  String _selectedCategory = 'BIRTHDAY';
  bool _isVideo = false;

  void _handleLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.toLowerCase() == 'dp350230@gmail.com' && password == '2021') {
      setState(() {
        _isLoggedIn = true;
        _loginError = '';
      });
    } else {
      setState(() {
        _loginError = 'Invalid Admin Email or Password!';
      });
    }
  }

  void _triggerDirectFileUpload() {
    if (kIsWeb) {
      final uploadInput = html.FileUploadInputElement();
      uploadInput.accept = _isVideo ? 'video/mp4,video/*' : 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) {
        final files = uploadInput.files;
        if (files != null && files.isNotEmpty) {
          final file = files[0];
          final reader = html.FileReader();
          reader.readAsDataUrl(file);
          reader.onLoadEnd.listen((e) {
            final resultUrl = reader.result as String;
            setState(() {
              _urlController.text = resultUrl; // Permanent Base64 Data URL!
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected & Saved File: ${file.name}')),
            );
          });
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter asset path or URL in non-web mode')),
      );
    }
  }

  void _handleAddNewPhoto() {
    if (_titleController.text.isEmpty || _urlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a photo/video file or enter URL')),
      );
      return;
    }

    final newItem = GalleryItemModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      category: _selectedCategory,
      description: _descController.text.trim().isEmpty
          ? 'Special $_selectedCategory setup by Cousin Crews.'
          : _descController.text.trim(),
      imageUrl: _urlController.text.trim(),
      isVideo: _isVideo,
    );

    GalleryDataStore.instance.addItem(newItem);

    _titleController.clear();
    _descController.clear();
    _urlController.clear();
    setState(() => _isVideo = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('New ${_isVideo ? "Video" : "Photo"} Added & Permanently Saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A192F),
      appBar: AppBar(
        title: Text(
          'COUSIN CREWS ADMIN PORTAL',
          style: GoogleFonts.playfairDisplay(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0A192F),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: _isLoggedIn
            ? [
                TextButton.icon(
                  onPressed: () => setState(() => _isLoggedIn = false),
                  icon: const Icon(Icons.logout, color: Color(0xFFC5A059)),
                  label: const Text('LOGOUT', style: TextStyle(color: Color(0xFFC5A059))),
                )
              ]
            : null,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(25),
          child: _isLoggedIn ? _buildAdminDashboard() : _buildLoginForm(),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 450),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admin Login',
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0A192F),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Enter your admin credentials to manage gallery photos & videos',
            style: GoogleFonts.montserrat(color: Colors.grey[600], fontSize: 13),
          ),
          const SizedBox(height: 30),
          Text('EMAIL ADDRESS', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: 8),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText: 'dp350230@Gmail.com',
              filled: true,
              fillColor: const Color(0xFFFAF9F5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 20),
          Text('PASSWORD', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: '••••',
              filled: true,
              fillColor: const Color(0xFFFAF9F5),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
            ),
          ),
          if (_loginError.isNotEmpty) ...[
            const SizedBox(height: 15),
            Text(_loginError, style: const TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.bold)),
          ],
          const SizedBox(height: 35),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A192F),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('LOGIN TO ADMIN PANEL', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminDashboard() {
    final items = GalleryDataStore.instance.items;

    return Container(
      constraints: const BoxConstraints(maxWidth: 1000),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Gallery Management',
                style: GoogleFonts.playfairDisplay(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF0A192F)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC5A059).withAlpha(40),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('Admin Active', style: GoogleFonts.montserrat(color: const Color(0xFF4A3728), fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(),
          const SizedBox(height: 30),

          Text('Add New Event Photo or Auto-Play Video', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title (e.g. Royal Entrance)', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()),
                  items: [
                    'BIRTHDAY',
                    'ANNIVERSARY',
                    'WEDDINGS',
                    'HALDI / MEHNDI',
                    'STAGE DECOR',
                    'CATERING'
                  ].map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (val) => setState(() => _selectedCategory = val!),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          InkWell(
            onTap: _triggerDirectFileUpload,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFFAF9F5),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFC5A059)),
              ),
              child: Row(
                children: [
                  Icon(_urlController.text.isNotEmpty ? Icons.check_circle : Icons.upload_file,
                      color: _urlController.text.isNotEmpty ? Colors.green : const Color(0xFFC5A059)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      _urlController.text.isNotEmpty
                          ? 'Media Selected & Ready to Save!'
                          : 'CHOOSE PHOTO OR VIDEO FILE FROM COMPUTER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _urlController.text.isNotEmpty ? Colors.green : const Color(0xFF0A192F),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 15),
          Row(
            children: [
              Checkbox(
                value: _isVideo,
                onChanged: (val) => setState(() => _isVideo = val ?? false),
              ),
              const Text('This is an Auto-Playing MP4 Video Reel', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          TextField(
            controller: _descController,
            maxLines: 2,
            decoration: const InputDecoration(labelText: 'Description / Details', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _handleAddNewPhoto,
            icon: Icon(_isVideo ? Icons.video_call : Icons.add_a_photo),
            label: Text(_isVideo ? 'ADD AUTO-PLAY VIDEO TO GALLERY' : 'ADD PHOTO TO GALLERY'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC5A059),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            ),
          ),

          const SizedBox(height: 50),
          const Divider(),
          const SizedBox(height: 30),

          Text('Existing Media Items (${items.length})', style: GoogleFonts.playfairDisplay(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 60,
                      height: 60,
                      color: Colors.black12,
                      child: item.isVideo
                          ? const Icon(Icons.play_circle_fill, color: Color(0xFFC5A059), size: 30)
                          : item.imageUrl.startsWith('http') || item.imageUrl.startsWith('blob:') || item.imageUrl.startsWith('data:')
                              ? Image.network(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover)
                              : Image.asset(item.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
                    ),
                  ),
                  title: Row(
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (item.isVideo) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.blue.withAlpha(40), borderRadius: BorderRadius.circular(4)),
                          child: const Text('VIDEO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
                        )
                      ],
                    ],
                  ),
                  subtitle: Text('${item.category} • ${item.description}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFFC5A059)),
                        onPressed: () => _openEditPhotoDialog(item),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          GalleryDataStore.instance.removeItem(item.id);
                          setState(() {});
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Item Removed')),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _openEditPhotoDialog(GalleryItemModel item) {
    final titleEdit = TextEditingController(text: item.title);
    final descEdit = TextEditingController(text: item.description);
    final urlEdit = TextEditingController(text: item.imageUrl);
    String catEdit = item.category;
    bool isVideoEdit = item.isVideo;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Edit Media Details', style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleEdit,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: catEdit,
                  decoration: const InputDecoration(labelText: 'Category'),
                  items: [
                    'BIRTHDAY',
                    'ANNIVERSARY',
                    'WEDDINGS',
                    'HALDI / MEHNDI',
                    'STAGE DECOR',
                    'CATERING'
                  ].map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (val) => catEdit = val!,
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    if (kIsWeb) {
                      final uploadInput = html.FileUploadInputElement();
                      uploadInput.accept = isVideoEdit ? 'video/mp4,video/*' : 'image/*';
                      uploadInput.click();

                      uploadInput.onChange.listen((e) {
                        final files = uploadInput.files;
                        if (files != null && files.isNotEmpty) {
                          final file = files[0];
                          final reader = html.FileReader();
                          reader.readAsDataUrl(file);
                          reader.onLoadEnd.listen((e) {
                            final resultUrl = reader.result as String;
                            setDialogState(() {
                              urlEdit.text = resultUrl;
                            });
                          });
                        }
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAF9F5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFC5A059)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.upload_file, color: Color(0xFFC5A059)),
                        SizedBox(width: 10),
                        Expanded(child: Text('CLICK TO CHOOSE NEW FILE FROM COMPUTER', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Checkbox(
                      value: isVideoEdit,
                      onChanged: (val) => setDialogState(() => isVideoEdit = val ?? false),
                    ),
                    const Text('Auto-Playing MP4 Video Reel', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descEdit,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updated = GalleryItemModel(
                  id: item.id,
                  title: titleEdit.text.trim(),
                  category: catEdit,
                  description: descEdit.text.trim(),
                  imageUrl: urlEdit.text.trim(),
                  isVideo: isVideoEdit,
                );
                GalleryDataStore.instance.updateItem(updated);
                Navigator.pop(context);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Item Updated Successfully!')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A192F),
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Animations and Components

class _ShimmerGoldLine extends StatefulWidget {
  final Color color;
  const _ShimmerGoldLine({required this.color});

  @override
  State<_ShimmerGoldLine> createState() => _ShimmerGoldLineState();
}

class _ShimmerGoldLineState extends State<_ShimmerGoldLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(
        height: 3,
        width: 30 + (25 * _controller.value),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _AnimatedBookButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _AnimatedBookButton({required this.onPressed});

  @override
  State<_AnimatedBookButton> createState() => _AnimatedBookButtonState();
}

class _AnimatedBookButtonState extends State<_AnimatedBookButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.04).animate(_controller),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0A192F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        ),
        child: const Text('BOOK AN EVENT', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
      ),
    );
  }
}

class _FadeSlideEntrance extends StatefulWidget {
  final Widget child;
  final int delayMs;

  const _FadeSlideEntrance({required this.child, this.delayMs = 0});

  @override
  State<_FadeSlideEntrance> createState() => _FadeSlideEntranceState();
}

class _FadeSlideEntranceState extends State<_FadeSlideEntrance> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.delayMs), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

class _CountingStatCard extends StatefulWidget {
  final int targetValue;
  final String label;
  final String suffix;

  const _CountingStatCard({required this.targetValue, required this.label, required this.suffix});

  @override
  State<_CountingStatCard> createState() => _CountingStatCardState();
}

class _CountingStatCardState extends State<_CountingStatCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _anim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _anim = IntTween(begin: 0, end: widget.targetValue).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _anim,
          builder: (context, child) => Text(
            '${_anim.value}${widget.suffix}',
            style: GoogleFonts.playfairDisplay(
              fontSize: 52,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0A192F),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            color: Colors.grey[500],
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _InteractiveProjectCard extends StatefulWidget {
  final bool isDesktop;
  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final bool imgLeft;
  final VoidCallback onDetailsPressed;

  const _InteractiveProjectCard({
    required this.isDesktop,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.imgLeft,
    required this.onDetailsPressed,
  });

  @override
  State<_InteractiveProjectCard> createState() => _InteractiveProjectCardState();
}

class _InteractiveProjectCardState extends State<_InteractiveProjectCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final textColumn = Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(widget.isDesktop ? 50 : 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.subtitle.toUpperCase(),
              style: GoogleFonts.montserrat(
                color: const Color(0xFFC5A059),
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 3,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0A192F),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.description,
              style: GoogleFonts.montserrat(fontSize: 16, color: Colors.grey[700], height: 1.8),
            ),
            const SizedBox(height: 35),
            OutlinedButton(
              onPressed: widget.onDetailsPressed,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
                side: const BorderSide(color: Color(0xFFC5A059), width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('EXPLORE DETAILS', style: TextStyle(color: Color(0xFF0A192F), fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12)),
            ),
          ],
        ),
      ),
    );

    final imageWidget = Expanded(
      flex: 4,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: AnimatedScale(
          scale: _hovering ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: AspectRatio(
              aspectRatio: 16 / 11,
              child: Image.network(widget.imageUrl, fit: BoxFit.cover),
            ),
          ),
        ),
      ),
    );

    return widget.isDesktop
        ? Row(children: widget.imgLeft ? [imageWidget, textColumn] : [textColumn, imageWidget])
        : Column(children: [imageWidget, textColumn]);
  }
}

class _HoverReviewCard extends StatefulWidget {
  final String name;
  final String review;

  const _HoverReviewCard({required this.name, required this.review});

  @override
  State<_HoverReviewCard> createState() => _HoverReviewCardState();
}

class _HoverReviewCardState extends State<_HoverReviewCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 400,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.all(45),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF9F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _hover ? const Color(0xFFC5A059) : Colors.transparent,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(_hover ? 20 : 5),
              blurRadius: _hover ? 30 : 15,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: List.generate(5, (i) => const Icon(Icons.star, color: Color(0xFFC5A059), size: 20))),
            const SizedBox(height: 25),
            Text(
              widget.review,
              style: GoogleFonts.montserrat(fontSize: 16, height: 1.8, fontStyle: FontStyle.italic, color: Colors.black87),
            ),
            const SizedBox(height: 35),
            Text(
              '- ${widget.name}',
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: const Color(0xFF0A192F), letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _HoverScaleButton extends StatefulWidget {
  final String text;
  final Color bgColor;
  final Color textColor;
  final Color? borderColor;
  final VoidCallback onPressed;

  const _HoverScaleButton({
    required this.text,
    required this.bgColor,
    required this.textColor,
    this.borderColor,
    required this.onPressed,
  });

  @override
  State<_HoverScaleButton> createState() => _HoverScaleButtonState();
}

class _HoverScaleButtonState extends State<_HoverScaleButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedScale(
        scale: _hover ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.bgColor,
            foregroundColor: widget.textColor,
            side: widget.borderColor != null ? BorderSide(color: widget.borderColor!, width: 1.5) : null,
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 22),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: _hover ? 6 : 0,
          ),
          child: Text(
            widget.text,
            style: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 12),
          ),
        ),
      ),
    );
  }
}

class _PulsingWhatsAppButton extends StatefulWidget {
  final VoidCallback onPressed;
  const _PulsingWhatsAppButton({required this.onPressed});

  @override
  State<_PulsingWhatsAppButton> createState() => _PulsingWhatsAppButtonState();
}

class _PulsingWhatsAppButtonState extends State<_PulsingWhatsAppButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.08).animate(_controller),
      child: FloatingActionButton.extended(
        onPressed: widget.onPressed,
        backgroundColor: const Color(0xFF25D366),
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text('Direct Enquire', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _AnimatedWelcomeOverlay extends StatelessWidget {
  final bool isDesktop;
  const _AnimatedWelcomeOverlay({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A192F),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO',
              style: GoogleFonts.montserrat(
                color: const Color(0xFFC5A059),
                letterSpacing: 15,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 25),
            Text(
              'COUSIN CREWS',
              style: GoogleFonts.playfairDisplay(
                color: Colors.white,
                fontSize: isDesktop ? 65 : 38,
                fontWeight: FontWeight.w900,
                letterSpacing: 5,
              ),
            ),
            const SizedBox(height: 35),
            _ShimmerGoldLine(color: const Color(0xFFC5A059)),
          ],
        ),
      ),
    );
  }
}
