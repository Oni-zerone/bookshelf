//
//  LoginViewController.swift
//  BookShelf
//
//  Created by Andrea Altea on 05/11/17.
//  Copyright © 2017 Studiout. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    struct Segue {
        static let showAuthors = "ShowAuthors"
    }
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.usernameField.becomeFirstResponder()
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        guard textField == passwordField else {
            self.passwordField.becomeFirstResponder()
            self.passwordField.text = nil
            return true
        }

        guard let username = self.usernameField.text,
            let password = self.passwordField.text else {
                return false
        }
        
        self.passwordField.resignFirstResponder()
        self.performLogin(username: username, password: password)
        return true
    }
    
    private func performLogin(username: String, password: String) {
        
        self.usernameField.isUserInteractionEnabled = false
        self.passwordField.isUserInteractionEnabled = false
        self.loginIndicator.startAnimating()
        LoginManager.login(username: username, password: password) { (success, error) in

            self.usernameField.isUserInteractionEnabled = true
            self.passwordField.isUserInteractionEnabled = true
            self.loginIndicator.stopAnimating()
            
            guard success else {
                self.retry()
                return
            }
            
            self.performSegue(withIdentifier: Segue.showAuthors, sender: self)
        }
    }
    
    private func retry() {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: UIViewKeyframeAnimationOptions.beginFromCurrentState, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.225, animations: {
                self.passwordField.transform = CGAffineTransform(translationX: 10, y: 0)
            })
            
            
            UIView.addKeyframe(withRelativeStartTime: 0.225, relativeDuration: 0.425, animations: {
                self.passwordField.transform = CGAffineTransform(translationX: -10, y: 0)
            })
            
            UIView.addKeyframe(withRelativeStartTime: 0.425, relativeDuration: 0.675, animations: {
                self.passwordField.transform = CGAffineTransform(translationX: 10, y: 0)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.675, relativeDuration: 0.9, animations: {
                self.passwordField.transform = CGAffineTransform(translationX: -10, y: 0)
            })

            UIView.addKeyframe(withRelativeStartTime: 0.9, relativeDuration: 1, animations: {
                self.passwordField.transform = .identity
            })

        }) { (finished) in
            
            self.passwordField.text = nil
            self.passwordField.becomeFirstResponder()
        }
    }
}
