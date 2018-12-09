//
//  MyBlissManager.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 09/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

protocol APIServiceProtocol {
    func fetchData(completionHandler:@escaping (_ episodes: [Episodes]?, _ error: Error?)->())
}

class MyBlissManager:APIServiceProtocol {
    
    static let defaultManager = MyBlissManager()
    
    typealias episodesCompletion = (_ episodes: [Episodes]?, _ error: Error?)->()
    
    func fetchData(completionHandler:@escaping episodesCompletion){
        let url = URL(string: BlissAPI.fetchEpisodesAPI(page: 1))
        if let url = url {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data else {
                    print(ErrorConstants.DataError)
                    completionHandler(nil, error)
                    return
                }
                guard error == nil else {
                    completionHandler(nil, error)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(MyBliss.self, from: responseData)
                    completionHandler(response.data.episodes, nil)
                } catch {
                    print(ErrorConstants.JsonParseError)
                    print(error)
                    completionHandler(nil, error)
                }
                }.resume()
        }
    }
}

// Construct URL.
struct BlissAPI {
    
    // End Point URL
    static func baseEndPoint() -> String {
        return UrlConstants.BaseUrl
    }
    
    // Invoking API
    static func fetchEpisodesAPI(page: Int) -> String {
        return "\(self.baseEndPoint())\(page)"
    }
}


