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
    
    private var episodes: [Episodes] = [Episodes]()

    var reloadTableViewClosure: (()->())?
    
    var isAllowSegue: Bool = false
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var selectedEpisode: Episodes?
    
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
        let date = episode.date
        let imageUrl = episode.smallImageUrl
        let largeImage = episode.imageUrl
        let description = episode.description
        
        return EpisodeListViewModel(title: title, date: date, description: description, imageUrl: imageUrl, largeImage: largeImage)
    }
    
    private func configureFetchedEpisodes(_ episodes: [Episodes]){
        
        self.episodes = episodes
        
        var vms = [EpisodeListViewModel]()
        for episode in episodes {
            vms.append(self.createCellViewModel(episode))
        }
        self.cellViewModels = vms
    }
}

extension MyBlissViewModel{
    
    func userPressed( at indexPath: IndexPath ){
        self.selectedEpisode = self.episodes [indexPath.row]
    }
    
}

struct EpisodeListViewModel {
    let title: String
    let date: String
    let description: String
    let imageUrl: String
    let largeImage: String
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
