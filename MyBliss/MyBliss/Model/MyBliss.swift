//
//  MyBliss.swift
//  MyBliss
//
//  Created by Tauqeer Ahmed Khan on 09/12/18.
//  Copyright © 2018 Tauqeer Ahmed Khan. All rights reserved.
//

import UIKit

struct MyBliss: Codable {
    
    let message: String
    let data: MyBlissData

}

struct MyBlissData: Codable {
    
    let episodes: [Episodes]
    let count: Int
    let page: Int
    let more: Bool
    
}

struct Episodes: Codable {
    
    let id: Int
    let title: String
    let subTitle: String
    let description: String
    let imageUrl: String
    let smallImageUrl: String
    let date: String
    
}
