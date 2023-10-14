//
//  MovieItemCollectionViewCell.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 13/10/2023.
//

import UIKit

class MovieItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var btn_bookmark: UIButton!
    @IBOutlet weak var lbl_movie_name: UILabel!
    @IBOutlet weak var year_of_release: UILabel!
    @IBOutlet weak var view_rating: UIView!
    @IBOutlet weak var movie_description: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
