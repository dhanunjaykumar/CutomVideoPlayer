//
//  ViewController.swift
//  PIPPLayer
//
//  Created by Dhanunjay Kumar on 08/01/24.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    @IBAction func showPlayer(_ sender: Any) {
        
        loadPlayer()

    }
    func loadPlayer() {

        let vc: CustomPlayerViewController =  CustomPlayerViewController(nibName: "CustomPlayerViewController", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.definesPresentationContext = true
        vc.view.backgroundColor = .clear
        
        self.present(vc, animated: true, completion: nil)

    }

}
