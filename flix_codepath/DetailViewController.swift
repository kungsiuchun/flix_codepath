//
//  DetailViewController.swift
//  flix_codepath
//
//  Created by SiuChun Kung on 9/7/18.
//  Copyright © 2018 SiuChun Kung. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController
{
    
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
   
    var movie: Movie?
    var trailerURLString: String = ""

    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Details"
        super.viewDidLoad()
        
        if let movie = self.movie {
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.description
            self.releaseDate.text = movie.releaseDate
            self.backDropImageView.af_setImage(withURL: movie.backDropUrl!)
            self.posterImageView.af_setImage(withURL: movie.posterUrl!)
            self.voteAverage.text = movie.vote_average?.stringValue
            // make a network call to get youtube key. bad location, but hack for now
            //            activityIndicator.startAnimating()
            //            Alamofire.request(movie.urlWithAuth).responseJSON { (response) in
            //                let res = response.result.value! as! NSDictionary
            //                if let allVideos = res["results"] as? [NSDictionary] {
            //                    let trailerKey = allVideos[0]["key"] as! String
            //                    self.trailerURLString = "https://www.youtube.com/watch?v=\(trailerKey)"
            //                }
            //                self.activityIndicator.stopAnimating()
            //            }
        }
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
