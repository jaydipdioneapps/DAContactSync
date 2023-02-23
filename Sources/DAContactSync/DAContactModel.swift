//
//  DAContactModel.swift
//  
//
//  Created by Paras Navadiya on 20/02/23.
//

import Foundation

public enum ContactStatus : Codable {
    
    case normal
    case added
    case updated
    case deleted
}

public class DAContactModel: Codable {
    var phone: [Phone]?
    var name: String?
    var email: [String]?
    var id: String?
    var address: [String]?
    var createdDate : String?
    var updatedDate : String?
    var status : ContactStatus = .normal

    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case name = "name"
        case email = "email"
        case id = "id"
        case address = "address"
        case createdDate = "createdDate"
        case updatedDate = "updatedDate"
    }
}

// MARK: - Phone
public class Phone: Codable {
    var code: String?
    var number: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case number = "number"
    }
}


// MARK: - Address
public class Address: Codable {
    var subLocality: String?
    var street: String?
    var subAdminitrativeArea: String?
    var city: String?
    var state: String?
    var country: String?
    var postalCode: String?
    var isoCountryCode: String?
    

    enum CodingKeys: String, CodingKey {
        case subLocality = "subLocality"
        case street = "street"
        case subAdminitrativeArea = "subAdminitrativeArea"
        case city = "city"
        case state = "state"
        case country = "country"
        case postalCode = "postalCode"
        case isoCountryCode = "isoCountryCode"
    }
}
