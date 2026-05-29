// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../Controller/Home/homeController.dart';
import '../Helper/assetConstants.dart';
import '../Helper/colorConstants.dart';
import '../Helper/fontConstants.dart';
import '../Helper/logger.dart';
import '../Helper/toaster.dart';
import '../Model/projectModel.dart';
import '../globalWidgets/responsiveSizeWidget.dart';

// ══════════════════════════════════════════════════════════════════════
//  MAIN VIEW
// ══════════════════════════════════════════════════════════════════════

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final HomeController _hc = Get.put(HomeController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    final Size sz = MediaQuery.of(context).size;
    final bool isMobile = sz.width <= 768;

    return _PremiumBackground(
      child: GetBuilder<HomeController>(builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: _buildGlassAppBar(isMobile, sz, controller, context),
          drawer: isMobile ? _buildDrawer(controller, context) : null,
          floatingActionButton: _WhatsAppFAB(isMobile: isMobile),
          body: LayoutBuilder(builder: (ctx, constraints) {
            final double hPad = constraints.maxWidth < 600
                ? 20
                : constraints.maxWidth < 1200
                    ? 60
                    : 160;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Hero ────────────────────────────────────────
                  _HeroSection(isMobile: isMobile, sz: sz, hPad: hPad),
                  SizedBox(height: sz.height * 0.08),

                  // ── About / WHO I AM ─────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: _AboutSection(
                        isMobile: isMobile, controller: controller),
                  ),
                  SizedBox(height: sz.height * 0.08),

                  // ── BY THE NUMBERS ───────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: _ByTheNumbersSection(
                        isMobile: isMobile, controller: controller),
                  ),
                  SizedBox(height: sz.height * 0.08),

                  // ── Work Experience (Timeline) ───────────────────
                  _ExperienceSection(
                      isMobile: isMobile,
                      hPad: hPad,
                      controller: controller),
                  SizedBox(height: sz.height * 0.08),

                  // ── Skills + Tools (combined chips view) ─────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: _SkillsSection(
                        isMobile: isMobile, controller: controller),
                  ),
                  SizedBox(height: sz.height * 0.08),

                  // ── Projects Carousel ────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: _ProjectsSection(
                        isMobile: isMobile, controller: controller),
                  ),
                  SizedBox(height: sz.height * 0.08),

                  // ── Case Studies ─────────────────────────────────
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: hPad),
                    child: _BlogsSection(
                        isMobile: isMobile, controller: controller),
                  ),
                  SizedBox(height: sz.height * 0.08),

                  // ── Contact ──────────────────────────────────────
                  _ContactSection(
                      isMobile: isMobile, sz: sz, controller: controller),
                ],
              ),
            );
          }),
        );
      }),
    );
  }

  // ── Glass AppBar ────────────────────────────────────────────────────
  PreferredSizeWidget _buildGlassAppBar(
      bool isMobile, Size sz, HomeController controller, BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(isMobile ? 64 : 80),
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              border: Border(
                bottom: BorderSide(
                    color: ColorConstants.borderGlass, width: 0.8),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(children: [
                  // Logo
                  Image.asset(
                    AssetConstants.GiritharDarkLogoImage,
                    height: isMobile ? 36 : 48,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(),
                  // Nav items (desktop) / hamburger (mobile)
                  if (!isMobile)
                    Row(children: [
                      _navItem('About', 0, controller, () {
                        controller.selectedMenuIndex = 0;
                        controller.scrollToSection(controller.aboutKey);
                        controller.update();
                      }),
                      _navItem('Experience', 1, controller, () {
                        controller.selectedMenuIndex = 1;
                        controller.scrollToSection(controller.experienceKey);
                        controller.update();
                      }),
                      _navItem('Skills', 2, controller, () {
                        controller.selectedMenuIndex = 2;
                        controller.scrollToSection(controller.toolsKey);
                        controller.update();
                      }),
                      _navItem('Projects', 3, controller, () {
                        controller.selectedMenuIndex = 3;
                        controller.scrollToSection(controller.projectsKey);
                        controller.update();
                      }),
                      _navItem('Blogs', 4, controller, () {
                        controller.selectedMenuIndex = 4;
                        controller.scrollToSection(controller.blogKey);
                        controller.update();
                      }),
                      _navItem('Contact', 5, controller, () {
                        controller.selectedMenuIndex = 5;
                        controller.scrollToSection(controller.contactKey);
                        controller.update();
                      }),
                    ])
                  else
                    Builder(builder: (ctx) {
                      return IconButton(
                        icon: const Icon(Icons.menu_rounded,
                            color: ColorConstants.accentCyan, size: 28),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => Scaffold.of(ctx).openDrawer(),
                      );
                    }),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(String label, int idx, HomeController controller,
      VoidCallback onTap) {
    final bool selected = controller.selectedMenuIndex == idx;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            label,
            style: TextStyle(
              color: selected
                  ? ColorConstants.accentCyan
                  : ColorConstants.textSecondary,
              fontSize: 15,
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.w500,
              fontFamily: FontConstants.fontFamily,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            height: 2,
            width: selected ? 24 : 0,
            decoration: BoxDecoration(
              color: ColorConstants.accentCyan,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ]),
      ),
    );
  }

  // ── Drawer (Mobile) ─────────────────────────────────────────────────
  Widget _buildDrawer(HomeController controller, BuildContext context) {
    return Drawer(
      backgroundColor: ColorConstants.bgSecondary,
      child: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(AssetConstants.GiritharDarkLogoImage,
                height: 40, fit: BoxFit.contain),
          ),
          const Divider(color: ColorConstants.borderGlass),
          ...[
            ('About', controller.aboutKey),
            ('Experience', controller.experienceKey),
            ('Skills', controller.toolsKey),
            ('Projects', controller.projectsKey),
            ('Blogs', controller.blogKey),
            ('Contact', controller.contactKey),
          ].map((e) => _drawerTile(e.$1, e.$2, context, controller)),
        ]),
      ),
    );
  }

  Widget _drawerTile(
      String title, GlobalKey key, BuildContext context, HomeController hc) {
    return Builder(builder: (ctx) {
      return ListTile(
        title: Text(title,
            style: const TextStyle(
              color: ColorConstants.textPrimary,
              fontSize: 16,
              fontFamily: 'Helvetica',
            )),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            color: ColorConstants.accentCyan, size: 14),
        onTap: () {
          Scaffold.of(ctx).closeDrawer();
          hc.scrollToSection(key);
        },
      );
    });
  }
}

// ══════════════════════════════════════════════════════════════════════
//  ANIMATED PARTICLE BACKGROUND
// ══════════════════════════════════════════════════════════════════════

class _PremiumBackground extends StatefulWidget {
  const _PremiumBackground({required this.child});
  final Widget child;

  @override
  State<_PremiumBackground> createState() => _PremiumBackgroundState();
}

class _PremiumBackgroundState extends State<_PremiumBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    final rng = math.Random(42);
    _particles = List.generate(90, (_) => _Particle(rng));
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(seconds: 30))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF000000), Color(0xFF04060D), Color(0xFF000000)],
          stops: [0, 0.5, 1],
        ),
      ),
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, child) => CustomPaint(
          painter: _ParticlePainter(_ctrl.value, _particles),
          child: child,
        ),
        child: widget.child,
      ),
    );
  }
}

class _Particle {
  final double x, y, radius, vx, vy, opacity;
  final Color color;

  _Particle(math.Random rng)
      : x = rng.nextDouble(),
        y = rng.nextDouble(),
        radius = rng.nextDouble() * 1.2 + 0.3,
        vx = (rng.nextDouble() - 0.5) * 0.012,
        vy = (rng.nextDouble() - 0.5) * 0.012,
        opacity = rng.nextDouble() * 0.55 + 0.15,
        color = [
          const Color(0xFFFFFFFF),
          const Color(0xFFFFFFFF),
          const Color(0xFFFFFFFF),
          const Color(0xFF00D4FF),
          const Color(0xFF7C3AED),
        ][rng.nextInt(5)];
}

