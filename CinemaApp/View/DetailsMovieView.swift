//
//  DatailMovieViewController.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

final class DetailsMovieView: UIView {
    
    private let ratingsDisplay = [
        "★☆☆☆☆",
        "★★☆☆☆",
        "★★★☆☆",
        "★★★★☆",
        "★★★★★"
    ]
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// get info from ContainerViewController and set to labels
    /// - Parameter movieInfo: info about movie to present
    func setInfo(movieInfo: MovieModel) {
        nameLabel.text = movieInfo.title
        starRating.text = ratingsDisplay[(Int(Double(movieInfo.ratings) ?? 8))/2 - 1]
        runtimeLabel.text = movieInfo.runtime[1]
        ageRatingImageView.image = UIImage(named: "\(movieInfo.rated).image")
        genreInfoLabel.text = movieInfo.genre
        directorsInfoLabel.text = movieInfo.directors
        starsInfoLabel.text = movieInfo.actors
        plotLabel.text = movieInfo.plot
        
        getPosterImage(posterURL: movieInfo.poster, imageView: posterImage)
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let runtimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.text = "112 min"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let starRating: UILabel = {
        let label = UILabel()
        label.text = "★★★☆☆"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Green Book"
        label.textColor = UIColor.title
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let posterImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private let ageRatingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "R.image")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Genre Stack
    private let genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.title
        label.text = "Genre"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let genreInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.text = "Crime, Drama"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    // MARK: - Directors Stack
    private let directorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let directorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.title
        label.text = "Directors"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let directorsInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.text = "Christopher Nolan"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    // MARK: - Stars Stack
    private let starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.title
        label.text = "Stars"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let starsInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.text = "Matthew McConaughey, Anne Hathaway, Jessica Chastain"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        return label
    }()
    
    private let plotLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.text = "plot"
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateMask()
        drawDashedLine()
    }
}

private extension DetailsMovieView {
    // MARK: - Load image by URL
    func getPosterImage(posterURL: String, imageView: UIImageView){
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

    func configureView() {
        backgroundColor = UIColor.background
        layer.cornerRadius = 5
        
        stackView.addSubview(runtimeLabel)
        stackView.addSubview(starRating)
        addSubview(stackView)
        addSubview(nameLabel)
        addSubview(posterImage)
        addSubview(ageRatingImageView)
        
        genreStackView.addSubview(genreLabel)
        genreStackView.addSubview(genreInfoLabel)
        addSubview(genreStackView)
        
        directorsStackView.addSubview(directorsLabel)
        directorsStackView.addSubview(directorsInfoLabel)
        addSubview(directorsStackView)
        
        starsStackView.addSubview(starsLabel)
        starsStackView.addSubview(starsInfoLabel)
        addSubview(starsStackView)
        
        addSubview(plotLabel)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: stackView.centerYAnchor, constant: 15),
            runtimeLabel.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -70),

            starRating.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            starRating.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            
            nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            posterImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            posterImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImage.heightAnchor.constraint(equalToConstant: 200),
            
            ageRatingImageView.heightAnchor.constraint(equalToConstant: 40),
            ageRatingImageView.topAnchor.constraint(equalTo: posterImage.topAnchor, constant: 10),
            ageRatingImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            
            // genre
            genreStackView.topAnchor.constraint(equalTo: posterImage.bottomAnchor, constant: 40),
            
            genreLabel.topAnchor.constraint(equalTo: genreStackView.topAnchor),
            genreLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            
            genreInfoLabel.topAnchor.constraint(equalTo: genreStackView.topAnchor),
            genreInfoLabel.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 10),
            
            // directors
            directorsStackView.topAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 30),
            
            directorsLabel.topAnchor.constraint(equalTo: directorsStackView.topAnchor),
            directorsLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            
            directorsInfoLabel.topAnchor.constraint(equalTo: directorsStackView.topAnchor),
            directorsInfoLabel.leadingAnchor.constraint(equalTo: directorsLabel.trailingAnchor, constant: 10),
            directorsInfoLabel.trailingAnchor.constraint(equalTo: directorsStackView.trailingAnchor, constant: -20),
            
            // stars
            starsStackView.topAnchor.constraint(equalTo: directorsStackView.bottomAnchor, constant: 30),
            starsStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starsStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            starsLabel.topAnchor.constraint(equalTo: starsStackView.topAnchor),
            starsLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            
            starsInfoLabel.topAnchor.constraint(equalTo: starsStackView.topAnchor),
            starsInfoLabel.leadingAnchor.constraint(equalTo: starsLabel.trailingAnchor, constant: 10),
            starsInfoLabel.trailingAnchor.constraint(equalTo: starsStackView.trailingAnchor, constant: -10),
            
            // plot
            plotLabel.topAnchor.constraint(equalTo: starsStackView.bottomAnchor, constant: 60),
            plotLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            plotLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            plotLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20)
        ])
    }
    
    /// draw dashed line (- - - -)
    func drawDashedLine() {
        //Create a CAShapeLayer
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.dashedLine.cgColor
        shapeLayer.lineWidth = 3
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [2,3]

        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 453),
                                CGPoint(x: self.frame.width, y: 453)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func updateMask() {
        let path = UIBezierPath()
        path.move(to: bounds.origin)
        let center = CGPoint(x: bounds.midX, y: bounds.minY)
        path.addArc(withCenter: center, radius: 25, startAngle: .pi, endAngle: 0, clockwise: false)
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
        path.addLine(to: CGPoint(x: bounds.minX, y: bounds.maxY))
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
