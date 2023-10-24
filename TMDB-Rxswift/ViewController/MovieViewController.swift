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

class MovieViewController: UIViewController, Storyboadable, UITableViewDelegate {
    
    @IBOutlet weak var tagView: UIView!
    @IBOutlet weak var tblMovieList: UITableView!
    
    var searchId: Driver<String>?
    
    private var viewModel: MoviePresentable!
    var viewModelBuilder: MoviePresentable.ViewModelBuilder!
    
    private let bag = DisposeBag()
    
    var tags: [TagModel] = [
        TagModel(id: MoviePageType.popular.rawValue, title: "Popular Movies", isSelected: false),
        TagModel(id: MoviePageType.upcoming.rawValue, title: "Upcoming Movies", isSelected: false),
        TagModel(id: MoviePageType.top_rated.rawValue, title: "Top Rated Movies", isSelected: false)
    ]
    
    var movieTypeEnum: MoviePageType = .popular
        
    // Button Tap States
    typealias PopularButtonTapState = (popularButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var popularButtonTap: PopularButtonTapState = (popularButtonTapState: BehaviorRelay<Void>(value: ()), ())

    typealias UpcomingButtonTapState = (upcomingButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var upcomingButtonTap: UpcomingButtonTapState = (upcomingButtonTapState: BehaviorRelay<Void>(value: ()), ())
    
    typealias TopRatedButtonTapState = (topRatedButtonTapState: BehaviorRelay<Void>, ())
    fileprivate var topRatedButtonTap: TopRatedButtonTapState = (topRatedButtonTapState: BehaviorRelay<Void>(value: ()), ())
    
    // DataSource
    let dataSource = RxTableViewSectionedReloadDataSource<MovieItemsSection>(
        configureCell: { (dataSource, tableView, indexPath, item) in
            // Configure the cell with the item
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesTableViewCell", for: indexPath) as? MoviesTableViewCell {
                cell.configure(usingViewModel: item)
                return cell
            }
            
            return UITableViewCell()
        }
    )
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        viewModel = viewModelBuilder((popularButtonTap: popularButtonTap.popularButtonTapState.asObservable(),
                                      upcomingButtonTap: upcomingButtonTap.upcomingButtonTapState.asObservable(),
                                      topRateButtonTap: topRatedButtonTap.topRatedButtonTapState.asObservable(),
                                      movieSelected: tblMovieList.rx.modelSelected(MovieTableViewModel.self).asDriver()))
        
        configureSwiftUI()
        setupUI()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }

}

extension MovieViewController {
    func setupUI() {
        
        self.navigationController?.navigationBar.topItem?.title = "Watch Now"
        
        tblMovieList.estimatedRowHeight = 150.0
        tblMovieList.rowHeight = UITableView().estimatedRowHeight
        
        tblMovieList.register(UINib(nibName: "MoviesTableViewCell", bundle: .main), forCellReuseIdentifier: "MoviesTableViewCell")
        
        viewModel
            .output
            .popularMoviesModel
            .bind(to: tblMovieList.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
}

extension MovieViewController: TapButtonDelegate {
    func didSelectTag(_ moviePageType: MoviePageType) {
        switch moviePageType {
        case .popular:
            print("`popular` called")
            tblMovieList.delegate = nil
            tblMovieList.dataSource = nil
            viewModel
                .output
                .popularMoviesModel
                .bind(to: tblMovieList.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        case .upcoming:
            print("`upcoming` called")
            tblMovieList.delegate = nil
            tblMovieList.dataSource = nil
            viewModel
                .output
                .upcomingMoviesModel
                .bind(to: tblMovieList.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        case .top_rated:
            print("`top_rated` called")
            tblMovieList.delegate = nil
            tblMovieList.dataSource = nil
            viewModel
                .output
                .topRateMoviesModel
                .bind(to: tblMovieList.rx.items(dataSource: dataSource))
                .disposed(by: bag)
        }
    }
}
