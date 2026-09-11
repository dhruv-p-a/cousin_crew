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
    
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) setState(() => _contentVisible = true);
    });

    Future.delayed(const Duration(milliseconds: 2200), () {
      if (mounted) setState(() => _showWelcome = false);
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
      duration: const Duration(milliseconds: 1200),
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
      floatingActionButton: _FloatingWhatsApp(onPressed: _launchWhatsApp),
      body: Stack(
        children: [
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
                      _AnimatedLine(color: secondaryColor),
                    ],
                  ),
                ),
                actions: isDesktop ? [
                  _navButton('HOME', 0),
                  _navButton('SERVICES', 900),
                  _navButton('PORTFOLIO', 2600),
                  _navButton('REVIEWS', 4200),
                  _navButton('CONTACT', 5000),
                  const SizedBox(width: 30),
                  _PulseButton(
                    onPressed: () => _scrollToSection(5000),
                    child: const Text('BOOK AN EVENT', style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold)),
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

          if (_showWelcome) _WelcomeScreen(isDesktop: isDesktop),
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
    return _HeroSection(
      isDesktop: isDesktop,
      primaryColor: primaryColor,
      secondaryColor: secondaryColor,
      onExplore: () => _scrollToSection(900),
    );
  }

  Widget _buildStatsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 120),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _StatItem(value: 500, label: 'EVENTS', suffix: '+'),
          _StatItem(value: 150, label: 'WEDDINGS', suffix: '+'),
          _StatItem(value: 15, label: 'YEARS EXP', suffix: '+'),
        ],
      ),
    );
  }

  Widget _buildProjectSection(bool isDesktop) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 150, horizontal: isDesktop ? 100 : 20),
      color: surfaceColor,
      child: Column(
        children: [
          _AnimatedEntrance(
            child: Column(
              children: [
                Text('Signature Collections', style: GoogleFonts.playfairDisplay(fontSize: 48, fontWeight: FontWeight.bold, color: primaryColor)),
                const SizedBox(height: 20),
                Container(height: 4, width: 80, color: secondaryColor),
              ],
            ),
          ),
          const SizedBox(height: 100),
          _DetailedProjectRow(
            isDesktop: isDesktop,
            imgLeft: true,
            title: 'Full Event Planning',
            desc: 'Luxury, start-to-finish planning where every detail is managed for you. We create a comprehensive plan including venues, stylists, cinematic teams, and more.',
            url: 'https://images.unsplash.com/photo-1519741497674-611481863552?auto=format&fit=crop&w=800&q=80',
          ),
          _DetailedProjectRow(
            isDesktop: isDesktop,
            imgLeft: false,
            title: 'Partial Event Planning',
            desc: 'Expert guidance with hands-on involvement. We handle schedules and timelines while you enjoy the planning process with our expert support.',
            url: 'https://images.unsplash.com/photo-1520854221256-17451cc331bf?auto=format&fit=crop&w=800&q=80',
          ),
          _DetailedProjectRow(
            isDesktop: isDesktop,
            imgLeft: true,
            title: 'Event Management',
            desc: 'Ensure your wedding day runs smoothly with expert coordination. We manage all vendors on-site seamlessly and handle the logistics.',
            url: 'https://images.unsplash.com/photo-1511795409834-ef04bbd61622?auto=format&fit=crop&w=800&q=80',
          ),
        ],
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
          _AnimatedEntrance(
            child: Text(
              'Begin Your Story With Us',
              style: GoogleFonts.playfairDisplay(fontSize: isDesktop ? 72 : 44, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
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
          _AnimatedEntrance(
            child: Text('Client Experiences', style: GoogleFonts.playfairDisplay(fontSize: 52, fontWeight: FontWeight.bold, color: primaryColor)),
          ),
          const SizedBox(height: 100),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _ReviewCard(name: 'Hardik P.', text: 'Cousin Crews handled our corporate gala perfectly. Very professional.'),
                _ReviewCard(name: 'Meera S.', text: 'The dream wedding I always wanted! The team are magicians.'),
                _ReviewCard(name: 'Karan J.', text: 'Attention to detail is unmatched. Highly recommend for any luxury event.'),
              ],
            ),
          ),
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
              _SocialIcon(icon: Icons.facebook),
              _SocialIcon(icon: Icons.camera_alt_outlined),
              _SocialIcon(icon: Icons.share_outlined),
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
                  _FooterLink(text: 'PRIVACY POLICY'),
                  const SizedBox(width: 50),
                  _FooterLink(text: 'TERMS OF SERVICE'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Helper Widgets for Better Animations

class _AnimatedLine extends StatefulWidget {
  final Color color;
  const _AnimatedLine({required this.color});
  @override
  State<_AnimatedLine> createState() => _AnimatedLineState();
}

class _AnimatedLineState extends State<_AnimatedLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Container(height: 3, width: 30 + (20 * _controller.value), color: widget.color),
    );
  }
}

