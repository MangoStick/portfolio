import 'package:flutter/material.dart';
import 'package:portfolio/constants/assets.dart';
import 'package:portfolio/constants/fonts.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/constants/text_styles.dart';
import 'package:portfolio/models/education.dart';
import 'package:portfolio/ui/home.dart';
import 'package:portfolio/utils/screen/screen_utils.dart';
import 'package:portfolio/widgets/responsive_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:html' as html;

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFFF7F8FA),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (ScreenUtil.getInstance().setWidth(108))), //144
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          drawer: _buildDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }

  //AppBar Methods:-------------------------------------------------------------
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: !ResponsiveWidget.isSmallScreen(context)
          ? _buildActions(context)
          : null,
      leading: ResponsiveWidget.isSmallScreen(context)
          ? Builder(
              builder: (context) => IconButton(
                icon: new Icon(Icons.menu, color: Color(0xFF45405B)),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            )
          : null,
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.o,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      MaterialButton(
        child: Text(Strings.menu_home, style: TextStyles.menu_item),
        onPressed: () {
          //Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (_, __, ___) => HomePage()), (route) => false);
          Navigator.pushNamedAndRemoveUntil(
              context, Strings.HomeRoute, (route) => false);
          //Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
      ),
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
      ),
      // MaterialButton(
      //   child: Text(
      //    Strings.menu_contact,
      //    style: TextStyles.menu_item,
      //   ),
      //   onPressed: () {},
      //),
    ];
  }

  Widget _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: _buildActions(context),
            ),
          )
        : null;
  }

  //Screen Methods:-------------------------------------------------------------
  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
                _buildIllustration(),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
              ],
            ),
          ),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: _buildContent(context)),
          Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  // Body Methods:--------------------------------------------------------------
  Widget _buildIllustration() {
    return Image.network(
      Assets.programmer3,
      height: ScreenUtil.getInstance().setWidth(300), //480.0
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        SizedBox(height: 4.0),
        // _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        // _buildSummary(),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildEducation(),
                  // SizedBox(height: 200.0),
                  _buildEducation2(),
                  //_buildSkills(context),
                  _buildEducation3()
                ],
              )
            : _buildSkillsAndEducation(context)
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.developer,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.nexa_light,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.portfolio,
            style: TextStyles.heading.copyWith(
              color: Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Text(
      ResponsiveWidget.isSmallScreen(context)
          ? Strings.headline
          : Strings.headline.replaceFirst(RegExp(r' f'), '\nf'),
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.only(right: 80.0),
      child: Text(
        Strings.summary,
        style: TextStyles.body,
      ),
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _buildEducation(),
        ),
        SizedBox(width: 40.0),
        Expanded(
          flex: 1,
          child: _buildEducation2(),
        ),
        SizedBox(width: 40.0),
        Expanded(
          flex: 1,
          child: _buildEducation3(),
        ),
      ],
    );
  }

  // Education Methods:---------------------------------------------------------
  final educationList = [
    Education(
      'Full-stack',
      '',
      'Laravel/SQL Server',
      'NT Web Config Demo',
    ),
    Education(
      'Full-stack',
      '',
      'Laravel/PostgreSQL',
      'BAAC Web Prediction',
    ),
    Education(
      'Full-stack',
      '',
      'Flutter/Go/NodeJs/SQL Server',
      'Excise Wine Duty Tax',
    ),
    Education(
      'Full-stack',
      '',
      'Flutter/Kotlin/Python',
      'Internal Project',
    ),
    Education(
      'Front-end',
      '',
      'Flutter/Firebase Cloud Messaging',
      'RBSC Staff (Mobile)',
    ),
    Education(
      'Front-end',
      '',
      'Flutter/Firebase Cloud Messaging',
      'RBSC Membership (Mobile)',
    ),
    Education(
      'Front-end',
      '',
      'Angular 11/TypeScript',
      'RBSC Membership Management',
    ),
    Education(
      'Front-end',
      '',
      'Angular 11/TypeScript/JavaScript',
      'BBTEC PM&M',
    ),
    
  ];

  final educationList2 = [
    Education(
      'Front-end',
      '',
      'Flutter',
      'RBSC Staff Demo (Mobile)',
    ),
    Education(
      'Front-end',
      '',
      'Flutter',
      'RBSC Member Demo (Mobile)',
    ),
    Education(
      'Front-end',
      '',
      'Angular 8/TypeScript',
      'SCG e-Ordering',
    ),
    Education(
      'Full-stack',
      '',
      'Angular 8/TypeScript/C#/.NetCore',
      'Dip e-Trademark',
    ),
    Education(
      'Front-end',
      '',
      'Flutter',
      'Serves (Mobile)',
    ),
    Education(
      'Full-stack',
      '',
      'Flutter/Firebase Cloud Messaging',
      'E-Leave (Mobile)',
    ),
    Education(
      'Full-stack',
      '',
      'PHP Laravel/MySQL',
      'E-Leave',
    ),
    Education(
      'Full-stack',
      '',
      'PHP Laravel/MySQL',
      'SteelCity CMS',
    ),
    
  ];


  final educationList3 = [
    Education(
      'Back-end',
      '',
      'C#/.NET/Web Service asmx/SQL Server',
      'Thainamthip - PR Approval',
    ),
    Education(
      'Back-end',
      '',
      'AngularJs/C#/.NET/RDLC Report',
      'PTT - eBudgeting ',
    ),
    Education(
      'Full-stack',
      '',
      'C#/.NET/SQL Server/Crystal Reports',
      'Smile IVF Clinic',
    ),
    Education(
      'Full-stack',
      '',
      'C#/.NET/SQL Server/Crystal Reports',
      'Siam Fertility Clinic',
    ),
    Education(
      'Full-stack',
      '',
      'C#/.NET/SQL Server/Nginx',
      'Eye laser reservation system',
    ),
  ];

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _buildEducationContainerHeading(),
        // _buildEducationSummary(),
        // SizedBox(height: 8.0),
        _buildEducationTimeline(),
      ],
    );
  }

  Widget _buildEducation2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _buildEducationContainerHeading(),
        // _buildEducationSummary(),
        //SizedBox(height: 50.0),
        _buildEducationTimeline2(),
      ],
    );
  }

  Widget _buildEducation3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // _buildEducationContainerHeading(),
        // _buildEducationSummary(),
        //SizedBox(height: 50.0),
        _buildEducationTimeline3(),
      ],
    );
  }

  Widget _buildEducationContainerHeading() {
    return Text(
      Strings.experience,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildEducationSummary() {
    return Text(
      Strings.exp_detail,
      style: TextStyles.body,
    );
  }

  Widget _buildEducationTimeline() {
    final List<Widget> widgets = educationList
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTimeline2() {
    final List<Widget> widgets = educationList2
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTimeline3() {
    final List<Widget> widgets = educationList3
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(Education education) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          // height: 60,
          width: 250,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          //color: Color(0xFF50AFC0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '${education.post}',
                style: TextStyles.company,
              ),
              Text(
                '${education.organization}',
                style: TextStyles.body.copyWith(
                  color: Color(0xFF45405B),
                ),
              ),
              Text(
                '${education.from}',
                style: TextStyles.body,
              ),
            ],
          ),
        ));
  }

  // Footer Methods:------------------------------------------------------------
  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: _buildCopyRightText(context),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: _buildSocialIcons(),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // GestureDetector(
        //   onTap: () {
        //     html.window.open("https://www.facebook.com/Jack.Jakkapat.Noimhor", "Facebook");
        //   },
        //   child: Icon(
        //     FontAwesomeIcons.facebookSquare,
        //     color: Color(0xFF45405B),
        //     size: 20.0,
        //   ),
        // ),
        // SizedBox(width: 16.0),
        // GestureDetector(
        //   onTap: () {
        //     html.window.open("https://www.instagram.com/jacky.jpn", "Instagram");
        //   },
        //   child: Icon(
        //     FontAwesomeIcons.instagram,
        //     color: Color(0xFF45405B),
        //     size: 20.0,
        //   ),
        // ),
        // SizedBox(width: 16.0),
        // GestureDetector(
        //   onTap: () {
        //     html.window.open("https://github.com/MangoStick", "Github");
        //   },
        //   child: Icon(
        //     FontAwesomeIcons.githubAlt,
        //     color: Color(0xFF45405B),
        //     size: 20.0,
        //   ),
        // ),
        // SizedBox(width: 16.0),
        // GestureDetector(
        //   onTap: () {
        //     html.window.open("https://open.spotify.com/user/jakkapat?fbclid=IwAR3nuCfQDf7dFoxSNyIHEt0Uv6rkDW4IHfLWWqX5vAeyjUGkdSDWo17O_NU", "Spotify");
        //   },
        //   child: Icon(
        //     FontAwesomeIcons.spotify,
        //     color: Color(0xFF45405B),
        //     size: 20.0,
        //   ),
        // ),

        MaterialButton(
          minWidth: 0,
          child: Icon(
            FontAwesomeIcons.facebookSquare,
            color: Color(0xFF45405B),
            size: 20.0,
          ),
          onPressed: () => html.window.open(
              "https://www.facebook.com/Jack.Jakkapat.Noimhor", "Facebook"),
        ),
        MaterialButton(
          minWidth: 0,
          child: Icon(
            FontAwesomeIcons.instagram,
            color: Color(0xFF45405B),
            size: 20.0,
          ),
          onPressed: () => html.window
              .open("https://www.instagram.com/n.jakkapat", "Instagram"),
        ),
        MaterialButton(
          minWidth: 0,
          child: Icon(
            FontAwesomeIcons.githubAlt,
            color: Color(0xFF45405B),
            size: 20.0,
          ),
          onPressed: () =>
              html.window.open("https://github.com/MangoStick", "Github"),
        ),
        MaterialButton(
          minWidth: 0,
          child: Icon(
            FontAwesomeIcons.spotify,
            color: Color(0xFF45405B),
            size: 20.0,
          ),
          onPressed: () => html.window.open(
              "https://open.spotify.com/user/jakkapat?fbclid=IwAR3nuCfQDf7dFoxSNyIHEt0Uv6rkDW4IHfLWWqX5vAeyjUGkdSDWo17O_NU",
              "Spotify"),
        ),
      ],
    );
  }
}
