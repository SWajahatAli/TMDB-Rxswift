//
//  MoviesTableViewCell.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 08/10/2023.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(usingViewModel model: MovieTablePresentable) {
        self.movieName.text = model.title
        self.movieDescription.text = model.description
    }
}