class _PulseButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  const _PulseButton({required this.child, required this.onPressed});
  @override
  State<_PulseButton> createState() => _PulseButtonState();
}

class _PulseButtonState extends State<_PulseButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.05).animate(_controller),
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0A192F),
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 25),
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

class _HeroSection extends StatefulWidget {
  final bool isDesktop;
  final Color primaryColor;
  final Color secondaryColor;
  final VoidCallback onExplore;
  const _HeroSection({required this.isDesktop, required this.primaryColor, required this.secondaryColor, required this.onExplore});
  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..forward();
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isDesktop ? 800 : 600,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isDesktop ? 60 : 20,
        vertical: 20,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40), // Rounded corners like the image
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) => Transform.scale(
                scale: 1.0 + (0.1 * _controller.value),
                child: Image.network(
                  'https://images.unsplash.com/photo-1519225421980-715cb0215aed?auto=format&fit=crop&w=1950&q=80',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.white.withAlpha(220),
                      Colors.white.withAlpha(100),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.isDesktop ? 80 : 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _AnimatedEntrance(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Events That\n',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: widget.isDesktop ? 90 : 50,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF4A3728), // Dark brown
                              height: 1.1,
                            ),
                          ),
                          TextSpan(
                            text: 'Define You',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: widget.isDesktop ? 95 : 55,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: const Color(0xFF8B4513), // Stylish italic color
                              height: 1.1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _AnimatedEntrance(
                    delay: 400,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: Text(
                        'Premium Wedding Planning, Custom Decor & Luxury Management tailored beautifully for your story.',
                        style: GoogleFonts.montserrat(
                          fontSize: 18,
                          color: Colors.black87,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  _AnimatedEntrance(
                    delay: 600,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: widget.onExplore,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4A3728),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                          child: const Text('Book Event', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(width: 20),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                            side: const BorderSide(color: Color(0xFF4A3728)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                          child: const Text('View Gallery', style: TextStyle(color: Color(0xFF4A3728), fontWeight: FontWeight.bold)),
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
}

class _StatItem extends StatefulWidget {
  final int value;
  final String label;
  final String suffix;
  const _StatItem({required this.value, required this.label, required this.suffix});
  @override
  State<_StatItem> createState() => _StatItemState();
}

class _StatItemState extends State<_StatItem> with SingleTickerProviderStateMixin {
  late Animation<int> _animation;
  late AnimationController _controller;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = IntTween(begin: 0, end: widget.value).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));
  }

  @override
  Widget build(BuildContext context) {
    return _AnimatedEntrance(
      onVisible: () { if (!_started) { _controller.forward(); _started = true; } },
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Text('${_animation.value}${widget.suffix}', style: GoogleFonts.playfairDisplay(fontSize: 56, fontWeight: FontWeight.bold, color: const Color(0xFF0A192F))),
          ),
          const SizedBox(height: 10),
          Text(widget.label, style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[500], letterSpacing: 4, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _DetailedProjectRow extends StatelessWidget {
  final bool isDesktop;
  final bool imgLeft;
  final String title;
  final String desc;
  final String url;
  const _DetailedProjectRow({required this.isDesktop, required this.imgLeft, required this.title, required this.desc, required this.url});

  @override
  Widget build(BuildContext context) {
    final text = Expanded(
      flex: 3,
      child: Padding(
        padding: EdgeInsets.all(isDesktop ? 60 : 30),
        child: _AnimatedEntrance(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: GoogleFonts.playfairDisplay(fontSize: 42, fontWeight: FontWeight.bold, color: const Color(0xFF0A192F))),
              const SizedBox(height: 30),
              Text(desc, style: GoogleFonts.montserrat(fontSize: 18, color: Colors.grey[700], height: 1.8)),
              const SizedBox(height: 50),
              _HoverButton(text: 'VIEW DETAILS'),
            ],
          ),
        ),
      ),
    );

    final img = Expanded(
      flex: 4,
      child: _AnimatedEntrance(
        delay: 200,
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
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: isDesktop
          ? Row(children: imgLeft ? [img, text] : [text, img])
          : Column(children: [img, text]),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String text;
  const _HoverButton({required this.text});
  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFC5A059), width: 1.5),
          color: _hover ? const Color(0xFFC5A059) : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 22),
          child: Text(widget.text, style: TextStyle(color: _hover ? Colors.white : const Color(0xFF0A192F), letterSpacing: 3, fontWeight: FontWeight.w800, fontSize: 13)),
        ),
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final String name;
  final String text;
  const _ReviewCard({required this.name, required this.text});
  @override
  Widget build(BuildContext context) {
    return _AnimatedEntrance(
      child: Container(
        width: 450,
        margin: const EdgeInsets.symmetric(horizontal: 40),
        padding: const EdgeInsets.all(60),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA), 
          boxShadow: [BoxShadow(color: Colors.black.withAlpha(5), blurRadius: 40, offset: const Offset(0, 10))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: List.generate(5, (i) => const Icon(Icons.star, color: Color(0xFFC5A059), size: 22))),
            const SizedBox(height: 35),
            Text(text, style: GoogleFonts.montserrat(fontSize: 18, height: 2.2, fontStyle: FontStyle.italic, color: Colors.black87)),
            const SizedBox(height: 50),
            Text('- $name', style: GoogleFonts.montserrat(fontWeight: FontWeight.w900, color: const Color(0xFF0A192F), letterSpacing: 2, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: GoogleFonts.montserrat(color: Colors.white24, fontSize: 12, letterSpacing: 3));
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  const _SocialIcon({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Icon(icon, color: Colors.white60, size: 32),
    );
  }
}

class _AnimatedEntrance extends StatefulWidget {
  final Widget child;
  final int delay;
  final VoidCallback? onVisible;
  const _AnimatedEntrance({required this.child, this.delay = 0, this.onVisible});
  @override
  State<_AnimatedEntrance> createState() => _AnimatedEntranceState();
}

class _AnimatedEntranceState extends State<_AnimatedEntrance> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted && !_isVisible) {
            final RenderBox box = context.findRenderObject() as RenderBox;
            final offset = box.localToGlobal(Offset.zero);
            if (offset.dy < MediaQuery.of(context).size.height * 0.9) {
              Future.delayed(Duration(milliseconds: widget.delay), () {
                if (mounted) {
                  setState(() => _isVisible = true);
                  widget.onVisible?.call();
                }
              });
            }
          }
        });
        return AnimatedOpacity(
          opacity: _isVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(0, _isVisible ? 0 : 30, 0),
            child: widget.child,
          ),
        );
      },
    );
  }
}

