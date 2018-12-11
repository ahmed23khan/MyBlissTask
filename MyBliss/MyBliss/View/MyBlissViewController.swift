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
    
    // Refresh Controller
    var refreshControl: UIRefreshControl!
    
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
        // Configure Referesh Control.
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: PlaceHolder.PullRefresh)
        refreshControl.addTarget(self, action: #selector(initialiseViewModel), for: .valueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    @objc func initialiseViewModel(){
        if(self.refreshControl.isRefreshing) {
            self.refreshControl.endRefreshing()
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoardConstants.SegueConstant {
            let detailViewController = segue.destination as! MyBlissDetailViewController
            if let episode = viewModel.selectedEpisode {
                detailViewController.descriptionText = episode.description
                detailViewController.largeUrl        = episode.imageUrl
            }
        }
    }
    
}

extension MyBlissViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : MyBlissTableViewCell = tableView.dequeueReusableCell(withIdentifier: MyBlissTableViewCell.identifier, for: indexPath) as! MyBlissTableViewCell
        
        let cellViewModel = viewModel.getCellViewModel(at: indexPath)
        cell.titleLabel.text = cellViewModel.title
        cell.dateLabel.text = cellViewModel.date
        cell.smallImage.loadImage(url: URL(string: cellViewModel.imageUrl)!)
        return cell
        
    }
    
}

extension MyBlissViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        self.viewModel.userPressed(at: indexPath)
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: StoryBoardConstants.SegueConstant, sender: indexPath)
    }
    
}
