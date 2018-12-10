//
//  MyBlissDetailViewController.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 10/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class MyBlissDetailViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var largeImageView: UIImageView!
    
    var largeUrl: String?
    var descriptionText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialUiSetUp()
        
    }
    
    func initialUiSetUp(){
        if let imageUrl = largeUrl, let episodeDescription = descriptionText, let imageURL =  URL(string: imageUrl) {
            self.descriptionLabel.text = episodeDescription
            self.largeImageView.loadImage(url: imageURL)
        }
    }
    
}