class _ParticlePainter extends CustomPainter {
  final double t;
  final List<_Particle> particles;

  _ParticlePainter(this.t, this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    // Pre-compute positions
    final pos = particles.map((p) => Offset(
          ((p.x + p.vx * t * 20) % 1.0) * size.width,
          ((p.y + p.vy * t * 20) % 1.0) * size.height,
        )).toList();

    // Constellation lines between nearby particles
    final linePaint = Paint()..strokeWidth = 0.5;
    final threshold = size.width * 0.12;
    for (int i = 0; i < pos.length; i++) {
      for (int j = i + 1; j < pos.length; j++) {
        final dx = pos[j].dx - pos[i].dx;
        final dy = pos[j].dy - pos[i].dy;
        final dist = math.sqrt(dx * dx + dy * dy);
        if (dist < threshold) {
          linePaint.color = const Color(0xFF00D4FF)
              .withOpacity((1 - dist / threshold) * 0.11);
          canvas.drawLine(pos[i], pos[j], linePaint);
        }
      }
    }

    // Particles
    for (int i = 0; i < particles.length; i++) {
      canvas.drawCircle(pos[i], particles[i].radius,
          Paint()..color = particles[i].color.withOpacity(particles[i].opacity));
    }

    _drawOrb(canvas, size, 0.12, 0.18, const Color(0xFF00D4FF), t);
    _drawOrb(canvas, size, 0.88, 0.72, const Color(0xFF7C3AED), 1 - t);
    _drawOrb(canvas, size, 0.50, 0.50, const Color(0xFF7C3AED), t * 0.5);
  }

  void _drawOrb(Canvas c, Size s, double xf, double yf, Color col, double t) {
    final x = (xf + math.sin(t * math.pi * 2) * 0.04) * s.width;
    final y = (yf + math.cos(t * math.pi * 2) * 0.04) * s.height;
    c.drawCircle(
      Offset(x, y),
      s.width * 0.22,
      Paint()
        ..color = col.withOpacity(0.045)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90),
    );
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.t != t;
}

// ══════════════════════════════════════════════════════════════════════
//  REUSABLE HELPERS
// ══════════════════════════════════════════════════════════════════════

class GradientText extends StatelessWidget {
  const GradientText(this.text,
      {super.key, required this.gradient, this.style});
  final String text;
  final Gradient gradient;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) =>
          gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
}

// Glass card container
Widget _glassCard({
  required Widget child,
  double radius = 20,
  EdgeInsets padding = const EdgeInsets.all(20),
  Color? borderColor,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: borderColor ?? Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: child,
      ),
    ),
  );
}

// Section header — matches video style with ghost section number
Widget _sectionHeader(String sub, String title, bool isMobile,
    {String sectionNum = ''}) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      // Ghost section number backdrop
      if (sectionNum.isNotEmpty)
        Positioned(
          right: -10,
          top: isMobile ? -20 : -30,
          child: Text(
            sectionNum,
            style: TextStyle(
              color: Colors.white.withOpacity(0.04),
              fontSize: isMobile ? 80 : 130,
              fontWeight: FontWeight.w900,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
        ),
      Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        // Sub-label
        Text(
          sub.toUpperCase(),
          style: TextStyle(
            color: ColorConstants.accentCyan,
            fontSize: isMobile ? 11 : 12,
            letterSpacing: 4,
            fontWeight: FontWeight.w700,
            fontFamily: FontConstants.fontFamily,
          ),
        ),
        const SizedBox(height: 12),
        // Main title — large glowing white
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 32 : 52,
            fontWeight: FontWeight.w900,
            fontFamily: FontConstants.fontFamily,
            color: Colors.white,
            height: 1.1,
            shadows: [
              Shadow(
                color: const Color(0xFF00D4FF).withOpacity(0.4),
                blurRadius: 20,
              ),
              Shadow(
                color: Colors.white.withOpacity(0.15),
                blurRadius: 40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Glowing underline
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            gradient: const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withOpacity(0.6),
                blurRadius: 12,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
      ]),
    ],
  );
}

// 3D tilt card — desktop hover effect
class TiltCard3D extends StatefulWidget {
  const TiltCard3D(
      {super.key,
      required this.child,
      this.maxTilt = 0.08,
      this.glowColor});
  final Widget child;
  final double maxTilt;
  final Color? glowColor;

  @override
  State<TiltCard3D> createState() => _TiltCard3DState();
}

class _TiltCard3DState extends State<TiltCard3D> {
  double _rx = 0, _ry = 0;
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (e) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final local = box.globalToLocal(e.position);
        final s = box.size;
        setState(() {
          _rx = (local.dy / s.height - 0.5) * widget.maxTilt;
          _ry = -(local.dx / s.width - 0.5) * widget.maxTilt;
          _hovering = true;
        });
      },
      onExit: (_) => setState(() {
        _rx = 0;
        _ry = 0;
        _hovering = false;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_rx)
          ..rotateY(_ry),
        decoration: _hovering
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: (widget.glowColor ?? ColorConstants.accentCyan)
                        .withOpacity(0.25),
                    blurRadius: 28,
                    spreadRadius: 2,
                  )
                ],
              )
            : null,
        child: widget.child,
      ),
    );
  }
}

// Scroll-triggered entrance animation
class _SectionReveal extends StatefulWidget {
  const _SectionReveal({
    required this.child,
    required this.sectionId,
    this.delayMs = 0,
    this.slideUp = true,
  });
  final Widget child;
  final String sectionId;
  final int delayMs;
  final bool slideUp;

  @override
  State<_SectionReveal> createState() => _SectionRevealState();
}

