//
//  Movie.swift
//  TPMFlix
//
//  Created by Samman Thapa on 1/6/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var posterUrl: URL?
    var description: String = ""
    var releaseDate: String = ""
    var backDropUrl: URL?
    var idString: String = ""
    var urlWithAuth: String
    var vote_average: NSNumber?
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        description = dictionary["overview"] as? String ?? "No description"
        vote_average = dictionary["vote_average"] as? NSNumber
        
        let poster_base_url = "https://image.tmdb.org/t/p/w500"
        if let poster_path = dictionary["poster_path"] as! String? {
            posterUrl = URL(string: poster_base_url + poster_path)!
        } else {
            self.posterUrl = URL(string: "")
        }
        
        releaseDate = (dictionary["release_date"] as? String)!
        
        let backdrop_path = dictionary["backdrop_path"] as! String
        backDropUrl = URL (string: poster_base_url + backdrop_path)!
        
        idString = "\(dictionary["id"]!)"
        urlWithAuth = "https://api.themoviedb.org/3/movie/\(idString)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        
        // Set the rest of the properties
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
