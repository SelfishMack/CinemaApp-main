//
//  MovieCollectionViewCell.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

final class MovieCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let infoBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.infoBackground
        view.alpha = 0.95
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "The Godfather"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.text = "Crime, Drama"
        label.font = UIFont.systemFont(ofSize: 10)
        
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.text = "Crime, Drama"
        label.font = UIFont.systemFont(ofSize: 10)
        
        return label
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "2h 20min"
        label.font = UIFont.systemFont(ofSize: 10)
        
        return label
    }()
    
    private let ratingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.fill")
        image.tintColor = UIColor.systemOrange
        
        return image
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "9.0"
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    
    func set(movie: MovieModel) {
        nameLabel.text = movie.title
        genreLabel.text = "\(movie.genre) ·"
        yearLabel.text = movie.year
        runtimeLabel.text = movie.runtime[0]
        ratingLabel.text = movie.ratings
        
        getPosterImage(posterURL: movie.poster, imageView: posterImage)
    }
    
    // MARK: - Load image by URL
    private func getPosterImage(posterURL: String, imageView: UIImageView) {
        if let url = URL(string: posterURL) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
            task.resume()
        }
    }
    
    private func configureView() {
        addSubview(posterImage)
        addSubview(infoBackground)
        addSubview(nameLabel)
        addSubview(genreLabel)
        addSubview(yearLabel)
        addSubview(runtimeLabel)
        addSubview(ratingImage)
        addSubview(ratingLabel)
    }
    
    // MARK: - Constraints
    override func layoutSubviews() {
        super.layoutSubviews()

        posterImage.frame = CGRect(x: 0,
                              y: 0,
                              width: contentView.frame.size.width,
                              height: frame.size.height)
        
        infoBackground.frame = CGRect(x: 0,
                                      y: frame.size.height - frame.size.height / 4.5,
                              width: contentView.frame.size.width,
                                      height: frame.size.height / 4.5)
        
        nameLabel.frame = CGRect(x: 4,
                                 y: frame.size.height - frame.size.height / 4.5 + 8,
                                 width: contentView.frame.size.width,
                                 height: 14)

        genreLabel.frame = CGRect(x: 4,
                                 y: frame.size.height - frame.size.height / 4.5 + 26,
                                 width: contentView.frame.size.width - 40,
                                 height: 10)

        yearLabel.frame = CGRect(x: genreLabel.intrinsicContentSize.width + 6,
                                 y: frame.size.height - frame.size.height / 4.5 + 26,
                                 width: contentView.frame.size.width - genreLabel.frame.size.width,
                                 height: 10)
        
        runtimeLabel.frame = CGRect(x: 4,
                                 y: frame.size.height - frame.size.height / 4.5 + 52,
                                 width: contentView.frame.size.width - 60,
                                 height: 10)
        
        
        ratingImage.frame = CGRect(x: contentView.frame.size.width - 45,
                                 y: frame.size.height - frame.size.height / 4.5 + 46,
                                   width: 15,
                                 height: 15)
        
        ratingLabel.frame = CGRect(x: ratingImage.intrinsicContentSize.width + 10 + runtimeLabel.frame.size.width,
                                 y: frame.size.height - frame.size.height / 4.5 + 50,
                                   width: 25,
                                 height: 10)
        
    }
}