class _SectionRevealState extends State<_SectionReveal>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 650));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: widget.slideUp ? const Offset(0, 0.12) : const Offset(0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _trigger() {
    if (!_done) {
      _done = true;
      Future.delayed(Duration(milliseconds: widget.delayMs),
          () { if (mounted) _ctrl.forward(); });
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('reveal_${widget.sectionId}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1) _trigger();
      },
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(position: _slide, child: widget.child),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  COUNT-UP ANIMATED STAT
// ══════════════════════════════════════════════════════════════════════

class _CountUpStat extends StatefulWidget {
  const _CountUpStat({
    required this.numVal,
    required this.suffix,
    required this.label,
    required this.isMobile,
    this.accentColor,
  });
  final double numVal;
  final String suffix;
  final String label;
  final bool isMobile;
  final Color? accentColor;

  @override
  State<_CountUpStat> createState() => _CountUpStatState();
}

class _CountUpStatState extends State<_CountUpStat>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600));
    _anim = Tween<double>(begin: 0, end: widget.numVal)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _start() {
    if (!_started) {
      _started = true;
      _ctrl.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('cus_${widget.label}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3) _start();
      },
      child: AnimatedBuilder(
        animation: _anim,
        builder: (_, __) {
          final v = _anim.value;
          final isDecimal = widget.numVal % 1 != 0;
          final display = isDecimal
              ? v.toStringAsFixed(1)
              : v.toInt().toString();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$display${widget.suffix}',
                style: TextStyle(
                  fontSize: widget.isMobile ? 32 : 48,
                  fontWeight: FontWeight.w900,
                  fontFamily: FontConstants.fontFamily,
                  color: widget.accentColor ?? ColorConstants.accentCyan,
                  shadows: [
                    Shadow(
                      color: (widget.accentColor ?? ColorConstants.accentCyan)
                          .withOpacity(0.6),
                      blurRadius: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: widget.isMobile ? 9 : 10,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  3D FLIP CARD
// ══════════════════════════════════════════════════════════════════════

class _FlipCard3D extends StatefulWidget {
  const _FlipCard3D({super.key, required this.front, required this.back});
  final Widget front;
  final Widget back;

  @override
  State<_FlipCard3D> createState() => _FlipCard3DState();
}

class _FlipCard3DState extends State<_FlipCard3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 420));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _ctrl.forward(),
      onExit: (_) => _ctrl.reverse(),
      child: GestureDetector(
        onTap: () => _ctrl.value > 0.5 ? _ctrl.reverse() : _ctrl.forward(),
        child: AnimatedBuilder(
          animation: _anim,
          builder: (_, __) {
            final angle = _anim.value * math.pi;
            final showBack = _anim.value > 0.5;
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateY(angle),
              alignment: Alignment.center,
              child: showBack
                  ? Transform(
                      transform: Matrix4.identity()..rotateY(math.pi),
                      alignment: Alignment.center,
                      child: widget.back,
                    )
                  : widget.front,
            );
          },
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  DARK SECTION CARD  (matches video card style exactly)
// ══════════════════════════════════════════════════════════════════════

Widget _darkSectionCard({
  required String subLabel,
  required String neonTitle,
  required String sectionNum,
  required Widget content,
  bool isMobile = false,
}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(isMobile ? 20 : 32),
    decoration: BoxDecoration(
      color: const Color(0xFF080808),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.07), width: 1),
    ),
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        // Ghost section number — top-right of card
        Positioned(
          top: -10,
          right: 0,
          child: Text(
            sectionNum,
            style: TextStyle(
              color: Colors.white.withOpacity(0.05),
              fontSize: isMobile ? 70 : 110,
              fontWeight: FontWeight.w900,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sub-label
            Text(
              subLabel.toUpperCase(),
              style: TextStyle(
                color: Colors.white.withOpacity(0.28),
                fontSize: 10,
                letterSpacing: 3,
                fontWeight: FontWeight.w600,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
            const SizedBox(height: 14),
            // Neon heading
            Text(
              neonTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 30 : 48,
                fontWeight: FontWeight.w900,
                fontFamily: FontConstants.fontFamily,
                letterSpacing: 1,
                shadows: [
                  Shadow(color: Colors.white.withOpacity(0.9), blurRadius: 6),
                  Shadow(color: Colors.white.withOpacity(0.5), blurRadius: 18),
                  Shadow(
                      color: const Color(0xFFFFAA00).withOpacity(0.25),
                      blurRadius: 35),
                  Shadow(color: Colors.white.withOpacity(0.15), blurRadius: 55),
                ],
              ),
            ),
            const SizedBox(height: 28),
            content,
          ],
        ),
      ],
    ),
  );
}

// ══════════════════════════════════════════════════════════════════════
//  3D PROFILE CARD  (hero right side)
// ══════════════════════════════════════════════════════════════════════

class _SelfIntroAnimation extends StatefulWidget {
  const _SelfIntroAnimation({required this.isMobile});
  final bool isMobile;
  @override
  State<_SelfIntroAnimation> createState() => _3DProfileCardState();
}

class _3DProfileCardState extends State<_SelfIntroAnimation>
    with TickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late AnimationController _glowCtrl;
  late AnimationController _ringCtrl;

  double _tiltX = 0, _tiltY = 0;
  bool _hovered = false;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3200))
      ..repeat(reverse: true);
    _glowCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800))
      ..repeat(reverse: true);
    _ringCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 6000))
      ..repeat();
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _glowCtrl.dispose();
    _ringCtrl.dispose();
    super.dispose();
  }

  void _onHover(Offset local, Size size) {
    final dx = (local.dx / size.width - 0.5) * 2;   // -1 to 1
    final dy = (local.dy / size.height - 0.5) * 2;  // -1 to 1
    setState(() { _tiltX = -dy * 0.18; _tiltY = dx * 0.18; });
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.isMobile;
    final w = m ? 240.0 : 320.0;
    final h = w * 1.25;

    return AnimatedBuilder(
      animation: Listenable.merge([_floatCtrl, _glowCtrl, _ringCtrl]),
      builder: (_, __) {
        final floatY = math.sin(_floatCtrl.value * math.pi) * 10.0;
        final glowOp = 0.22 + _glowCtrl.value * 0.18;

        return Transform.translate(
          offset: Offset(0, floatY),
          child: SizedBox(
            width: w + 40,
            height: h + 40,
            child: Stack(alignment: Alignment.center, children: [
              // ── Rotating outer ring — cyan ────────────────────
              Transform.rotate(
                angle: _ringCtrl.value * math.pi * 2,
                child: Container(
                  width: w + 36,
                  height: h + 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFF00D4FF).withOpacity(0.18),
                      width: 1,
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF00D4FF).withOpacity(0.25),
                        Colors.transparent,
                        const Color(0xFF7C3AED).withOpacity(0.20),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              // ── Counter-rotating inner ring — purple ──────────
              Transform.rotate(
                angle: -_ringCtrl.value * math.pi * 2 * 0.7,
                child: Container(
                  width: w + 18,
                  height: h + 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF7C3AED).withOpacity(0.22),
                      width: 1,
                    ),
                  ),
                ),
              ),

              // ── Glow aura ─────────────────────────────────────
              Container(
                width: w,
                height: h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withOpacity(glowOp),
                      blurRadius: 50,
                      spreadRadius: 4,
                    ),
                    BoxShadow(
                      color: const Color(0xFF7C3AED).withOpacity(glowOp * 0.6),
                      blurRadius: 80,
                      spreadRadius: 8,
                    ),
                  ],
                ),
              ),

              // ── 3D tilt card ──────────────────────────────────
              MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) {
                  setState(() { _hovered = false; _tiltX = 0; _tiltY = 0; });
                },
                child: Listener(
                  onPointerHover: (e) {
                    if (_hovered) _onHover(e.localPosition, Size(w, h));
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 120),
                    width: w,
                    height: h,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(_hovered ? _tiltX : 0)
                      ..rotateY(_hovered ? _tiltY : 0),
                    transformAlignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Stack(children: [
                        // Profile photo
                        Positioned.fill(
                          child: Image.asset(
                            AssetConstants.profileImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  const Color(0xFF00D4FF).withOpacity(
                                      _hovered ? 0.12 : 0.06),
                                  Colors.transparent,
                                  const Color(0xFF7C3AED).withOpacity(
                                      _hovered ? 0.10 : 0.04),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Bottom dark fade
                        Positioned(
                          bottom: 0, left: 0, right: 0,
                          height: h * 0.38,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.75),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Name tag at bottom
                        Positioned(
                          bottom: 18, left: 16, right: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Girithar K',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: m ? 15 : 18,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontConstants.fontFamily,
                                  shadows: const [
                                    Shadow(color: Color(0xFF00D4FF), blurRadius: 10),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Senior Flutter Developer',
                                style: TextStyle(
                                  color: const Color(0xFF00D4FF).withOpacity(0.9),
                                  fontSize: m ? 10 : 11.5,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: FontConstants.fontFamily,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Cyan border
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF00D4FF).withOpacity(
                                    _hovered ? 0.55 : 0.28),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        // Hover shimmer line — top
                        if (_hovered)
                          Positioned(
                            top: 0, left: 0, right: 0,
                            child: Container(
                              height: 1.5,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Colors.transparent,
                                  const Color(0xFF00D4FF).withOpacity(0.7),
                                  Colors.transparent,
                                ]),
                              ),
                            ),
                          ),
                      ]),
                    ),
                  ),
                ),
              ),

              // ── Floating badge — top right ────────────────────-
              // Positioned(
              //   top: 12, right: 0,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF0D1117),
              //       borderRadius: BorderRadius.circular(30),
              //       border: Border.all(
              //         color: const Color(0xFF10B981).withOpacity(0.5), width: 1),
              //       boxShadow: [
              //         BoxShadow(
              //           color: const Color(0xFF10B981).withOpacity(0.3),
              //           blurRadius: 12,
              //         ),
              //       ],
              //     ),
              //     child: Row(mainAxisSize: MainAxisSize.min, children: [
              //       Container(
              //         width: 6, height: 6,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: Color(0xFF10B981),
              //         ),
              //       ),
              //       const SizedBox(width: 6),
              //       Text(
              //         'Open to Works',
              //         style: TextStyle(
              //           color: const Color(0xFF10B981),
              //           fontSize: m ? 9 : 10,
              //           fontWeight: FontWeight.w700,
              //           fontFamily: FontConstants.fontFamily,
              //           letterSpacing: 0.5,
              //         ),
              //       ),
              //     ]),
              //   ),
              // ),

              // ── Experience badge — bottom left ────────────────
              Positioned(
                bottom: 12, left: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1117),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: const Color(0xFF7C3AED).withOpacity(0.5), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF7C3AED).withOpacity(0.3),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Text(
                    '4+ yrs experience',
                    style: TextStyle(
                      color: const Color(0xFF7C3AED).withOpacity(0.95),
                      fontSize: m ? 9 : 10,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstants.fontFamily,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  FLOATING 3D DIAMOND SHAPE
// ══════════════════════════════════════════════════════════════════════

class _FloatingDiamond extends StatefulWidget {
  const _FloatingDiamond({
    super.key,
    required this.size,
    required this.color,
    required this.phaseOffset,
    required this.top,
    required this.left,
  });
  final double size;
  final Color color;
  final double phaseOffset;
  final double top;
  final double left;

  @override
  State<_FloatingDiamond> createState() => _FloatingDiamondState();
}

class _FloatingDiamondState extends State<_FloatingDiamond>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 2800 + (widget.phaseOffset * 900).toInt()))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final float =
            math.sin((_ctrl.value + widget.phaseOffset) * math.pi) * 14;
        final rotate =
            (_ctrl.value + widget.phaseOffset) * math.pi * 0.4;
        return Positioned(
          top: widget.top + float,
          left: widget.left,
          child: Transform.rotate(
            angle: rotate,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: widget.color.withOpacity(0.4), width: 1.5),
                color: widget.color.withOpacity(0.06),
                boxShadow: [
                  BoxShadow(
                      color: widget.color.withOpacity(0.18),
                      blurRadius: 14),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  DRAMATIC 3D PORTRAIT  (matches video reference)
// ══════════════════════════════════════════════════════════════════════

class _Dramatic3DPortrait extends StatefulWidget {
  const _Dramatic3DPortrait({required this.radius});
  final double radius;

  @override
  State<_Dramatic3DPortrait> createState() => _Dramatic3DPortraitState();
}

class _Dramatic3DPortraitState extends State<_Dramatic3DPortrait>
    with TickerProviderStateMixin {
  late AnimationController _ring1;
  late AnimationController _ring2;
  late AnimationController _ring3;
  late AnimationController _pulse;
  late AnimationController _orbit;

  @override
  void initState() {
    super.initState();
    _ring1  = AnimationController(vsync: this, duration: const Duration(seconds: 6))..repeat();
    _ring2  = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
    _ring3  = AnimationController(vsync: this, duration: const Duration(seconds: 14))..repeat();
    _pulse  = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
    _orbit  = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();
  }

  @override
  void dispose() {
    _ring1.dispose(); _ring2.dispose(); _ring3.dispose();
    _pulse.dispose(); _orbit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.radius;
    final total = r * 2 + 100;

    return SizedBox(
      width: total,
      height: total,
      child: Stack(alignment: Alignment.center, children: [

        // ── Pulsing glow aura ──────────────────────────────
        AnimatedBuilder(
          animation: _pulse,
          builder: (_, __) => Container(
            width: total,
            height: total,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF)
                      .withOpacity(0.12 + _pulse.value * 0.1),
                  blurRadius: 70 + _pulse.value * 40,
                  spreadRadius: 10,
                ),
                BoxShadow(
                  color: const Color(0xFF7C3AED)
                      .withOpacity(0.10 + _pulse.value * 0.08),
                  blurRadius: 90,
                  spreadRadius: 20,
                ),
              ],
            ),
          ),
        ),

        // ── 3D ring 1 — tilted on X, cyan ─────────────────
        AnimatedBuilder(
          animation: _ring1,
          builder: (_, __) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(1.1)
              ..rotateZ(_ring1.value * 2 * math.pi),
            alignment: Alignment.center,
            child: Container(
              width: r * 2 + 60,
              height: r * 2 + 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF00D4FF).withOpacity(0.55),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        // ── 3D ring 2 — tilted on Y, purple ───────────────
        AnimatedBuilder(
          animation: _ring2,
          builder: (_, __) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(1.0)
              ..rotateZ(-_ring2.value * 2 * math.pi),
            alignment: Alignment.center,
            child: Container(
              width: r * 2 + 36,
              height: r * 2 + 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF7C3AED).withOpacity(0.45),
                  width: 1.5,
                ),
              ),
            ),
          ),
        ),

        // ── 3D ring 3 — diagonal, gold ─────────────────────
        AnimatedBuilder(
          animation: _ring3,
          builder: (_, __) => Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(0.6)
              ..rotateY(0.8)
              ..rotateZ(_ring3.value * math.pi * 1.5),
            alignment: Alignment.center,
            child: Container(
              width: r * 2 + 16,
              height: r * 2 + 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFF59E0B).withOpacity(0.35),
                  width: 1,
                ),
              ),
            ),
          ),
        ),

        // ── Orbiting dots ──────────────────────────────────
        AnimatedBuilder(
          animation: _orbit,
          builder: (_, __) {
            final angle = _orbit.value * 2 * math.pi;
            final orbitR = r + 30.0;
            return Stack(
              alignment: Alignment.center,
              children: [
                for (int i = 0; i < 4; i++)
                  Positioned(
                    left: total / 2 + orbitR * math.cos(angle + i * math.pi / 2) - 5,
                    top: total / 2 + orbitR * math.sin(angle + i * math.pi / 2) * 0.4 - 5,
                    child: Container(
                      width: i % 2 == 0 ? 8 : 5,
                      height: i % 2 == 0 ? 8 : 5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: i % 2 == 0
                            ? const Color(0xFF00D4FF)
                            : const Color(0xFF7C3AED),
                        boxShadow: [
                          BoxShadow(
                            color: (i % 2 == 0
                                    ? const Color(0xFF00D4FF)
                                    : const Color(0xFF7C3AED))
                                .withOpacity(0.8),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        // ── Dark mask circle ──────────────────────────────
        Container(
          width: r * 2 + 4,
          height: r * 2 + 4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF000000),
          ),
        ),

        // ── Profile photo ─────────────────────────────────
        CircleAvatar(
          radius: r - 2,
          backgroundImage: const AssetImage(AssetConstants.profileImage),
        ),

        // ── Cyan photo border ─────────────────────────────
        Container(
          width: r * 2,
          height: r * 2,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFF00D4FF).withOpacity(0.5),
              width: 2.5,
            ),
          ),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  HERO SECTION
// ══════════════════════════════════════════════════════════════════════

class _HeroSection extends StatefulWidget {
  const _HeroSection(
      {required this.isMobile, required this.sz, required this.hPad});
  final bool isMobile;
  final Size sz;
  final double hPad;

  @override
  State<_HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<_HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);
    _slide = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _ctrl.forward();
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hc = Get.find<HomeController>();
    final bool m = widget.isMobile;
    final double profileR = m ? 130.0 : 200.0;

    final double sh = widget.sz.height;
    final double sw = widget.sz.width;

    return Stack(
      children: [
        // Floating 3D diamonds — desktop only for perf
        if (!m) ...[
          _FloatingDiamond(
              size: 30, color: ColorConstants.accentCyan,
              phaseOffset: 0.0, top: sh * 0.18, left: widget.hPad * 0.25),
          _FloatingDiamond(
              size: 18, color: ColorConstants.accentPurple,
              phaseOffset: 0.45, top: sh * 0.60, left: widget.hPad * 0.7),
          _FloatingDiamond(
              size: 22, color: ColorConstants.accentGold,
              phaseOffset: 0.7, top: sh * 0.30, left: sw - widget.hPad * 1.4),
          _FloatingDiamond(
              size: 14, color: ColorConstants.accentGreen,
              phaseOffset: 0.25, top: sh * 0.72, left: sw - widget.hPad * 0.6),
          _FloatingDiamond(
              size: 12, color: ColorConstants.accentCyan,
              phaseOffset: 0.55, top: sh * 0.85, left: widget.hPad * 1.5),
        ],
        Container(
      key: hc.aboutKey,
      constraints: BoxConstraints(minHeight: widget.sz.height),
      padding: EdgeInsets.only(
        top: m ? 100 : 120,
        bottom: 60,
        left: widget.hPad,
        right: widget.hPad,
      ),
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: m
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _SelfIntroAnimation(isMobile: m),
                    const SizedBox(height: 40),
                    _heroText(m, hc),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 5, child: _heroText(m, hc)),
                    const SizedBox(width: 60),
                    _SelfIntroAnimation(isMobile: m),
                  ],
                ),
        ),
      ),
    ),      // closes Container
      ],
    );
  }

  Widget _heroText(bool m, HomeController hc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: m ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        // Greeting badge
        _glassCard(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          radius: 50,
          borderColor: ColorConstants.accentCyan.withOpacity(0.3),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.accentGreen,
                boxShadow: [
                  BoxShadow(
                      color: ColorConstants.accentGreen, blurRadius: 6)
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Open to Opportunities',
              style: TextStyle(
                color: ColorConstants.textPrimary,
                fontSize: m ? 12 : 13,
                fontFamily: FontConstants.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ]),
        ),
        const SizedBox(height: 20),
        // Section number
        if (!m)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '01',
              style: TextStyle(
                color: Colors.white.withOpacity(0.06),
                fontSize: 120,
                fontWeight: FontWeight.w900,
                fontFamily: FontConstants.fontFamily,
                height: 0.9,
              ),
            ),
          ),
        if (!m) const SizedBox(height: 4),
        // Text(
        //   "OPEN TO WORK",
        //   style: TextStyle(
        //     color: ColorConstants.accentCyan,
        //     fontSize: m ? 11 : 12,
        //     fontFamily: FontConstants.fontFamily,
        //     fontWeight: FontWeight.w700,
        //     letterSpacing: 3,
        //   ),
        // ),
        // const SizedBox(height: 10),
        // Name — huge bold white
        Text(
          'GIRITHAR K',
          style: TextStyle(
            fontSize: m ? 42 : 72,
            fontWeight: FontWeight.w900,
            fontFamily: 'Airbeat',
            color: Colors.white,
            letterSpacing: m ? 2 : 3,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 8),
        // Static subtitle — matches video style
        Text(
          'FLUTTER DEVELOPER  ·  MOBILE APP ARCHITECT',
          style: TextStyle(
            fontSize: m ? 12 : 15,
            color: Colors.white.withOpacity(0.45),
            fontFamily: FontConstants.fontFamily,
            fontWeight: FontWeight.w500,
            letterSpacing: m ? 1.5 : 2.5,
          ),
        ),
        const SizedBox(height: 10),
        // Animated typing for tech stack
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText(
              'GetX · GraphQL · Firebase · IoT',
              textStyle: TextStyle(
                fontSize: m ? 14 : 17,
                color: ColorConstants.accentCyan,
                fontWeight: FontWeight.w600,
                fontFamily: FontConstants.fontFamily,
                letterSpacing: 1,
              ),
              speed: const Duration(milliseconds: 60),
            ),
            TyperAnimatedText(
              'Clean Architecture · MQTT · SSO',
              textStyle: TextStyle(
                fontSize: m ? 14 : 17,
                color: ColorConstants.accentPurple,
                fontWeight: FontWeight.w600,
                fontFamily: FontConstants.fontFamily,
                letterSpacing: 1,
              ),
              speed: const Duration(milliseconds: 60),
            ),
          ],
          repeatForever: true,
          pause: const Duration(milliseconds: 2000),
        ),
        const SizedBox(height: 28),
        // CTA Buttons
        Wrap(
          spacing: 14,
          runSpacing: 14,
          alignment: m ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _GlowButton(
              label: 'Download CV',
              isPrimary: true,
              onTap: () => hc.resumeDriveLink(),
            ),
            _GlowButton(
              label: 'Contact Me',
              isPrimary: false,
              onTap: () => HomeController.openEmailApp(
                  toMail: 'girithardev@gmail.com'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Social icons
        Row(
          mainAxisAlignment:
              m ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => hc.linkedInLink(),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Lottie.asset('assets/images/lotties/linkedin.json',
                  width: m ? 55 : 65, height: m ? 55 : 65, fit: BoxFit.fill),
            ),
            InkWell(
              onTap: () => hc.gitHubLink(),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Lottie.asset('assets/images/lotties/github.json',
                  width: m ? 55 : 65, height: m ? 55 : 65, fit: BoxFit.fill),
            ),
          ],
        ),
      ],
    );
  }
}

