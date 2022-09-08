//
//  ProfileViewController.swift
//  CinemaApp
//
//  Created by Владимир Макаров on 25.08.2022.
//

import UIKit

protocol ProfileViewControllerDelegate: AnyObject {
    /// closing profile side-menu
    func closeProfile()
}

final class ProfileViewController: UIViewController {
    
    weak var delegate: ProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.layer.cornerRadius = 20
        button.tintColor = UIColor.title
        button.backgroundColor = UIColor.backgroundLight
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.title
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.text = "Владимир Макаров"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.text = "Male | Born 05.04.1979"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "photo")
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.backgroundLight.cgColor
        imageView.layer.cornerRadius = 100
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        
        return imageView
    }()
    
    private let phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "+7(977) 571-97-90"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.text
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.text = "vm.selfish@yandex.ru"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    private let phoneButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light, scale: .large)
        button.setImage(UIImage(systemName: "phone", withConfiguration: config), for: .normal)
        button.backgroundColor = UIColor.backgroundLight
        button.tintColor = UIColor.title
        button.contentMode = .center
        button.layer.borderColor = UIColor.backgroundLight.cgColor
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light, scale: .large)
        button.setImage(UIImage(systemName: "envelope", withConfiguration: config), for: .normal)
        button.backgroundColor = UIColor.backgroundLight
        button.tintColor = UIColor.title
        button.contentMode = .center
        button.layer.cornerRadius = 30
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    @objc func didTapCloseButton() {
        delegate?.closeProfile()
    }
}

private extension ProfileViewController{
    
    func configureView() {
        view.backgroundColor = UIColor.background
        
        view.addSubview(closeButton)
        view.addSubview(nameLabel)
        view.addSubview(bioLabel)
        view.addSubview(photo)
        view.addSubview(phoneLabel)
        view.addSubview(emailLabel)
        stackView.addSubview(phoneButton)
        stackView.addSubview(messageButton)
        view.addSubview(stackView)
        
        setConstraints()
    }
    
    func setConstraints() {
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 100),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            bioLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            bioLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            photo.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 15),
            photo.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            photo.heightAnchor.constraint(equalToConstant: 200),
            photo.widthAnchor.constraint(equalToConstant: 200),
            
            phoneLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20),
            phoneLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            emailLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 10),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            stackView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -35),
            
            phoneButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            phoneButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            phoneButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            phoneButton.heightAnchor.constraint(equalToConstant: 60),
            phoneButton.widthAnchor.constraint(equalToConstant: 60),
            
            messageButton.topAnchor.constraint(equalTo: stackView.topAnchor),
            messageButton.leadingAnchor.constraint(equalTo: phoneButton.trailingAnchor, constant: 30),
            messageButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            messageButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            messageButton.heightAnchor.constraint(equalToConstant: 60),
            messageButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
