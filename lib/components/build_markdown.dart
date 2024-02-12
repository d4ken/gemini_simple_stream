import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gemini_photex/components/code_wrapper.dart';
import 'package:markdown_widget/markdown_widget.dart';
import '../themes/atome-one-dark.dart';

class BuildMarkdown extends StatelessWidget {
  const BuildMarkdown({super.key, required this.data});

  final String? data;

  @override
  Widget build(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDark = brightness == Brightness.dark;
    codeWrapper(child, text, language) =>
        CodeWrapperWidget(child, text, language);
    return MarkdownWidget(
      data: data!,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      config: MarkdownConfig(configs: [
        PreConfig.darkConfig
            .copy(wrapper: codeWrapper, theme: atomOneDarkTheme)
        // isDark
        //     ? PreConfig.darkConfig
        //         .copy(wrapper: codeWrapper, theme: atomOneDarkTheme)
        //     : const PreConfig()
        //         .copy(wrapper: codeWrapper, theme: atomOneLightTheme)
      ]),
    );
  }
}
