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
    private let aspectSetter = AspectSettings.shared
    private let watchinShowRepository = WatchinShowRepository.shared
    private let episodeDetailRepository = EpisodeDetailRepository.shared

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUserInfo()
        shows = watchinShowRepository.getTrackedShows()
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aspectSetter.setProfilePictureAspect(for: profileImageView)
        aspectSetter.setButtonBasicAspect(for: editProfileButton)
        tableView.backgroundColor = UIColor.clear
    }

    // MARK: - Actions

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        goToEditProfile()
    }


    // MARK: - Private

    private func setUserInfo() {
        userNameLabel.text = "\(user.name)'s TV shows"
        if let profilePictureData = user.profilePictureData, let image = UIImage(data: profilePictureData) {
            profileImageView.image = image
        } else {
            profileImageView.image = UIImage(named: "defaultProfilePic")
        }
    }

    private func goToEditProfile() {
        guard let editProfileViewController = self.storyboard?.instantiateViewController(identifier: "EditProfileViewController") as? EditProfileViewController else {
            return
        }
        editProfileViewController.delegate = self
        self.present(editProfileViewController, animated: true)
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
            tableView.setEmptyMessage("This list in currently empty.\n Start by searching a TV show\nand add it to your shows !\n↓")
        } else {
            tableView.restore()
        }
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchinShowCell", for: indexPath) as? WatchinShowTableViewCell else {
            return UITableViewCell()
        }

        let show = shows[indexPath.row]
        let watchedEpisodes = episodeDetailRepository.getWatchedEpisodes(for: show)
        cell.configure(for: show, with: watchedEpisodes.count)
        cell.backgroundColor = UIColor.clear

        
        return cell
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
