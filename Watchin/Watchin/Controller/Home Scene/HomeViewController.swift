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

    // MARK: - Properties

    var shows: [ShowDetailFormatted] = []

    private var user: User {
        UserRepository.shared.getUser()
    }

    private let repository = WatchinShowRepository.shared

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUserInfo()
        shows = repository.getShows()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setImageAspect()
        setEditButtonAspect()
        tableView.backgroundColor = UIColor.clear
    }

    // MARK: - Actions

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        goToEditProfile()
    }


    // MARK: - Private

    private func goToEditProfile() {
        guard let editProfileViewController = self.storyboard?.instantiateViewController(identifier: "EditProfileViewController") as? EditProfileViewController else {
            return
        }
        editProfileViewController.delegate = self
        self.present(editProfileViewController, animated: true)
    }

    // MARK: - UI Aspect

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

    // MARK: - Dismiss Delegate

extension HomeViewController: EditProfileViewControllerDismissDelegate {
    func didDismiss() {
        setUserInfo()
    }
}

    // MARK: - TableView Management

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shows.count == 0 {
            self.tableView.setEmptyMessage("This list in currently empty.\n Start by searching a TV show\nand add it to your shows !\n↓")
        } else {
            self.tableView.restore()
        }
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowCell", for: indexPath) as? TvShowTableViewCell else {
            return UITableViewCell()
        }

        let show = shows[indexPath.row]
        cell.configure(for: show)
        cell.backgroundColor = UIColor.clear

        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160.0
    }
}

    // MARK: - Navigation

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToTracking(for: shows[indexPath.row])
    }

    private func goToTracking(for show: ShowDetailFormatted) {
        guard let trackingViewController = self.storyboard?.instantiateViewController(identifier: "TrackingViewController") as? TrackingViewController else {
            return
        }

        trackingViewController.show = show

        self.navigationController?.pushViewController(trackingViewController, animated: true)
    }
}
