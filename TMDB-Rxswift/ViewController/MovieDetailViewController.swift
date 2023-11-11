//
//  MovieDetailTableViewController.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 22/10/2023.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class MovieDetailViewController: UIViewController, Storyboadable {

    @IBOutlet weak var movieDetailTableView: UITableView!
    
    fileprivate var bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }
    
    fileprivate func setupUI() {
        movieDetailTableView.register(UINib(nibName: "ImageViewTableViewCell", bundle: .main), forCellReuseIdentifier: "ImageViewTableViewCell")
        movieDetailTableView.register(UINib(nibName: "RatingTableViewCell", bundle: .main), forCellReuseIdentifier: "RatingTableViewCell")
        movieDetailTableView.register(UINib(nibName: "MovieDescriptionTableViewCell", bundle: .main), forCellReuseIdentifier: "MovieDescriptionTableViewCell")
    }
}
