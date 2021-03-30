import 'package:flutter/material.dart';
import 'package:lit_ui_kit/lit_ui_kit.dart';
import 'package:lit_ui_kit/src/widgets/settings_panel/settings_panel_background_overlay.dart';

/// [Widget] used to overlay multiple functinal [Widget]s to ensure no unintended
/// overlapping will occur.
///
/// The default [Scaffold] will be used as foundation  which will be extended by
/// the custom widgets. By passing on the arguments, the corresponding [Widget]s
/// will be played into a [Stack].
///
/// The layer will be dependend on the [Widget]'s usecase. E.g. a [LitSnackbar]
/// will always be displayed on top of a [CustomAppBar].
///
/// The [body] is adjusted to fit the [CustomAppBar] using a top padding, if it is
/// provided and it if is not the [LitBlurredAppBar].
class LitScaffold extends StatefulWidget {
  /// The [Color] of the background.
  final Color backgroundColor;

  /// The main [Widget] to be displayed on the [LitScaffold].
  final Widget body;

  /// The [CustomAppBar] displays additional information.
  final CustomAppBar? appBar;
  final CustomInfoBar? infoBar;

  /// The [LitSnackbar] displaying changes triggered by the user.
  ///
  /// You can you one of the following [LitSnackbar]s:
  ///
  ///  * [IconSnackbar], which displays an [Icon] alongside the provided
  ///    messages.
  ///  * [SlidingSnackbar], which displays the provided child [Widget].
  final LitSnackbar? snackBar;
  final CustomActionButton? actionButton;
  final CollapsibleCard? collapsibleCard;
  final SettingsPanel? settingsPanel;
  final bool wrapInSafeArea;

  /// Creates a [LitScaffold] [Widget].

  const LitScaffold({
    Key? key,
    this.backgroundColor = Colors.white,
    //this.darkMode = false,
    required this.body,
    this.snackBar,
    this.infoBar,
    this.appBar,
    this.actionButton,
    this.collapsibleCard,
    this.settingsPanel,
    this.wrapInSafeArea = true,
  }) : super(key: key);

  @override
  _LitScaffoldState createState() => _LitScaffoldState();
}

class _LitScaffoldState extends State<LitScaffold>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    if (widget.snackBar != null) {
      widget.snackBar!.controller!.init(this);
    }
    if (widget.collapsibleCard != null) {
      widget.collapsibleCard!.controller.init(this);
    }

    if (widget.settingsPanel != null) {
      widget.settingsPanel!.controller.init(this);
    }
  }

  @override
  void dispose() {
    if (widget.snackBar != null) {
      widget.snackBar!.controller!.dispose();
    }

    if (widget.collapsibleCard != null) {
      widget.collapsibleCard!.controller.dispose();
    }

    if (widget.settingsPanel != null) {
      widget.settingsPanel!.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget _body = _LitScaffoldBody(appBar: widget.appBar, body: widget.body);
    Widget _stack = Stack(
      children: [
        widget.settingsPanel != null
            ? InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.settingsPanel!.controller.isShown) {
                    widget.settingsPanel!.controller.dismissSettingsPanel();
                  }
                },
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        _body,
                        SettingsPanelBackgroundOverlay(
                            controller: widget.settingsPanel!.controller)
                      ],
                    )),
              )
            : _body,
        widget.appBar ?? SizedBox(),
        widget.infoBar ?? SizedBox(),
        widget.collapsibleCard ?? SizedBox(),
        widget.snackBar ?? SizedBox(),
        widget.actionButton ?? SizedBox(),
        widget.settingsPanel ?? SizedBox(),
      ],
    );
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: widget.wrapInSafeArea ? SafeArea(child: _stack) : _stack,
    );
  }
}

/// The [LitScaffold]'s body [Widget].
///
/// Depending on the provided [CustomAppBar] the [Padding] should be adjusted.
class _LitScaffoldBody extends StatelessWidget {
  final Widget body;
  final CustomAppBar? appBar;

  const _LitScaffoldBody({
    Key? key,
    required this.body,
    required this.appBar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return appBar != null &&
            !(appBar is LitBlurredAppBar) &&
            !(appBar is FixedOnScrollAppbar)
        ? Padding(
            padding: const EdgeInsets.only(top: CustomAppBar.height),
            child: body,
          )
        : body;
  }
}
