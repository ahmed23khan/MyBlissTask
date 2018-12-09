//
//  MyBlissViewController.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 09/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class MyBlissViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: MyBlissViewModel = {
        return MyBlissViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initialUiSetUp()
        self.initialiseViewModel()
    }
    
    func initialUiSetUp(){
        self.registerNibs()
    }
    
    func initialiseViewModel(){
        // Native Binding View with View Model.
        viewModel.reloadTableViewClosure = { [weak self] () in
            
            guard let weakSelf = self else { return }
            
            // Reload TableView after fetching data from Api on the Main Thread.
            DispatchQueue.main.async {
             weakSelf.tableView.reloadData()
            }
        }
        
        // Fetch Data from the service.
        viewModel.initFetch()
    }
    
    func registerNibs(){
        self.tableView.register(MyBlissTableViewCell.nib, forCellReuseIdentifier: MyBlissTableViewCell.identifier)
    }
}

extension MyBlissViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MyBlissTableViewCell = tableView.dequeueReusableCell(withIdentifier: MyBlissTableViewCell.identifier, for: indexPath) as! MyBlissTableViewCell
        cell.textLabel?.text = "Some Text"
        return cell
        
    }
    
}

extension MyBlissViewController: UITableViewDelegate {
    
}
