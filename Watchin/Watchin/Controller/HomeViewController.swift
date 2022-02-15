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
    @IBOutlet weak var tableView: UITableView!

    private var user: User {
        UserRepository.shared.getUser()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInfo()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setImageAspect()
        setEditButtonAspect()
        tableView.backgroundColor = UIColor.clear
    }

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        guard let editProfileViewController = self.storyboard?.instantiateViewController(identifier: "EditProfileViewController") as? EditProfileViewController else {
            return
        }
        editProfileViewController.delegate = self
        self.present(editProfileViewController, animated: true)
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

    private func setUserInfo() {
        userNameLabel.text = "\(user.name)'s TV shows"
        if let profilePictureData = user.profilePictureData, let image = UIImage(data: profilePictureData) {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(named: "defaultProfilePic")
        }
    }
}

extension HomeViewController: EditProfileViewControllerDismissDelegate {
    func didDismiss() {
        setUserInfo()
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? TvShowTableViewCell else {
            return UITableViewCell()
        }
        // à compléter
        //cell.configure(for:)
        cell.backgroundColor = UIColor.clear

        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160.0
    }
}
