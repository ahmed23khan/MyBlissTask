//
//  MyBlissViewModel.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 09/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

class MyBlissViewModel {
    
    let apiService: APIServiceProtocol
    
    private var photos: [Episodes] = [Episodes]()

    var reloadTableViewClosure: (()->())?
    
    var isAllowSegue: Bool = false
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private var cellViewModels: [EpisodeListViewModel] = [EpisodeListViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }

    
    init(apiService: APIServiceProtocol = MyBlissManager()) {
        self.apiService = apiService
    }
    
    func initFetch(){
        apiService.fetchData { [weak self] (episodes, error) in
            
            guard let weakSelf = self else { return }
            
            if let episodes = episodes {
                weakSelf.configureFetchedEpisodes(episodes)
            }
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> EpisodeListViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel (_ episode: Episodes) -> EpisodeListViewModel {
        let title = episode.title
        let description = episode.description
        
        return EpisodeListViewModel(title: title, subtitle: "", description: description, imageUrl: "")
    }
    
    private func configureFetchedEpisodes(_ episodes: [Episodes]){
        
        var vms = [EpisodeListViewModel]()
        for episode in episodes {
            vms.append(self.createCellViewModel(episode))
        }
        self.cellViewModels = vms
    }
    
}

struct EpisodeListViewModel {
    let title: String
    let subtitle: String
    let description: String
    let imageUrl: String
}
