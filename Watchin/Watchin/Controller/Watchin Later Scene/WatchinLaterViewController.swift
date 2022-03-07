//
//  WatchLaterViewController.swift
//  Watchin
//
//  Created by Archeron on 07/02/2022.
//

import UIKit

class WatchinLaterViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties
    var watchinLaterShows: [ShowDetailFormatted] = []
    private let watchinShowRepository = WatchinShowRepository.shared

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        watchinLaterShows = watchinShowRepository.getUntrackedShows()
        tableView.reloadData()
    }

}

    // MARK: - TableView Management

extension WatchinLaterViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if watchinLaterShows.count == 0 {
            self.tableView.setEmptyMessage("This list in currently empty.\nHere, you can save\nall the shows to want to watch later.\nStart by searching a TV show\nand add it to Watchin' Later !\n↓")
        } else {
            self.tableView.restore()
        }
        return watchinLaterShows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WatchinLaterShowCell", for: indexPath) as? WatchinLaterTableViewCell else {
            return UITableViewCell()
        }
        let watchinLaterShow = watchinLaterShows[indexPath.row]
        cell.configure(for: watchinLaterShow)
        cell.backgroundColor = UIColor.clear

        return cell
    }
}

extension WatchinLaterViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToWatchinLaterShowDetails(for: watchinLaterShows[indexPath.row])
    }

    private func goToWatchinLaterShowDetails(for show: ShowDetailFormatted) {
        guard let watchinLaterShowDetailsViewController = self.storyboard?.instantiateViewController(identifier: "WatchinLaterShowDetailsViewController") as? WatchinLaterShowDetailsViewController else {
            return
        }

        watchinLaterShowDetailsViewController.show = show

        self.navigationController?.pushViewController(watchinLaterShowDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
