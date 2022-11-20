//
//  Article.swift
//  BulkApp
//
//  Created by user on 2022/11/17.
//

import Foundation

struct Article: Codable {
    let id: Int
    let createdAt: String
    let category: String
    let event: String
    
    
    
    enum CodingKeys:  String, CodingKey {
        case id
        case createdAt = "created_at"
        case category = "category_name"
        case event
    }
    
    func createdAtStr ()->String {
        let df = ISO8601DateFormatter()
        df.formatOptions.insert(.withFractionalSeconds)
        
        let createdAtDate = df.date(from: createdAt)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let createdAtStr = formatter.string(from: createdAtDate!)
        return createdAtStr
    }
}

