//
//  MovieTableViewCell.swift
//  TheMovies
//
//  Created by zodiac on 30.01.2023.
//

import UIKit
import Kingfisher
import Hero

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var containerImageView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(title: String?, rate: String?, date: String?, posterPath: String?, index: Int) {
        // Used "original"
        posterImageView.kf.setImage(with: URL(string: posterPath ?? ""), placeholder: UIImage(named: "posterPlaceholder"))
        nameLabel.text = title
        rateLabel.text = "Vote Average: " + (rate ?? "-")
        dateLabel.text = date
        
        posterImageView.heroID = "\(index)" + "poster"
        nameLabel.heroID = "\(index)" + "title"
        heroID = "\(index)"
        
        posterImageView.applyshadowWithCorner(containerView: containerImageView, cornerRadious: 10.0)
    }

}
