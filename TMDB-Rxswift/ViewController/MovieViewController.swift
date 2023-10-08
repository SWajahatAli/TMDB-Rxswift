//
//  MoviesViewController.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 30/09/2023.
//

import UIKit
import RxCocoa
import RxSwift
import SwiftUI
import RxDataSources

enum MoviePageType: Int, CaseIterable {
    case popular = 1
    case upcoming
    case top_rated
}

class MovieViewController: UIViewController, Storyboadable {
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tblMovieList: UITableView!
    
    var searchId: Driver<String>?
    
    private var viewModel: MoviePresentable!
    var viewModelBuilder: MoviePresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    var tags: [TagModel] = [
        TagModel(id: MoviePageType.popular.rawValue, title: "Popular Movies", isSelected: false),
        TagModel(id: MoviePageType.upcoming.rawValue, title: "Upcoming Movies", isSelected: true),
        TagModel(id: MoviePageType.top_rated.rawValue, title: "Top Rated Movies", isSelected: true)
    ]
    
    var movieTypeEnum: MoviePageType = .popular
    
    // Define a computed property to access the observable
    typealias MovieTypeState = (movieType: BehaviorRelay<Int>, ())
    fileprivate var movieTypeObservable: MovieTypeState = (movieType: BehaviorRelay<Int>(value: 0), ())
    
    // Button Tap States
    typealias PopularButtonTapState = (popularButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var popularButtonTap: PopularButtonTapState = (popularButtonTapState: BehaviorRelay<Void>(value: ()), ())

    typealias UpcomingButtonTapState = (upcomingButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var upcomingButtonTap: UpcomingButtonTapState = (upcomingButtonTapState: BehaviorRelay<Void>(value: ()), ())
    
    typealias TopRatedButtonTapState = (topRatedButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var topRatedButtonTap: TopRatedButtonTapState = (topRatedButtonTapState: BehaviorRelay<Void>(value: ()), ())
    
    // DataSource
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<MovieItemsSection> { ds, tblView, _, item in
        return UITableViewCell()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel = viewModelBuilder((popularButtonTap: popularButtonTap.popularButtonTapState.asObservable(),
                                      upcomingButtonTap: upcomingButtonTap.upcomingButtonTapState.asObservable(),
                                      topRateButtonTap: topRatedButtonTap.topRatedButtonTapState.asObservable()))
        
        configureSwiftUI()
        bindingUI()
    }
    
    func configureSwiftUI() {
        // Create a SwiftUI view with the tags
        let tagButtonView = TagButtonView(viewModel: viewModel, tags: tags, delegate: self)
        
        // Create a UIHostingController and set the SwiftUI view as its root view
        let hostingController = UIHostingController(rootView: tagButtonView)
        
        // Add the UIHostingController's view to the UIKit view hierarchy
        addChild(hostingController)
        tagView.addSubview(hostingController.view)
        
        // Configure layout constraints as needed
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: tagView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: tagView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: tagView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: tagView.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
}

extension MovieViewController {
    func bindingUI() {
        self.viewModel.output.popularMoviesModel.subscribe { popularMovieResponseModel in
            //
        }
        
        self.viewModel.output.upcomingMoviesModel.subscribe { upcomingMoviesModelResponse in
            //
        }
        
        self.viewModel.output.topRateMoviesModel.subscribe { topRateMovieModelResponse in
            //
        }
    }
}

extension MovieViewController: TapButtonDelegate {
    func didSelectTag(_ moviePageType: MoviePageType) {
        switch moviePageType {
        case .upcoming:
            print("`upcoming` called")
            upcomingButtonTap.upcomingButtonTapState.accept(())
        case .top_rated:
            print("`top_rated` called")
            topRatedButtonTap.topRatedButtonTapState.accept(())
        case .popular:
            print("`popular` called")
            popularButtonTap.popularButtonTapState.accept(())
        }
    }
}
