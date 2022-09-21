//
//  ViewController.swift
//  game with placeholders
//
//  Created by Jpsmor on 19/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    let gameView = GameView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view = gameView
    }


}

