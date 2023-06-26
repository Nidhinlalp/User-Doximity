import 'package:doximity/view/const/color/colors.dart';
import 'package:doximity/view_model/search/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchFeildInHome extends StatelessWidget {
  const SearchFeildInHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.only(
        right: 8,
        left: 16,
        bottom: 5,
        top: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kGrayColor600,
      ),
      child: TextField(
        controller: context.read<Search>().textEditingController,
        onChanged: (query) => context.read<Search>().searchFromFirebase(query),
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: kBlackColor900,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
        cursorHeight: 24,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
            color: kBlackColor900,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 24,
          ),
          hintText: 'Search doctor....',
          hintStyle: Theme.of(context).textTheme.headlineSmall,
          contentPadding: const EdgeInsets.only(bottom: 5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
