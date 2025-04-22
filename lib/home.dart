import 'package:flutter/material.dart';
import 'package:news_app/common/dao/NewsDao.dart';
import 'package:news_app/common/model/TopHeadlines.dart';
import 'package:news_app/detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
	static const String routeName = 'home';

	@override
	State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with SingleTickerProviderStateMixin {
	TabController? _tabController;
	TopHeadlines? _topHeadlines;
	final List<String> categories = ['Business', 'Entertainment', 'General', 'Health', 'Science', 'Sports', 'Technology'];
	final List<Tab> defaultTabs = [];
	bool _isLoading = false;

	Future<void> getAllHeadLines(String category) async {
		setState(() => _isLoading = true);

		try {
			final res = await NewsDao.getAllHeadLines(category);
			if (res.status && mounted) {
				setState(() {
					_topHeadlines = res.data;
					_isLoading = false;
				});
			}
		} catch (e) {
			if (mounted) {
				setState(() => _isLoading = false);
			}
			// Consider showing an error message to the user
			debugPrint('Error fetching headlines: $e');
		}
	}

	@override
	void initState() {
		super.initState();
		defaultTabs.addAll(categories.map((category) => Tab(text: category)));
		_tabController = TabController(length: defaultTabs.length, vsync: this);
		getAllHeadLines(categories.first);
	}

	@override
	void dispose() {
		_tabController?.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: const Text('News Watch'),
				actions: <Widget>[
					IconButton(
						icon: const Icon(Icons.search, color: Colors.white),
						onPressed: () => Navigator.of(context).pushReplacementNamed('detail'),
					)
				],
				bottom: TabBar(
					controller: _tabController,
					tabs: defaultTabs,
					isScrollable: true,
					indicatorColor: Colors.white,
					indicatorWeight: 3.0,
					onTap: (index) {
						setState(() => _topHeadlines = null);
						getAllHeadLines(categories[index]);
					},
				),
			),
			body: TabBarView(
				controller: _tabController,
				children: defaultTabs.map((Tab tab) {
					if (_isLoading || _topHeadlines == null) {
						return const Center(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[
									SpinKitDoubleBounce(
										color: Colors.blue,
										size: 50.0,
									),
									SizedBox(height: 16),
									Text('Loading...'),
								],
							),
						);
					}

					return ListView.builder(
						padding: const EdgeInsets.all(12.0),
						itemCount: _topHeadlines!.articles?.length,
						itemBuilder: (BuildContext context, int index) {
							final article = _topHeadlines!.articles?[index];
							final publishedDate = article?.publishedAt?.toLocal() ?? DateTime.now();

							return Card(
								elevation: 2,
								shape: RoundedRectangleBorder(
									borderRadius: BorderRadius.circular(4),
								),
								child: InkWell(
									onTap: () {
										Navigator.push(
											context,
											MaterialPageRoute(
												builder: (context) => Detail(article?.title ?? 'No title', article?.url ?? ''),
											),
										);
									},
									child: Column(
										mainAxisSize: MainAxisSize.max,
										children: <Widget>[
											Container(
												height: 140,
												color: Colors.grey[200],
												child: FadeInImage.memoryNetwork(
													width: double.infinity,
													fit: BoxFit.cover,
													placeholder: kTransparentImage,
													image: article?.urlToImage ?? 'assets/images/news_presenter.png',
													imageErrorBuilder: (context, error, stackTrace) =>
															Image.asset('assets/images/news_presenter.png', fit: BoxFit.cover),
												),
											),
											Padding(
												padding: const EdgeInsets.all(8),
												child: Text(
													article?.title ?? 'No title available',
													style: const TextStyle(
														fontSize: 18,
														fontWeight: FontWeight.w500,
														color: Color(0xFF3D3D41),
													),
												),
											),
											Padding(
												padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
												child: Row(
													mainAxisAlignment: MainAxisAlignment.spaceBetween,
													children: <Widget>[
														Text(
															article?.source?.name ?? 'Unknown source',
															style: const TextStyle(
																fontSize: 12,
																color: Color(0xFF92969F),
															),
														),
														Text(
															'${DateFormat.MMMMEEEEd().format(publishedDate)} ${DateFormat.jm().format(publishedDate)}',
															style: const TextStyle(
																	fontSize: 12,
																	color: Colors.grey),
														),
													],
												),
											),
										],
									),
								),
							);
						},
					);
				}).toList(),
			),
		);
	}
}