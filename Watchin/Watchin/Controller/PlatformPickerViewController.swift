//
//  PlatformPickerViewController.swift
//  Watchin
//
//  Created by Archeron on 01/03/2022.
//

import UIKit

class PlatformPickerViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var doneButton: UIButton!
    // outlet pickerView?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setContainerViewAspect()
        setButtonAspect(button: doneButton)
    }

    // MARK: - Action

    @IBAction func doneButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Private
    
    // MARK: - UIAspect

    private func setContainerViewAspect() {
        pickerContainerView.layer.cornerRadius = 10
    }

    private func setButtonAspect(button: UIButton) {
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 61, green: 176, blue: 239).cgColor
        button.layer.cornerRadius = 10
    }
}

    // MARK: - PickerView Management

extension PlatformPickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortedPlatformNames.count
    }


}

extension PlatformPickerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return sortedPlatformNames[row]
    }
}
