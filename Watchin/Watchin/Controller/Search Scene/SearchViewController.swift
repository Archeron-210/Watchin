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

    var searchResults: [ShowSearchDetail] = []
    private let aspectSetter = AspectSettings.shared
    private let showService = ShowService()

    // MARK: - Life Cycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        aspectSetter.setButtonBasicAspect(for: searchButton)
        aspectSetter.setTextFieldAspect(for: searchTextField)
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
            alert(title: "Warning ⚠︎", message: "\nYou need to enter a show title before pressing Search !")
            return
        }
        getSearchResults()
    }

    private func getSearchResults() {
        toggleActivityIndicator(shown: true)
        showService.getSearchResults(searchText: searchTextField.text) { result in
            self.toggleActivityIndicator(shown: false)
            switch result {
            case .success(let showsFound):
                guard !showsFound.isEmpty else {
                    self.alert(title: "No results 📃", message: "\nNo match found for your search, please try checking your spelling or enter another key word !")
                    return
                }
                self.searchResults = showsFound
                self.tableView.reloadData()
            case .failure:
                self.alert(title: "Error ✕", message: "\nIt seems like something went wrong with servers, please try again later.")
            }
        }
    }

    private func toggleActivityIndicator(shown: Bool) {
        searchButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }

    // MARK: - Alert

    private func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.setValue(aspectSetter.setAlertTitleAspect(for: alert), forKey: "attributedTitle")
        alert.setValue(aspectSetter.setAlertMessageAspect(for: alert), forKey: "attributedMessage")
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
            tableView.setEmptyMessage("This list in currently empty. \nStart by entering a TV show's name \nright above ↑ !")
        } else {
            tableView.restore()
        }
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShowPreviewCell", for: indexPath) as? ShowPreviewTableViewCell else {
            return UITableViewCell()
        }

        let show = searchResults[indexPath.row]

        cell.configure(for: show)
        cell.backgroundColor = UIColor.clear


        return cell
    }
}

    // MARK: - Navigation

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        showService.getShowDetails(for: searchResults[indexPath.row].apiFormatedName) { result in
            switch result {
            case .success(let details):
                self.goToShowDetails(with: details)
            case .failure :
                self.alert(title: "⚠️", message: "It seems like something went wrong with servers 🔌")
            }
        }
    }

    private func goToShowDetails(with details: TvShowInfo) {
        guard let showResultDetailsViewController = self.storyboard?.instantiateViewController(identifier: "ShowResultDetailsViewController") as? ShowResultDetailsViewController else {
            return
        }
        showResultDetailsViewController.show = details
        showResultDetailsViewController.episodes = details.episodes
        self.navigationController?.pushViewController(showResultDetailsViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}
