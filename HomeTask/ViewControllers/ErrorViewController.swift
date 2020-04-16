//
//  ViewController.swift
//  HomeTask
//
//  Created by ali on 4/16/20.
//  Copyright © 2020 ali. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {
    
    @IBOutlet var panToClose: InteractionPanToClose!
    @IBOutlet var okButton: UIButton!
    @IBOutlet var errorMessageLabel: UILabel!
    @IBOutlet var errorView: UIView!

    var errorMessage: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panToClose.setGestureRecognizer()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        panToClose.animateDialogeAppear()
    }
    
}


//MARK: Actions
extension ErrorViewController {
    @IBAction func okButtonDidTap(_ sender: Any) {
        panToClose.animateDialogeDisappear()
    }
}

//MARK: - Setup Views
extension ErrorViewController {
    func setupViews(){
        okButton.setTitle(StringHelper.ok(), for: .normal)
        okButton.layer.cornerRadius = 10
        
        errorView.layer.cornerRadius = 14
        errorMessageLabel.text = errorMessage ?? StringHelper.error()
    }
}



