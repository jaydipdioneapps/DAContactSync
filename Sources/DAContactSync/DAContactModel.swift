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
    public var phone: [Phone]?
    public var name: String?
    public var email: [String]?
    public var id: String?
    public var address: [String]?
    public var createdDate : String?
    public var updatedDate : String?
    public var status : ContactStatus = .normal

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
    public var code: String?
    public var number: String?

    enum CodingKeys: String, CodingKey {
        case code = "code"
        case number = "number"
    }
}


// MARK: - Address
public class Address: Codable {
    public var subLocality: String?
    public var street: String?
    public var subAdminitrativeArea: String?
    public var city: String?
    public var state: String?
    public var country: String?
    public var postalCode: String?
    public var isoCountryCode: String?
    

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
