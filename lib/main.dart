import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CousinCrewApp());
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
          surface: const Color(0xFFF8F9FA), // Soft White
        ),
        textTheme: GoogleFonts.playfairDisplayTextTheme().copyWith(
          bodyMedium: GoogleFonts.montserrat(),
        ),
      ),
      home: const HomePage(),
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
  final Color surfaceColor = const Color(0xFFF8F9FA);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedService = 'Full Event Planning';

  // Welcome Animation
  bool _showWelcome = true;
  bool _contentVisible = false;

  @override
  void initState() {
    super.initState();
    
    // Fast Welcome Sequence
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() => _contentVisible = true);
      }
    });

    Future.delayed(const Duration(milliseconds: 1800), () {
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
      curve: Curves.easeInOutQuart,
    );
  }

  void _launchWhatsApp() {
    String message = "Hello Cousin Crews! I would like to enquire about $_selectedService.\nName: ${_nameController.text}\nPhone: ${_phoneController.text}";
    print("Launching WhatsApp to $_whatsappNumber with message: $message");
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: surfaceColor,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _launchWhatsApp,
        backgroundColor: const Color(0xFF25D366),
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text('Direct Enquire', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          // Main Website Content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                backgroundColor: surfaceColor.withAlpha(245),
                elevation: 0,
                toolbarHeight: 90,
                title: InkWell(
                  onTap: () => _scrollToSection(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'COUSIN CREWS',
                        style: GoogleFonts.playfairDisplay(
                          color: primaryColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          letterSpacing: 2,
                        ),
                      ),
                      Container(height: 3, width: 45, color: secondaryColor),
                    ],
                  ),
                ),
                actions: isDesktop ? [
                  _navButton('HOME', 0),
                  _navButton('SERVICES', 800),
                  _navButton('PORTFOLIO', 2400),
                  _navButton('REVIEWS', 3800),
                  _navButton('CONTACT', 4600),
                  const SizedBox(width: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () => _scrollToSection(4600),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                      ),
                      child: const Text('BOOK AN EVENT', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ] : null,
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  _buildHeroSection(isDesktop),
                  _buildStatsSection(),
                  _buildProjectSection(isDesktop),
                  _buildReviewsSection(),
                  _buildBookingSection(isDesktop),
                  _buildFooter(),
                ]),
              ),
            ],
          ),

          // Smooth Welcome Screen
          if (_showWelcome)
            TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 800),
              tween: Tween(begin: 1.0, end: _contentVisible ? 1.0 : 1.0),
              builder: (context, value, child) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 600),
                  opacity: _showWelcome ? 1.0 : 0.0,
                  child: Container(
                    color: primaryColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _AnimatedText(
                            text: 'WELCOME TO',
                            style: GoogleFonts.montserrat(
                              color: secondaryColor,
                              letterSpacing: 15,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            delay: 200,
                          ),
                          const SizedBox(height: 30),
                          _AnimatedText(
                            text: 'COUSIN CREWS',
                            style: GoogleFonts.playfairDisplay(
                              color: Colors.white,
                              fontSize: isDesktop ? 70 : 40,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 5,
                            ),
                            delay: 500,
                          ),
                          const SizedBox(height: 40),
                          Container(height: 1, width: 100, color: secondaryColor),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _navButton(String title, double offset) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: () => _scrollToSection(offset),
        child: Text(
          title,
          style: TextStyle(color: primaryColor, fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 2),
        ),
      ),
    );
  }

  Widget _buildHeroSection(bool isDesktop) {
    return Container(
      height: isDesktop ? 800 : 600,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1519225421980-715cb0215aed?auto=format&fit=crop&w=1950&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [primaryColor.withAlpha(240), primaryColor.withAlpha(100), Colors.transparent],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EXCEPTIONAL EVENT SPECIALISTS',
                  style: TextStyle(color: secondaryColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 8),
                ),
                const SizedBox(height: 30),
                Text(
                  'Crafting\nTimeless\nCelebrations',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: isDesktop ? 110 : 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 40),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 650),
                  child: Text(
                    'We specialize in transforming your grandest visions into legendary realities. Based in Gujarat, serving dreams worldwide with unmatched elegance.',
                    style: GoogleFonts.montserrat(fontSize: 18, color: Colors.white.withAlpha(200), height: 1.8),
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () => _scrollToSection(4600),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: secondaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                    shape: const RoundedRectangleBorder(),
                  ),
                  child: const Text('EXPLORE PACKAGES', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _statItem('500+', 'EVENTS'),
          _statItem('150+', 'WEDDINGS'),
          _statItem('15+', 'YEARS EXP'),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.playfairDisplay(fontSize: 56, fontWeight: FontWeight.bold, color: primaryColor)),
        const SizedBox(height: 10),
        Text(label, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[500], letterSpacing: 4, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildProjectSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 150, horizontal: isDesktop ? 100 : 20),
      color: surfaceColor,
      child: Column(
        children: [
          Text('Signature Collections', style: GoogleFonts.playfairDisplay(fontSize: 48, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 20),
          Container(height: 4, width: 80, color: secondaryColor),
          const SizedBox(height: 100),
          _detailedProjectRow(
            isDesktop,
            true,
            'Full Event Planning',
            'Luxury, start-to-finish planning where every detail is managed for you. We create a comprehensive plan including venues, stylists, cinematic teams, and more. On your wedding day, we oversee all behind-the-scenes details.',
            'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
          ),
          _detailedProjectRow(
            isDesktop,
            false,
            'Partial Event Planning',
            'Expert guidance with hands-on involvement. We begin with a detailed session guiding you through venue choices and vendor options. We handle schedules and timelines so you can enjoy the planning process.',
            'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=800&q=80',
          ),
          _detailedProjectRow(
            isDesktop,
            true,
            'Event Management',
            'Ensure your wedding day runs smoothly with expert coordination. From initial consultation to understanding your needs, we create a detailed timeline and manage all vendors on-site seamlessly.',
            'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=800&q=80',
          ),
        ],
      ),
    );
  }

  Widget _detailedProjectRow(bool isDesktop, bool imgLeft, String title, String desc, String url) {
    final text = Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 60 : 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: GoogleFonts.playfairDisplay(fontSize: 42, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 30),
            Text(desc, style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey[700], height: 1.8)),
            const SizedBox(height: 50),
            _hoverButton('VIEW DETAILS'),
          ],
        ),
      ),
    );

    final img = Expanded(
      flex: 4,
      child: AspectRatio(
        aspectRatio: 4/3,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(20), blurRadius: 40, offset: const Offset(0, 20))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network(url, fit: BoxFit.cover),
          ),
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: isDesktop
          ? Row(children: imgLeft ? [img, text] : [text, img])
          : Column(children: [img, text]),
    );
  }

  Widget _hoverButton(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor, width: 1.5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          hoverColor: secondaryColor.withAlpha(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
            child: Text(text, style: TextStyle(color: primaryColor, letterSpacing: 3, fontWeight: FontWeight.w800, fontSize: 13)),
          ),
        ),
      ),
    );
  }

  Widget _buildBookingSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 180, horizontal: isDesktop ? 100 : 20),
      decoration: BoxDecoration(
        color: primaryColor,
        image: DecorationImage(
          image: const NetworkImage('https://images.unsplash.com/photo-1519167758481-83f550bb49b3?auto=format&fit=crop&w=1950&q=80'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(primaryColor.withAlpha(230), BlendMode.darken),
        ),
      ),
      child: Column(
        children: [
          Text(
            'Begin Your Story With Us',
            style: GoogleFonts.playfairDisplay(fontSize: isDesktop ? 72 : 44, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 100),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Container(
              padding: EdgeInsets.all(isDesktop ? 80 : 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 60)],
              ),
              child: isDesktop 
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildBookingForm()),
                      const SizedBox(width: 100),
                      Expanded(child: _buildBookingInfo()),
                    ],
                  )
                : Column(children: [_buildBookingForm(), const SizedBox(height: 80), _buildBookingInfo()]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _inputLabel('YOUR FULL NAME'),
        _textField('Enter your name...', _nameController),
        _inputLabel('WHATSAPP NUMBER'),
        _textField('+91 63545 04775', _phoneController),
        _inputLabel('EVENT CATEGORY'),
        DropdownButtonFormField<String>(
          value: _selectedService,
          style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 15),
          decoration: const InputDecoration(filled: true, fillColor: Color(0xFFF8F9FA), border: OutlineInputBorder(borderSide: BorderSide.none)),
          items: ['Full Event Planning', 'Partial Planning', 'Event Management', 'Content Creation']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (v) => setState(() => _selectedService = v!),
        ),
        const SizedBox(height: 60),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _launchWhatsApp,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 30),
              shape: const RoundedRectangleBorder(),
              elevation: 0,
            ),
            child: const Text('SEND SECURE INQUIRY', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 4)),
          ),
        ),
      ],
    );
  }

  Widget _buildBookingInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inquiries', style: GoogleFonts.playfairDisplay(fontSize: 36, fontWeight: FontWeight.bold, color: primaryColor)),
        const SizedBox(height: 50),
        _contactRow(Icons.location_on_outlined, 'Ahmedabad, Gujarat, India'),
        _contactRow(Icons.phone_outlined, '+91 63545 04775'),
        _contactRow(Icons.email_outlined, 'hello@cousincrews.com'),
        const SizedBox(height: 60),
        Text('Service Hours', style: GoogleFonts.playfairDisplay(fontSize: 26, fontWeight: FontWeight.bold, color: primaryColor)),
        const SizedBox(height: 25),
        Text('Monday - Sunday: 09:00 AM - 08:00 PM', style: GoogleFonts.montserrat(color: Colors.grey[600], height: 2.0, fontSize: 16)),
      ],
    );
  }

  Widget _contactRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          Icon(icon, color: secondaryColor, size: 28),
          const SizedBox(width: 25),
          Expanded(child: Text(text, style: GoogleFonts.montserrat(color: Colors.grey[800], fontSize: 18, fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _inputLabel(String label) => Padding(
    padding: const EdgeInsets.only(top: 35, bottom: 15),
    child: Text(label, style: GoogleFonts.montserrat(fontWeight: FontWeight.w800, fontSize: 12, letterSpacing: 4, color: Colors.grey[800])),
  );

  Widget _textField(String hint, TextEditingController controller) => TextField(
    controller: controller,
    style: GoogleFonts.montserrat(fontSize: 16),
    decoration: InputDecoration(hintText: hint, filled: true, fillColor: const Color(0xFFF8F9FA), border: const OutlineInputBorder(borderSide: BorderSide.none), contentPadding: const EdgeInsets.all(20)),
  );

  Widget _buildReviewsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 180),
      color: Colors.white,
      child: Column(
        children: [
          Text('Client Experiences', style: GoogleFonts.playfairDisplay(fontSize: 52, fontWeight: FontWeight.bold, color: primaryColor)),
          const SizedBox(height: 100),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _reviewCard('Hardik P.', 'Cousin Crews handled our corporate gala perfectly. Very professional.'),
                _reviewCard('Meera S.', 'The dream wedding I always wanted! The team are magicians.'),
                _reviewCard('Karan J.', 'Attention to detail is unmatched. Highly recommend for any luxury event.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(String name, String text) {
    return Container(
      width: 450,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: surfaceColor, 
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 40, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(5, (i) => Icon(Icons.star, color: secondaryColor, size: 22))),
          const SizedBox(height: 35),
          Text(text, style: GoogleFonts.montserrat(fontSize: 18, height: 2.2, fontStyle: FontStyle.italic, color: Colors.black87)),
          const SizedBox(height: 50),
          Text('- $name', style: GoogleFonts.montserrat(fontWeight: FontWeight.w900, color: primaryColor, letterSpacing: 2, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 80),
      color: primaryColor,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(Icons.facebook),
              _socialIcon(Icons.camera_alt_outlined),
              _socialIcon(Icons.share_outlined),
            ],
          ),
          const SizedBox(height: 80),
          const Divider(color: Colors.white10),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('© 2026 COUSIN CREWS.', style: GoogleFonts.montserrat(color: Colors.white38, fontSize: 12, letterSpacing: 4, fontWeight: FontWeight.w500)),
              Row(
                children: [
                  _footerLink('PRIVACY POLICY'),
                  const SizedBox(width: 50),
                  _footerLink('TERMS OF SERVICE'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text) {
    return Text(text, style: GoogleFonts.montserrat(color: Colors.white24, fontSize: 12, letterSpacing: 3));
  }

  Widget _socialIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Icon(icon, color: Colors.white60, size: 32),
    );
  }
}

class _AnimatedText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int delay;

  const _AnimatedText({required this.text, required this.style, required this.delay});

  @override
  State<_AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<_AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    
    Future.delayed(Duration(milliseconds: widget.delay), () {
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
    return FadeTransition(opacity: _opacity, child: Text(widget.text, style: widget.style));
  }
}

class _AnimatedSection extends StatelessWidget {
  final Widget child;
  const _AnimatedSection({required this.child});

  @override
  Widget build(BuildContext context) {
    // Simplified version to avoid "empty" screen issues
    // Content will fade in smoothly when built
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1000),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
