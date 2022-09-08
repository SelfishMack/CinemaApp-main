//
//  MovieData.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import Foundation

 // https://www.omdbapi.com/?apikey=e1b20f1b&t=interstellar

struct MovieData: Decodable {
    let title: String
    let year: String
    let genre: String
    let runtime: String
    let poster: String
    let ratings: [Ratings]
    let rated: String
    let director: String
    let actors: String
    let plot: String
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case runtime = "Runtime"
        case poster = "Poster"
        case rated = "Rated"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case ratings = "Ratings"
    }
    
    

    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        year = try container.decode(String.self, forKey: .year)
        genre = try container.decode(String.self, forKey: .genre)
        runtime = try container.decode(String.self, forKey: .runtime)
        poster = try container.decode(String.self, forKey: .poster)
        ratings = try container.decode([Ratings].self, forKey: .ratings)
        rated = try container.decode(String.self, forKey: .rated)
        director = try container.decode(String.self, forKey: .director)
        actors = try container.decode(String.self, forKey: .actors)
        plot = try container.decode(String.self, forKey: .plot)
    }
}

struct Ratings: Codable {
    let value: String

    enum CodingKeys: String, CodingKey {
        case value = "Value"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        value = try container.decode(String.self, forKey: .value)
    }
}


