//
//  ContainerViewController.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

final class ContainerViewController: UIViewController {
    
    private let profileViewController = ProfileViewController()
    private let movieViewController = MovieViewController()
    private let detailsView = DetailsMovieView()
    private var navigationViewController = UINavigationController()
    private let darkView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVCs()
    }
}

extension ContainerViewController: MovieViewControllerDelegate{
    /// openning the side-menu
    func didTapProfileButton() {
        // Animate the side-menu
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) { [self] in
            self.navigationViewController.view.frame.origin.x = self.movieViewController.view.frame.size.width - 70
            darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            darkView.frame = self.navigationViewController.view.bounds
            navigationViewController.view.addSubview(darkView)
        }
    }
    
    /// open detailsView and pass data
    /// - Parameter movieInfo: info about movie to present
    func didTapMovie(movieInfo: MovieModel) {
        detailsView.setInfo(movieInfo: movieInfo)
        
        detailsView.frame = navigationViewController.view.bounds
        navigationViewController.view.addSubview(detailsView)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        darkView.frame = self.navigationViewController.view.bounds
        navigationViewController.view.addSubview(darkView)
        navigationViewController.view.bringSubviewToFront(detailsView)
        configureView()
        
        setCostraints()
    }
    
    /// adding GestureRecognizer to detailsView
    private func configureView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeDetailsView))
        detailsView.addGestureRecognizer(tap)
    }
}

extension ContainerViewController: ProfileViewControllerDelegate{
    /// closing the side-menu
    func closeProfile() {
        // Animate the side-menu
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) { [self] in
            self.navigationViewController.view.frame.origin.x = 0
            darkView.removeFromSuperview()
        }
    }
}

private extension ContainerViewController{
    
    /// configure views
    func addChildVCs() {
        // profile
        profileViewController.delegate = self
        addChild(profileViewController)
        view.addSubview(profileViewController.view)
        profileViewController.didMove(toParent: self)
        
        // movie screen
        movieViewController.delegate = self
        let navigationVC = UINavigationController(rootViewController: movieViewController)
        addChild(navigationVC)
        view.addSubview(navigationVC.view)
        navigationVC.didMove(toParent: self)
        self.navigationViewController = navigationVC
    }
    
    func setCostraints() {
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            detailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            detailsView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25)
            
        ])
    }
    /// hiding view when tap
    @objc func removeDetailsView() {
        detailsView.removeFromSuperview()
        darkView.removeFromSuperview()
    }
}

