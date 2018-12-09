//
//  ViewController.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 09/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fetchData()
    }
    
    func fetchData(){
        MyBlissManager.defaultManager.fetchData { (episodes, error) in
            print(episodes)
        }
    }
}

