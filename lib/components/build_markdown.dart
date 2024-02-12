import 'package:flutter/material.dart';
import 'package:gemini_photex/components/code_wrapper.dart';
import 'package:gemini_photex/themes/night-owl.dart';
import 'package:markdown_widget/markdown_widget.dart';

class BuildMarkdown extends StatelessWidget {
  const BuildMarkdown({super.key, required this.data});
  final String? data;

  @override
  Widget build(BuildContext context) {
    codeWrapper(child, text, language) =>
        CodeWrapperWidget(child, text, language);
    return MarkdownWidget(
      data: data!,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      config: MarkdownConfig(configs: [
        PreConfig.darkConfig
            .copy(wrapper: codeWrapper, theme: nightOwlTheme)
      ]),
    );
  }
}