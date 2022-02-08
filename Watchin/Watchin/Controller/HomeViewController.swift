//
//  HomeViewController.swift
//  Watchin
//
//  Created by Archeron on 07/02/2022.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setImageAspect()
        setEditButtonAspect()

    }

    // MARK: - Private

    private func setImageAspect() {
        profileImageView.layer.borderWidth = 3
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
    }

    private func setEditButtonAspect() {
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.white.cgColor
        editProfileButton.layer.cornerRadius = 10
    }

}