// Glow button widget
class _GlowButton extends StatefulWidget {
  const _GlowButton(
      {required this.label,
      required this.isPrimary,
      required this.onTap});
  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  State<_GlowButton> createState() => _GlowButtonState();
}

class _GlowButtonState extends State<_GlowButton> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: widget.isPrimary
                ? LinearGradient(
                    colors: [
                      ColorConstants.accentCyan,
                      ColorConstants.accentPurple,
                    ],
                  )
                : null,
            border: widget.isPrimary
                ? null
                : Border.all(
                    color: ColorConstants.accentCyan.withOpacity(0.6),
                    width: 1.5,
                  ),
            boxShadow: _hov
                ? [
                    BoxShadow(
                      color: (widget.isPrimary
                              ? ColorConstants.accentCyan
                              : ColorConstants.accentPurple)
                          .withOpacity(0.45),
                      blurRadius: 22,
                      spreadRadius: 1,
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: widget.isPrimary
                  ? Colors.white
                  : ColorConstants.accentCyan,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  ABOUT SECTION
// ══════════════════════════════════════════════════════════════════════

class _AboutSection extends StatelessWidget {
  const _AboutSection(
      {required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return _SectionReveal(
      sectionId: 'about',
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        _sectionHeader('01 / About', 'WHO I AM', isMobile, sectionNum: '01'),
        const SizedBox(height: 48),

        // Stats grid
        LayoutBuilder(builder: (ctx, c) {
          final cols = c.maxWidth > 600 ? 4 : 2;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: cols,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: c.maxWidth > 900 ? 2.0 : 1.6,
            ),
            itemCount: controller.cardData.length,
            itemBuilder: (_, i) {
              final d = controller.cardData[i];
              final isNum = d['isNumeric'] as bool;
              return TiltCard3D(
                glowColor: ColorConstants.accentCyan,
                child: _glassCard(
                  child: isNum
                      ? _CountUpStat(
                          numVal: d['numVal'] as double,
                          suffix: d['suffix'] as String,
                          label: d['subtitle'] as String,
                          isMobile: isMobile,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (b) => const LinearGradient(
                                colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
                              ).createShader(
                                  Rect.fromLTWH(0, 0, b.width, b.height)),
                              child: Text(
                                d['title'] as String,
                                style: TextStyle(
                                  fontSize: isMobile ? 28 : 36,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              d['subtitle'] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstants.textSecondary,
                                fontSize: isMobile ? 12 : 13,
                                fontFamily: FontConstants.fontFamily,
                              ),
                            ),
                          ],
                        ),
                ),
              );
            },
          );
        }),

        const SizedBox(height: 40),

        // WHO I AM — bio panel
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.03),
            border: Border.all(
              color: ColorConstants.accentCyan.withOpacity(0.18),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: ColorConstants.accentCyan.withOpacity(0.06),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Flutter Developer with 4+ years of hands-on experience building scalable cross-platform applications for Android and iOS. Strong expertise in enterprise IoT platforms, GraphQL APIs, Firebase, GetX state management, and Clean Architecture.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: isMobile ? 15 : 17,
                  fontFamily: FontConstants.fontFamily,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Currently building Awesometicks V2 at NectarIT Technologies — an enterprise IoT platform for asset management, attendance tracking, and job operations. Previously at Nearle Technology, shipped Nearle Super App, Nearle Xpress, and Legendary Client App to both iOS and Android.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: isMobile ? 13 : 15,
                  fontFamily: FontConstants.fontFamily,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  WORK EXPERIENCE SECTION (Timeline) — NEW
// ══════════════════════════════════════════════════════════════════════

// ══════════════════════════════════════════════════════════════════════
//  BY THE NUMBERS  (matches video section)
// ══════════════════════════════════════════════════════════════════════

class _ByTheNumbersSection extends StatelessWidget {
  const _ByTheNumbersSection(
      {required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    // Stats matching the video's visual style
    final stats = [
      {'num': 4.0,  'suffix': '+',  'label': 'YEARS\nEXPERIENCE'},
      {'num': 5.0,  'suffix': '+',  'label': 'APPS\nSHIPPED'},
      {'num': 15.0, 'suffix': '+',  'label': 'FEATURES\nBUILT'},
      {'num': 2.0,  'suffix': '',   'label': 'COMPANIES\nWORKED'},
    ];

    return _SectionReveal(
      sectionId: 'numbers',
      child: _darkSectionCard(
        subLabel: 'About / Impact',
        neonTitle: 'SUCCESS METRICS',
        sectionNum: '04',
        isMobile: isMobile,
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats.asMap().entries.map((e) {
            final i = e.key;
            final s = e.value;
            return Expanded(
              child: Column(
                children: [
                  // Big animated number — white with amber accent
                  _CountUpStat(
                    numVal: s['num'] as double,
                    suffix: s['suffix'] as String,
                    label: s['label'] as String,
                    isMobile: isMobile,
                    accentColor: i % 2 == 0
                        ? ColorConstants.accentGold
                        : Colors.white,
                  ),
                  if (i < stats.length - 1)
                    Container(
                      width: 1,
                      height: isMobile ? 30 : 40,
                      color: Colors.white.withOpacity(0.08),
                    ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  const _ExperienceSection(
      {required this.isMobile,
      required this.hPad,
      required this.controller});
  final bool isMobile;
  final double hPad;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.experienceKey,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 20),
      child: _SectionReveal(
        sectionId: 'experience',
        child: Column(children: [
          _sectionHeader('02 / Experience', 'WORK EXPERIENCE', isMobile, sectionNum: '02'),
          const SizedBox(height: 56),
          ...controller.workExperience.asMap().entries.map((e) {
            final i = e.key;
            final exp = e.value;
            return _ExperienceCard(
              data: exp,
              isMobile: isMobile,
              isLast: i == controller.workExperience.length - 1,
              index: i,
            );
          }),
        ]),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard(
      {required this.data,
      required this.isMobile,
      required this.isLast,
      required this.index});
  final Map<String, dynamic> data;
  final bool isMobile;
  final bool isLast;
  final int index;

  @override
  Widget build(BuildContext context) {
    final Color accent = data['color'] as Color;
    final bool isCurrent = data['current'] as bool;
    final List<String> achievements =
        List<String>.from(data['achievements'] as List);

    return _SectionReveal(
      sectionId: 'exp_$index',
      delayMs: index * 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column
          Column(children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: accent,
                boxShadow: [
                  BoxShadow(
                      color: accent.withOpacity(0.7), blurRadius: 12, spreadRadius: 2)
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: isMobile ? 280 : 260,
                margin: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [accent.withOpacity(0.6), Colors.transparent],
                  ),
                ),
              ),
          ]),
          const SizedBox(width: 24),
          // Card
          Expanded(
            child: TiltCard3D(
              glowColor: accent,
              child: _glassCard(
                borderColor: accent.withOpacity(0.25),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['company'] as String,
                                style: TextStyle(
                                  color: ColorConstants.textPrimary,
                                  fontSize: isMobile ? 16 : 20,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                data['role'] as String,
                                style: TextStyle(
                                  color: accent,
                                  fontSize: isMobile ? 13 : 15,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                          if (isCurrent)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: ColorConstants.accentGreen.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      ColorConstants.accentGreen.withOpacity(0.5),
                                ),
                              ),
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorConstants.accentGreen,
                                    boxShadow: [
                                      BoxShadow(
                                          color: ColorConstants.accentGreen,
                                          blurRadius: 4)
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'Current',
                                  style: TextStyle(
                                    color: ColorConstants.accentGreen,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ]),
                            ),
                          const SizedBox(height: 6),
                          Text(
                            data['period'] as String,
                            style: TextStyle(
                              color: ColorConstants.textMuted,
                              fontSize: isMobile ? 11 : 13,
                              fontFamily: FontConstants.fontFamily,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(mainAxisSize: MainAxisSize.min, children: [
                            const Icon(Icons.location_on_outlined,
                                color: ColorConstants.textMuted, size: 12),
                            const SizedBox(width: 3),
                            Text(
                              data['location'] as String,
                              style: const TextStyle(
                                color: ColorConstants.textMuted,
                                fontSize: 12,
                              ),
                            ),
                          ]),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: ColorConstants.borderGlass),
                    const SizedBox(height: 16),
                    ...achievements.map((a) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 6),
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: accent),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  a,
                                  style: TextStyle(
                                    color: ColorConstants.textSecondary,
                                    fontSize: isMobile ? 13 : 15,
                                    fontFamily: FontConstants.fontFamily,
                                    height: 1.55,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  SKILLS SECTION
// ══════════════════════════════════════════════════════════════════════

class _SkillsSection extends StatelessWidget {
  const _SkillsSection({required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  // Category data — [label, accentColor, icon, skills...]
  static final _categories = [
    {
      'label': 'CORE',
      'icon': Icons.code_rounded,
      'color': const Color(0xFF00D4FF),
      'skills': ['Flutter', 'Dart', 'GraphQL', 'SQL', 'Kotlin'],
      'span': 2, // bento span: 2 cols wide
    },
    {
      'label': 'FRAMEWORKS',
      'icon': Icons.layers_rounded,
      'color': const Color(0xFF7C3AED),
      'skills': ['GetX', 'Clean Architecture', 'REST API', 'Flutter Flow', 'MVVM'],
      'span': 1,
    },
    {
      'label': 'CLOUD & TOOLS',
      'icon': Icons.cloud_rounded,
      'color': const Color(0xFFF59E0B),
      'skills': ['Firebase', 'Cloudinary', 'Android Studio', 'VS Code', 'Postman', 'Figma'],
      'span': 1,
    },
    {
      'label': 'DATABASES',
      'icon': Icons.storage_rounded,
      'color': const Color(0xFF10B981),
      'skills': ['Firestore', 'Hive', 'SQLite', 'Shared Prefs'],
      'span': 1,
    },
    {
      'label': 'DEVOPS & COLLAB',
      'icon': Icons.hub_rounded,
      'color': const Color(0xFF00D4FF),
      'skills': ['Git', 'Bitbucket', 'Jira', 'Slack', 'SourceTree'],
      'span': 1,
    },
    {
      'label': 'PROTOCOLS',
      'icon': Icons.wifi_rounded,
      'color': const Color(0xFF7C3AED),
      'skills': ['MQTT', 'SSO', 'OAuth2', 'GraphQL Subscriptions', 'WebSocket'],
      'span': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return _SectionReveal(
      sectionId: 'skills',
      child: SizedBox(
        key: controller.toolsKey,
        child: _darkSectionCard(
          subLabel: 'Stack & Tooling',
          neonTitle: 'TECHNICAL SKILLS',
          sectionNum: '03',
          isMobile: isMobile,
          content: _buildBento(),
        ),
      ),
    );
  }

  Widget _buildBento() {
    if (isMobile) {
      // Mobile: simple 2-column wrap
      return Wrap(
        spacing: 12,
        runSpacing: 12,
        children: _categories.map((cat) {
          return SizedBox(
            width: double.infinity,
            child: _BentoCard(cat: cat, isMobile: true),
          );
        }).toList(),
      );
    }

    // Desktop: asymmetric bento using spans
    // Row 1: CORE (2) + FRAMEWORKS (1) + CLOUD (1)  → but we only have 3 cols
    // Layout: 3-col grid, CORE spans 2, PROTOCOLS spans 2
    return LayoutBuilder(builder: (ctx, cst) {
      const cols = 3;
      const colGap = 16.0;
      final colW = (cst.maxWidth - colGap * (cols - 1)) / cols;

      // Manual bento placement
      final List<List<Map>> rows = [
        // row 1: CORE(2-wide) + FRAMEWORKS(1)
        [_categories[0], _categories[1]],
        // row 2: CLOUD(1) + DATABASES(1) + DEVOPS(1)
        [_categories[2], _categories[3], _categories[4]],
        // row 3: PROTOCOLS(2-wide) + (filler or nothing)
        [_categories[5]],
      ];

      return Column(
        children: rows.asMap().entries.map((rowEntry) {
          final row = rowEntry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: row.asMap().entries.map((entry) {
                final i = entry.key;
                final cat = entry.value;
                final span = cat['span'] as int;
                final w = colW * span + colGap * (span - 1);
                return Padding(
                  padding: EdgeInsets.only(left: i > 0 ? colGap : 0),
                  child: SizedBox(
                    width: w,
                    child: _BentoCard(cat: cat, isMobile: false),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      );
    });
  }
}

class _BentoCard extends StatefulWidget {
  const _BentoCard({required this.cat, required this.isMobile});
  final Map cat;
  final bool isMobile;
  @override
  State<_BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<_BentoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final color   = widget.cat['color'] as Color;
    final label   = widget.cat['label'] as String;
    final icon    = widget.cat['icon'] as IconData;
    final skills  = widget.cat['skills'] as List<String>;
    final m       = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: EdgeInsets.all(m ? 14 : 18),
        decoration: BoxDecoration(
          color: _hovered
              ? color.withOpacity(0.07)
              : const Color(0xFF0D1117),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _hovered ? color.withOpacity(0.45) : color.withOpacity(0.14),
            width: 1.2,
          ),
          boxShadow: _hovered
              ? [BoxShadow(color: color.withOpacity(0.18), blurRadius: 24, spreadRadius: 2)]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header row
            Row(children: [
              Container(
                width: m ? 28 : 32,
                height: m ? 28 : 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.12),
                  border: Border.all(color: color.withOpacity(0.3), width: 1),
                ),
                child: Icon(icon, color: color, size: m ? 14 : 16),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: m ? 9 : 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                  fontFamily: FontConstants.fontFamily,
                ),
              ),
            ]),
            SizedBox(height: m ? 10 : 14),
            // Skill chips
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: skills.map((s) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(
                  horizontal: m ? 8 : 10,
                  vertical: m ? 4 : 5,
                ),
                decoration: BoxDecoration(
                  color: _hovered
                      ? color.withOpacity(0.10)
                      : Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: _hovered
                        ? color.withOpacity(0.30)
                        : Colors.white.withOpacity(0.10),
                    width: 0.8,
                  ),
                ),
                child: Text(
                  s,
                  style: TextStyle(
                    color: _hovered ? Colors.white : Colors.white.withOpacity(0.75),
                    fontSize: m ? 10 : 11,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontConstants.fontFamily,
                  ),
                ),
              )).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  TOOLS SECTION
// ══════════════════════════════════════════════════════════════════════

class _ToolsSection extends StatelessWidget {
  const _ToolsSection(
      {required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return _SectionReveal(
      sectionId: 'tools',
      child: Column(children: [
        _sectionHeader('04 / Tools', 'TOOLS & IDEs', isMobile, sectionNum: '04'),
        const SizedBox(height: 48),
        Container(
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                ColorConstants.accentPurple.withOpacity(0.12),
                ColorConstants.accentCyan.withOpacity(0.06),
              ],
            ),
            border: Border.all(color: ColorConstants.borderGlass),
          ),
          child: LayoutBuilder(builder: (ctx, c) {
            final cols = c.maxWidth < 400
                ? 2
                : c.maxWidth < 700
                    ? 3
                    : c.maxWidth < 900
                        ? 4
                        : 6;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: isMobile ? 120 : 150,
              ),
              itemCount: controller.toolsAndIDEs.length,
              itemBuilder: (_, i) {
                final t = controller.toolsAndIDEs[i];
                return _SectionReveal(
                  sectionId: 'tool_$i',
                  delayMs: i * 60,
                  child: TiltCard3D(
                    glowColor: ColorConstants.accentPurple,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(16),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            t['image']!,
                            height: isMobile ? 36 : 48,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            t['name']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstants.textPrimary,
                              fontSize: isMobile ? 10 : 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: FontConstants.fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  PROJECTS CAROUSEL
// ══════════════════════════════════════════════════════════════════════

class _ProjectsSection extends StatelessWidget {
  const _ProjectsSection(
      {required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Container(
        key: c.projectsKey,
        child: _SectionReveal(
          sectionId: 'projects',
          child: Column(children: [
            _sectionHeader('05 / Projects', 'FEATURED PROJECTS', isMobile, sectionNum: '05'),
            const SizedBox(height: 48),
            CarouselSlider(
              carouselController: c.carouselController,
              options: CarouselOptions(
                height: isMobile ? 260 : 400,
                onPageChanged: (i, _) {
                  c.currentIndex = i;
                  c.update();
                },
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                viewportFraction: isMobile ? 0.85 : 0.5,
                enlargeFactor: 0.3,
              ),
              items: c.projects.map((p) => _ProjectCard(project: p)).toList(),
            ),
            const SizedBox(height: 32),
            AnimatedSmoothIndicator(
              activeIndex: c.currentIndex,
              count: c.projects.length,
              onDotClicked: (i) => c.carouselController.animateToPage(i),
              effect: ExpandingDotsEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: ColorConstants.accentCyan,
                dotColor: Colors.white.withOpacity(0.2),
              ),
            ),
          ]),
        ),
      );
    });
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});
  final Project project;

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: widget.project.backgroundColor,
          boxShadow: _hov
              ? [
                  BoxShadow(
                    color: widget.project.backgroundColor.withOpacity(0.5),
                    blurRadius: 30,
                    spreadRadius: 4,
                  )
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(children: [
            Positioned.fill(
              child: Image.asset(
                widget.project.imagePath,
                fit: BoxFit.cover,
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                    stops: const [0, 0.6],
                  ),
                ),
              ),
            ),
            // Title
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.project.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  BLOGS / CASE STUDIES SECTION
// ══════════════════════════════════════════════════════════════════════

class _BlogsSection extends StatelessWidget {
  const _BlogsSection(
      {required this.isMobile, required this.controller});
  final bool isMobile;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.blogKey,
      child: _SectionReveal(
        sectionId: 'blogs',
        child: Column(children: [
          _sectionHeader('06 / Case Studies', 'DEEP DIVES', isMobile, sectionNum: '06'),
          const SizedBox(height: 48),
          LayoutBuilder(builder: (ctx, c) {
            final cols = c.maxWidth < 600
                ? 1
                : c.maxWidth < 1000
                    ? 2
                    : 2;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 1.0 : 1.15,
              ),
              itemCount: controller.blogs.length,
              itemBuilder: (_, i) {
                final b = controller.blogs[i];
                return _SectionReveal(
                  sectionId: 'blog_$i',
                  delayMs: i * 100,
                  child: _BlogCard(
                      blog: b, isMobile: isMobile),
                );
              },
            );
          }),
        ]),
      ),
    );
  }
}

class _BlogCard extends StatefulWidget {
  const _BlogCard({required this.blog, required this.isMobile});
  final Project blog;
  final bool isMobile;

  @override
  State<_BlogCard> createState() => _BlogCardState();
}

class _BlogCardState extends State<_BlogCard> {
  bool _hov = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hov = true),
      onExit: (_) => setState(() => _hov = false),
      child: GestureDetector(
        onTap: () async {
          if (widget.blog.blogUrl.isEmpty) return;
          final uri = Uri.parse(widget.blog.blogUrl);
          try {
            if (await canLaunchUrl(uri)) launchUrl(uri);
          } catch (e) {
            logger.i('Blog open error: $e');
          }
        },
        child: TiltCard3D(
          glowColor: widget.blog.backgroundColor,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(_hov ? 0.07 : 0.04),
              border: Border.all(
                color: (_hov
                        ? widget.blog.backgroundColor
                        : Colors.white.withOpacity(0.08)),
                width: _hov ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category chip
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.blog.backgroundColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        color: widget.blog.backgroundColor.withOpacity(0.4)),
                  ),
                  child: Text(
                    widget.blog.imagePath,
                    style: TextStyle(
                      color: widget.blog.backgroundColor,
                      fontSize: widget.isMobile ? 11 : 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: FontConstants.fontFamily,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.blog.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ColorConstants.textPrimary,
                    fontSize: widget.isMobile ? 16 : 18,
                    fontWeight: FontWeight.w800,
                    fontFamily: FontConstants.fontFamily,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    widget.blog.description,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: ColorConstants.textSecondary,
                      fontSize: widget.isMobile ? 13 : 14,
                      fontFamily: FontConstants.fontFamily,
                      height: 1.6,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (widget.blog.blogUrl.isNotEmpty)
                  Row(children: [
                    Text(
                      'Read more',
                      style: TextStyle(
                        color: ColorConstants.accentCyan,
                        fontSize: widget.isMobile ? 13 : 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontConstants.fontFamily,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_forward_rounded,
                        color: ColorConstants.accentCyan, size: 16),
                  ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  CONTACT SECTION
// ══════════════════════════════════════════════════════════════════════

class _ContactSection extends StatefulWidget {
  const _ContactSection(
      {required this.isMobile,
      required this.sz,
      required this.controller});
  final bool isMobile;
  final Size sz;
  final HomeController controller;

  @override
  State<_ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<_ContactSection> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (c) {
      return Container(
        key: c.contactKey,
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: widget.isMobile ? 20 : 60,
          vertical: 80,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              ColorConstants.accentPurple.withOpacity(0.06),
              ColorConstants.accentCyan.withOpacity(0.04),
            ],
          ),
          border: const Border(
              top: BorderSide(color: ColorConstants.borderGlass)),
        ),
        child: _SectionReveal(
          sectionId: 'contact',
          child: Column(children: [
            _sectionHeader('07 / Contact', 'GET IN TOUCH', widget.isMobile, sectionNum: '07'),
            const SizedBox(height: 12),
            Text(
              "Feel free to reach out for new projects, collaborations, or just a chat.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorConstants.textSecondary,
                fontSize: widget.isMobile ? 14 : 16,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
            const SizedBox(height: 48),
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxWidth: widget.isMobile ? double.infinity : 680),
              child: _glassCard(
                padding: const EdgeInsets.all(32),
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    // Name + Email
                    widget.isMobile
                        ? Column(children: [
                            _premiumField(c.nameController, 'Name',
                                Icons.person_outline_rounded),
                            const SizedBox(height: 16),
                            _premiumField(c.emailController, 'Email',
                                Icons.email_outlined),
                          ])
                        : Row(children: [
                            Expanded(
                              child: _premiumField(c.nameController, 'Name',
                                  Icons.person_outline_rounded),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: _premiumField(c.emailController, 'Email',
                                  Icons.email_outlined),
                            ),
                          ]),
                    const SizedBox(height: 16),
                    _premiumField(
                      c.descriptionController,
                      'Message',
                      Icons.message_outlined,
                      maxLines: 5,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: _GlowButton(
                        label: 'Send Message',
                        isPrimary: true,
                        onTap: () {
                          if (c.nameController.text.isEmpty) {
                            Toast.showToast('Enter your name');
                          } else if (c.emailController.text.isEmpty) {
                            Toast.showToast('Enter a valid email');
                          } else if (c.descriptionController.text.isEmpty) {
                            Toast.showToast('Enter your message');
                          } else {
                            c.sendEmail(
                              c.nameController.text,
                              c.emailController.text,
                              c.descriptionController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Message sent!',
                                    style: TextStyle(
                                        color: ColorConstants.textPrimary)),
                                backgroundColor:
                                    ColorConstants.accentCyan.withOpacity(0.8),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Footer
            const Divider(color: ColorConstants.borderGlass),
            const SizedBox(height: 24),
            Text(
              '© 2026 Girithar K. All Rights Reserved.',
              style: TextStyle(
                color: ColorConstants.textMuted,
                fontSize: widget.isMobile ? 13 : 14,
                fontFamily: FontConstants.fontFamily,
              ),
            ),
          ]),
        ),
      );
    });
  }

  Widget _premiumField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(
        color: ColorConstants.textPrimary,
        fontFamily: 'Helvetica',
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: ColorConstants.textSecondary,
          fontFamily: 'Helvetica',
        ),
        prefixIcon: Icon(icon, color: ColorConstants.accentCyan, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.04),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
              color: ColorConstants.accentCyan, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
//  WHATSAPP FAB
// ══════════════════════════════════════════════════════════════════════

class _WhatsAppFAB extends StatelessWidget {
  const _WhatsAppFAB({required this.isMobile});
  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    final double sz = isMobile ? 72 : 90;
    return Container(
      width: sz,
      height: sz,
      margin: EdgeInsets.only(
          bottom: isMobile ? 10 : 40, right: isMobile ? 8 : 40),
      child: FloatingActionButton(
        elevation: 0,
        hoverElevation: 0,
        backgroundColor: Colors.transparent,
        splashColor: Colors.transparent,
        hoverColor: Colors.transparent,
        shape: const CircleBorder(),
        onPressed: () async {
          final url = Uri.parse('https://wa.me/+918838304677');
          if (await canLaunchUrl(url)) launchUrl(url);
        },
        child: Lottie.asset('assets/images/lotties/whatsapp.json',
            width: sz, height: sz, fit: BoxFit.fill),
      ),
    );
  }
}
