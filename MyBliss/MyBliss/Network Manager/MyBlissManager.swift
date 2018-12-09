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
    
    func fetchData(completionHandler:@escaping (_ episodes: [Episodes]?, _ error: Error?)->()){
        let url = URL(string: "http://apidev.mybliss.ai/api/v1/dummy?page=1")
        if let url = url {
            let request = URLRequest(url: url)
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                guard let responseData = data else {
                    print("Error")
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
                    print("Error")
                    print(error)
                    completionHandler(nil, error)
                }
                }.resume()
        }
    }
}

