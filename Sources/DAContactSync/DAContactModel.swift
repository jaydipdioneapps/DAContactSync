//
//  DAContactModel.swift
//  
//
//  Created by Paras Navadiya on 20/02/23.
//

import Foundation

public enum ContactStatus : Codable {
    case added
    case updated
    case deleted
}

public class DAContactModel: Codable {
    public var phone: [Phone]?
    public var name: String?
    public var email: [String]?
    public var id: String?
    public var address: [Address]?
    public var createdDate : String?
    public var updatedDate : String?
    public var status : ContactStatus = .added
    public var profilePic: Data? = nil

    public init(phone: [Phone], name: String, email: [String], id: String, address: [Address], createdDate : String, updatedDate : String, status : ContactStatus, profilePic: Data? = nil) {
        self.phone = phone
        self.name = name
        self.email = email
        self.id = id
        self.address = address
        self.createdDate = createdDate
        self.updatedDate = updatedDate
        self.profilePic = profilePic
    }
    enum CodingKeys: String, CodingKey {
        case phone = "phone"
        case name = "name"
        case email = "email"
        case id = "id"
        case address = "address"
        case createdDate = "createdDate"
        case updatedDate = "updatedDate"
        case profilePic = "profilePic"
    }
}

// MARK: - Phone
public class Phone: Codable {
    public var code: String?
    public var number: String?

    public init(code: String, number: String) {
        self.code = code
        self.number = number
    }
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
    
    public init(subLocality: String, street: String?, subAdminitrativeArea: String, city: String, state: String, country: String, postalCode: String, isoCountryCode: String) {
        self.subLocality = subLocality
        self.street = street
        self.subAdminitrativeArea = subAdminitrativeArea
        self.city = city
        self.state = state
        self.country = country
        self.postalCode = postalCode
        self.isoCountryCode = isoCountryCode
    }
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
