import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticketz/providers/search_provider.dart';

class ParticipantSearchBar extends StatefulWidget {
  const ParticipantSearchBar({
    super.key,
  });

  @override
  State<ParticipantSearchBar> createState() => _ParticipantSearchBarState();
}

class _ParticipantSearchBarState extends State<ParticipantSearchBar> {
  TextEditingController? queryController;
  SearchProvider? searchProvider;

  @override
  void initState() {
    super.initState();
    searchProvider = Provider.of<SearchProvider>(
      context,
      listen: false,
    );
    queryController = TextEditingController(text: searchProvider!.query);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20.0,
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            padding: const EdgeInsets.only(right: 16),
            constraints: const BoxConstraints(),
            onPressed: () {
              final SearchProvider searchProvider =
                  Provider.of<SearchProvider>(context, listen: false);
              searchProvider.clearQuery();
              searchProvider.disableSearch();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: queryController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    queryController!.clear();
                    searchProvider!.clearQuery();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (value) {
                searchProvider!.setQuery(value);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    queryController!.dispose();
    super.dispose();
  }
}
