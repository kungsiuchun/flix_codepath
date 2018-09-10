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
    
    var movies: [String: Any]?
    var myTitle: String = ""
    var overView: String = ""
    var Date: String = ""
    var posterUrl: URL?
    var backDropUrl: URL?
    var vote_average: NSNumber?
    
    var trailerURLString: String = ""

    
    
    override func viewDidLoad() {
        self.navigationItem.title = "Details"
        super.viewDidLoad()
        
        titleLabel?.text = myTitle
        overviewLabel?.text = overView
        releaseDate?.text = Date
      
        voteAverage?.text = vote_average?.stringValue
        
        posterImageView.af_setImage(withURL: posterUrl!)
        backDropImageView.af_setImage(withURL: backDropUrl!)
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}
