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

    
    init( apiService: APIServiceProtocol = MyBlissManager()) {
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
    
    private func configureFetchedEpisodes(_ episodes: [Episodes]){
        
    }
    
}

struct EpisodeListViewModel {
    let title: String
    let subtitle: String
    let description: String
    let imageUrl: String
}
