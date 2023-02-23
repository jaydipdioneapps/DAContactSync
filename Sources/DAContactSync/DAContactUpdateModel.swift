//
//  File.swift
//  
//
//  Created by Paras Navadiya on 23/02/23.
//

import Foundation

public class DAContactUpdateModel: Codable {
    public var id: String?
    public var status : ContactStatus = .normal

    public init(id: String, status: ContactStatus) {
        self.id = id
        self.status = status
    }
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case status = "status"
    }
}
