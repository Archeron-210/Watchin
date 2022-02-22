//
//  SearchViewController.swift
//  Watchin
//
//  Created by Archeron on 07/02/2022.
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var searchResults: [TvShowsSearchDetail] = []
    private let tvShowService = TvShowService()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setSearchButtonAspect()
        setTextFieldAspect()
        tableView.backgroundColor = UIColor.clear
        tableView.reloadData()
    }

    // MARK: - Actions

    @IBAction func searchButtonTapped(_ sender: UIButton) {
        searchForResults()
    }


    // MARK: - Private

    private func searchForResults() {
        guard let text = searchTextField.text, !text.isEmpty else {
            emptyTextFieldAlert()
            return
        }
        getSearchResults()
    }

    private func getSearchResults() {
        toggleActivityIndicator(shown: true)
        tvShowService.getSearchResults(searchText: searchTextField.text) { result in
            self.toggleActivityIndicator(shown: false)
            switch result {
            case .success(let showsFound) :
                self.searchResults = showsFound
                self.tableView.reloadData()
            case .failure :
                self.errorAlert()
            }
        }
    }

    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    // MARK: - UI Aspect

    private func setSearchButtonAspect() {
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = UIColor.white.cgColor
        searchButton.layer.cornerRadius = 10
    }

    private func setTextFieldAspect() {
        searchTextField.setBottomBorderAndPlaceholderTextColor()
    }

    // MARK: - Alerts

    private func errorAlert() {
        let alert = UIAlertController(title: "⚠️", message: "It seems like something went wrong with servers 🔌", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }

    private func emptyTextFieldAlert() {
        let alert = UIAlertController(title: "⚠️", message: "You need to enter a show title first ! 📺", preferredStyle: .alert)
        let actionAlert = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionAlert)
        present(alert, animated: true, completion: nil)
    }

}

    // MARK: - Keyboard Management

extension SearchViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchForResults()
        return true
    }
}

    // MARK: - TableView Management

extension SearchViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResults.count == 0 {
            self.tableView.setEmptyMessage("This list in currently empty. \nStart by entering a TV show's name \nright above ↑ !")
        } else {
            self.tableView.restore()
        }
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tvShowPreviewCell", for: indexPath) as? TvShowPreviewTableViewCell else {
            return UITableViewCell()
        }

        let tvShow = searchResults[indexPath.row]

        cell.configure(for: tvShow)
        cell.backgroundColor = UIColor.clear


        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160.0
    }
    
}

    // MARK: - Navigation

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        tvShowService.getShowDetails(for: searchResults[indexPath.row].apiFormatedName) { result in
            switch result {
            case .success(let details):
                self.goToShowDetails(with: details)
            case .failure :
                self.errorAlert()
            }
        }
    }

    private func goToShowDetails(with details: TvShowInfo) {
        guard let showResultDetailsViewController = self.storyboard?.instantiateViewController(identifier: "ShowResultDetailsViewController") as? ShowResultDetailsViewController else {
            return
        }
        showResultDetailsViewController.tvShow = details
        self.navigationController?.pushViewController(showResultDetailsViewController, animated: true)
    }
}
