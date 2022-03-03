//
//  TrackingViewController.swift
//  Watchin
//
//  Created by Archeron on 23/02/2022.
//

import UIKit

class TrackingViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvShowPosterImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var startDateStatusLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var episodesNumberLabel: UILabel!
    @IBOutlet weak var seasonsNumberLabel: UILabel!
    @IBOutlet weak var platformLabel: UILabel!
    @IBOutlet weak var startAgainButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var platformsButton: UIButton!


    // MARK: - Properties

    var show: ShowDetailFormatted?
    var episodes: [[EpisodeFormatted]] = []
    private let watchinShowRepository = WatchinShowRepository.shared
    private let episodeDetailRepository = EpisodeDetailRepository.shared

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let show = show else {
            return
        }
        displayShowInfos()
        episodes = episodeDetailRepository.getEpisodes(for: show)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setButtonAspect(for: startAgainButton)
        setButtonAspect(for: deleteButton)
        setButtonAspect(for: platformsButton)
    }

    // MARK: - Actions

    @IBAction func platformsButtonTapped(_ sender: UIButton) {
        goToPlatformsPicker()
    }

    @IBAction func startAgainButtonTapped(_ sender: UIButton) {
    }

    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        deleteAlert()
    }



    // MARK: - Private

    private func displayShowInfos() {
        // as? WatchinShow ? pour afficher platform?
        guard let show = show else {
            return
        }
        setImage()
        showTitleLabel.text = show.nameFormatted
        startDateStatusLabel.text = "\(show.startDateFormatted) - \(show.statusFormatted)"
        genresLabel.text = show.genresFormatted
        countryLabel.text = show.countryFormatted
        episodesNumberLabel.text = "Episodes : 0/\(show.numberOfEpisodes)"
        seasonsNumberLabel.text = "Seasons : 0/\(show.numberOfSeasons)"
        platformLabel.text = "On : \(show.platformFormatted)"
    }

    private func setImage() {
        guard let show = show else {
            return
        }
        if let imageUrl = URL(string: show.imageStringUrlFormatted) {
            tvShowPosterImageView.af.setImage(withURL: imageUrl, placeholderImage: UIImage(named: "watchinIcon"))
        } else {
            tvShowPosterImageView.image = UIImage(named: "watchinIcon")
        }
    }

    private func goToPlatformsPicker() {
        guard let currentShow = show, let platformPickerViewController = self.storyboard?.instantiateViewController(identifier: "PlatformPickerViewController") as? PlatformPickerViewController else {
            return
        }
        platformPickerViewController.show = currentShow
        platformPickerViewController.delegate = self
        self.present(platformPickerViewController, animated: true)
    }

    private func deleteAndGoBackToHome() {
        guard let show = self.show else {
            return
        }
        watchinShowRepository.deleteWatchinShow(show: show)
        navigationController?.popViewController(animated: true)
    }

    private func updateEpisode() {

    }

    private func updateButtonAspect() {

    }

    // MARK: - Alerts

    private func deleteAlert() {
        let alert = UIAlertController(title: "⚠️", message: "You are about to delete this show from your saved shows : all your episode progression will be lost.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
            self.deleteAndGoBackToHome()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }


    // MARK: - UI Aspect

    private func setButtonAspect(for button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 10
    }

}

    // MARK: - Dismiss Delegate

extension TrackingViewController: PlatformPickerViewControllerDismissDelegate {
    func didDismiss() {
        guard let show = show else {
            return
        }
        self.show = watchinShowRepository.getWatchinShow(id: show.idFormatted)
        displayShowInfos()
    }
}

    // MARK: - Cell Delegate

extension TrackingViewController: EpisodeTableViewCellActionDelegate {
    func sawItButtonTapped(in cell: EpisodeTableViewCell) {
        // check if there are an indexPath and a show
        guard let indexPath = tableView.indexPath(for: cell), let show = show else {
            return
        }
        // check if not out of range
        guard episodes.count > indexPath.section,
              episodes[indexPath.section].count > indexPath.row else {
            return
        }

        let episode = episodes[indexPath.section][indexPath.row]
        episodeDetailRepository.updateWatchEpisodeStatus(episode: episode, of: show)
        // update episode data
        episodes = episodeDetailRepository.getEpisodes(for: show)
        cell.configure(for: episodes[indexPath.section][indexPath.row])
    }
}

    // MARK: - TableView Management

extension TrackingViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return episodes.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard episodes.count > section else {
            return 0
        }
        return episodes[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }

        // ??? à checker
        guard episodes.count > indexPath.section,
              episodes[indexPath.section].count > indexPath.row else {
            return UITableViewCell()
        }

        let episode = episodes[indexPath.section][indexPath.row]
        cell.configure(for: episode)
        cell.delegate = self

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }
}

    // MARK: - Headers Aspect

extension TrackingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 40))
        header.backgroundColor = UIColor.white.withAlphaComponent(0.8)

        let titleLabel = UILabel(frame: CGRect(x: 20, y: 2, width: header.frame.size.width - 5, height: header.frame.size.height - 5))
        titleLabel.text = "◦ Season \(section + 1)"
        titleLabel.font = UIFont(name: "Kohinoor Telugu", size: 22)
        titleLabel.textColor = UIColor(red: 61, green: 176, blue: 239)

        header.addSubview(titleLabel)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40.0
    }
}

