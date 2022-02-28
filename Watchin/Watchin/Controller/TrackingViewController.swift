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


    // MARK: - Properties

    var show: ShowDetailFormatted?
    var episodes: [[EpisodeFormatted]] = []
    private let episodeDetailRepository = EpisodeDetailRepository.shared

    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let show = show else {
            return
        }
        episodes = episodeDetailRepository.getEpisodes(for: show)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        displayShowInfos()
    }

    // MARK: - Private

    private func displayShowInfos() {

    }

    // MARK: - UI Aspect
    

}

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

        let episode = episodes[indexPath.section][indexPath.row]
        cell.configure(for: episode)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120.0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard episodes.count > section else {
            return nil
        }
        return "Season \(episodes[section].first?.seasonNumberFormatted ?? 0)"
    }
}

