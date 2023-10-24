//
//  RatingTableViewCell.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 22/10/2023.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var genreView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
