//
//  MoviesTableViewCell.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 24/10/2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitle_label: UILabel!
    @IBOutlet weak var movieDescription_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(usingViewModel model: MovieTablePresentable) {
        self.movieTitle_label.text = model.title
        self.movieDescription_label.text = model.description
    }
}
