//
//  PosterCell.swift
//  flix_codepath
//
//  Created by SiuChun Kung on 9/6/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        didSet {
            self.posterImageView.af_setImage(withURL: movie.posterUrl!)
        }
    }
}
