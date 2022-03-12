//
//  EditProfileViewController.swift
//  Watchin
//
//  Created by Archeron on 09/02/2022.
//

import UIKit

protocol EditProfileViewControllerDismissDelegate: AnyObject {
    func didDismiss()
}

class EditProfileViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var choosePictureButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var saveChangesButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    // MARK: - Properties

    weak var delegate: EditProfileViewControllerDismissDelegate?
    private let aspectSetter = AspectSettings.shared
    private let repository = UserRepository.shared
    private var user: User {
        UserRepository.shared.getUser()
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        aspectSetter.setProfilePictureAspect(for: profilePictureImageView)
        aspectSetter.setButtonBasicAspect(for: choosePictureButton)
        aspectSetter.setButtonBasicAspect(for: saveChangesButton)
        aspectSetter.setButtonBasicAspect(for: exitButton)
        aspectSetter.setTextFieldAspect(for: userNameTextField)
        displayUserInfos()
    }

    override func viewWillDisappear(_ animated: Bool) {
        if isBeingDismissed {
            delegate?.didDismiss()
        }
    }

    // MARK: - Actions

    @IBAction func exitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func saveChangesButtonTapped(_ sender: UIButton) {
        saveChanges()
    }


    // MARK: - Private

    private func displayUserInfos() {
        userNameTextField.text = user.name
        if let profilePictureData = user.profilePictureData, let image = UIImage(data: profilePictureData) {
            profilePictureImageView.image = image
        } else {
            profilePictureImageView.image = UIImage(named: "defaultProfilePic")
        }
    }

    private func saveChanges() {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            alert(title: "Warning ⚠︎", message: "\nPlease enter your name before saving !")
            return
        }
        let data = profilePictureImageView.image?.pngData()
        let user = User(name: userName, profilePictureData: data)
        let success = repository.saveUser(user)
        if success {
            alert(title: "Done ✓", message: "\nChanges saved successfully !")
        } else {
            alert(title: "Error ✕", message: "\nWe were unable to save your changes, please try again later.")
        }
    }

    // MARK: - Alerts

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

extension EditProfileViewController: UITextFieldDelegate {

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        userNameTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

    // MARK: - Image and Navigation Management

extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func choosePictureButtonTapped(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        profilePictureImageView.image = image
        picker.dismiss(animated: true)
    }
}

