//
//  MovieApiManager.swift
//  TPMFlix
//
//  Created by Samman Thapa on 1/6/18.
//  Copyright © 2018 Samman Thapa. All rights reserved.
//

import Foundation

import Alamofire

class MovieApiManager {
    
    let urlWithAuth: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    let urlSuperhero: String = "https://api.themoviedb.org/3/movie/363088/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    
    func getNowPlayingMovies (completion: @escaping ([Movie]?, Error?) -> ()) {
        Alamofire.request(urlWithAuth).responseJSON { (response) in
            if let err = response.error {
                
                completion(nil, err)
                
            } else {
                let res = response.result.value! as! NSDictionary
                let movies = Movie.movies(dictionaries: (res["results"] as? [NSDictionary])! as! [[String : Any]])
                
                completion(movies, nil)
            }
        }
    }
    func getSuperheroMovies (completion: @escaping ([Movie]?, Error?) -> ()) {
        Alamofire.request(urlSuperhero).responseJSON { (response) in
            if let err = response.error {
                
                completion(nil, err)
                
            } else {
                let res = response.result.value! as! NSDictionary
                let movies = Movie.movies(dictionaries: (res["results"] as? [NSDictionary])! as! [[String : Any]])
                
                completion(movies, nil)
            }
        }
    }

}