class _WelcomeScreen extends StatelessWidget {
  final bool isDesktop;
  const _WelcomeScreen({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A192F),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AnimatedWelcomeText(
              text: 'WELCOME TO',
              style: GoogleFonts.montserrat(color: const Color(0xFFC5A059), letterSpacing: 15, fontSize: 16, fontWeight: FontWeight.w300),
              delay: 200,
            ),
            const SizedBox(height: 30),
            _AnimatedWelcomeText(
              text: 'COUSIN CREWS',
              style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: isDesktop ? 70 : 40, fontWeight: FontWeight.w900, letterSpacing: 5),
              delay: 600,
            ),
            const SizedBox(height: 40),
            _AnimatedLine(color: const Color(0xFFC5A059)),
          ],
        ),
      ),
    );
  }
}

class _AnimatedWelcomeText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final int delay;
  const _AnimatedWelcomeText({required this.text, required this.style, required this.delay});
  @override
  State<_AnimatedWelcomeText> createState() => _AnimatedWelcomeTextState();
}

class _AnimatedWelcomeTextState extends State<_AnimatedWelcomeText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    Future.delayed(Duration(milliseconds: widget.delay), () { if (mounted) _controller.forward(); });
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _opacity, child: Text(widget.text, style: widget.style));
  }
}

class _FloatingWhatsApp extends StatefulWidget {
  final VoidCallback onPressed;
  const _FloatingWhatsApp({required this.onPressed});
  @override
  State<_FloatingWhatsApp> createState() => _FloatingWhatsAppState();
}

class _FloatingWhatsAppState extends State<_FloatingWhatsApp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }
  @override
  void dispose() { _controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 1.1).animate(_controller),
      child: FloatingActionButton.extended(
        onPressed: widget.onPressed,
        backgroundColor: const Color(0xFF25D366),
        icon: const Icon(Icons.chat, color: Colors.white),
        label: const Text('Direct Enquire', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _AnimatedText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int delay;
  const _AnimatedText({required this.text, required this.style, required this.delay});

  @override
  Widget build(BuildContext context) {
    return _AnimatedWelcomeText(text: text, style: style, delay: delay);
  }
}
