//
//  MovieViewController.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

protocol MovieViewControllerProtocol: AnyObject {
    /// Обновление информации о фильмах
    /// - Parameter movies: список фильмов в формате презентации
    func updateMovies(_ movies: [MovieModel])
}

protocol MovieViewControllerDelegate: AnyObject {
    /// Открытие профиля
    func didTapProfileButton()
    /// Открытие DetailsView с детальной информацией о фильме
    func didTapMovie(movieInfo: MovieModel)
}

final class MovieViewController: UIViewController {
    
    weak var delegate: MovieViewControllerDelegate?
    private var presenter: MoviePresenterProtocol?
    private let detailsView = DetailsMovieView()
    private var movieInfo: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie Browser"
        view.backgroundColor = UIColor.background
        self.navigationController?.navigationBar.backgroundColor = UIColor.background
        
        presenter = MoviePresenter(movieViewController: self)
        getMovieInfo()
        configureView()
        
        moviesCollectionView.reloadData()
    }
    
    // MARK: - Right and Left BarItems
    private func configureRightBarItem() {
        let item = UIBarButtonItem(image: UIImage.init(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = item
        navigationItem.rightBarButtonItem?.tintColor = UIColor.title
    }
    
    private func configureLeftBarItem() {
        let item = UIBarButtonItem(image: UIImage.init(systemName: "person.crop.circle"), style: .done, target: self, action: #selector(profileButtonTapped(_:)))
        navigationItem.leftBarButtonItem = item
        navigationItem.leftBarButtonItem?.tintColor = UIColor.title
    }
    
    private let moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = UIColor.background
        
        return collectionView
    }()
    
    /// Действие для кнопки поиска
    @objc private func searchButtonTapped() {
        presenter?.searchButtonTapped()
    }
    
    /// Открытие профиля (side-menu)
    @objc private func profileButtonTapped(_ sender: UIBarButtonItem) {
        delegate?.didTapProfileButton()
    }
}

// MARK: - CollectionView extension
extension MovieViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movieDetails = movieInfo[indexPath.row]
        cell.set(movie: movieDetails)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: 320)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetails = movieInfo[indexPath.row]
        delegate?.didTapMovie(movieInfo: movieDetails)
    }
}

// MARK: - Updating Data protocol extension
extension MovieViewController: MovieViewControllerProtocol {
    
    func updateMovies(_ movies: [MovieModel]) {
            movieInfo = movies
            moviesCollectionView.reloadData()
    }
}


private extension MovieViewController {
    
    func getMovieInfo(){
        presenter?.getMovies()
    }
    
    func configureView(){
        moviesCollectionView.delegate = self
        moviesCollectionView.dataSource = self
        
        configureRightBarItem()
        configureLeftBarItem()
        
        view.addSubview(moviesCollectionView)
        
        setConstraints()
    }
    
    // MARK: - Constraints
    func setConstraints() {
        
        moviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moviesCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
