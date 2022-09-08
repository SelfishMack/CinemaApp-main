//
//  MovieManager.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import Foundation

// https://www.omdbapi.com/?apikey=e1b20f1b&t=interstellar

protocol MovieServiceProtocol {
    
    func getMovie(title: String, completionHandler: @escaping (MovieData?)  -> Void)
}

class MovieService: MovieServiceProtocol {
    
    func getMovie(title: String, completionHandler: @escaping (MovieData?) -> Void) {
        guard let url = URL(string: "https://www.omdbapi.com/?apikey=e1b20f1b&t=\(title)&plot=full") else {
            completionHandler(nil)
            return
        }

        getRequest(url: url) { data in
            guard let data = data,
                  let model = try? JSONDecoder().decode(MovieData.self, from: data)
            else {
                print("Error while decoding")
                completionHandler(nil)
                return
            }
            completionHandler(model)
        }
    }
}

private extension MovieService {
    
    func getRequest(url: URL, completion: @escaping (Data?)->Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil
            else{
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}

