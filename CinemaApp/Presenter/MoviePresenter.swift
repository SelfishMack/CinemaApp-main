//
//  MoviePresenter.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

protocol MoviePresenterProtocol{
    /// Получение фильмов
    func getMovies()
    /// Открытие поиска
    func searchButtonTapped()
}

/// Презенетер листа с фильмами
final class MoviePresenter{
    
    private weak var movieViewController: MovieViewControllerProtocol?
    private var model: ModelProtocol
    private var moviesArray: [MovieModel] = []
    
    init(movieViewController: MovieViewControllerProtocol?, model: ModelProtocol = Model()) {
        self.model = model
        self.movieViewController = movieViewController
    }
}

extension MoviePresenter: MoviePresenterProtocol{
    
    func getMovies() {
        model.getMovies { [weak self] movie in
            guard let self = self else { return }
            movie.forEach { movie in
                self.moviesArray.append(self.convertValues(movie: movie))
            }
                self.movieViewController?.updateMovies(self.moviesArray)
        }
    }
    
    func searchButtonTapped() {
        print("SearchButtonTapped")
    }
}

private extension MoviePresenter{
    
    /// Изменение данных для удобной презентации
    /// - Parameter movie: Данные о фильме в формате сервера
    /// - Returns: Данные о фильме в формате презентации
    private func convertValues(movie: MovieData) -> MovieModel{
        
        // get part only with digits. For example from "160 min" we take only "160"
        let digitPartRuntime = Int(movie.runtime.components(separatedBy: " ")[0])
        
        // get part only with rating. For example form "8.6/10" we take only "8.6"
        
        let firstPartOfRating = movie.ratings[0].value.components(separatedBy: "/")[0]
        
        var runtime = movie.runtime
        
        if let digitPartRuntime = digitPartRuntime {
            
            let hours = digitPartRuntime / 60
            let mins = digitPartRuntime % 60
            runtime = "\(hours)h \(mins)min"
            
        }
        return MovieModel(title: movie.title,
                          genre: movie.genre,
                          year: movie.year,
                          runtime: [runtime, movie.runtime],
                          ratings: firstPartOfRating,
                          poster: movie.poster,
                          rated: movie.rated,
                          directors: movie.director,
                          actors: movie.actors,
                          plot: movie.plot)
    }
}

