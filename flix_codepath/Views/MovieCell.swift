//
//  MovieCell.swift
//  flix_codepath
//
//  Created by SiuChun Kung on 9/2/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    var movie : Movie! {
        didSet {
            
            self.overviewLabel.text = movie.description
            
            self.titleLabel.text = movie.title
            
            self.posterImageView.af_setImage(withURL: (movie.posterUrl)!)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.clipsToBounds = true
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
        
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.preferredMaxLayoutWidth = titleLabel.frame.size.width
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
