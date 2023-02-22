//
//  DAContactSync+Helper.swift
//  
//
//  Created by Paras Navadiya on 18/02/23.
//

@_exported import Contacts

/// Returns the vCard representation of the specified contacts.
/// - Parameter contacts: An array of contacts.
/// - Throws: Contains error information.
/// - Returns: An NSData object with the vCard representation of the contact.
public func encode(contacts: [CNContact]) throws -> Data {
    return try CNContactVCardSerialization.data(with: contacts)
}

/// Returns the contacts from the vCard data.
/// - Parameter data: The vCard data representing one or more contacts.
/// - Throws: Error information.
/// - Returns: An array of contacts.
public func decode(data: Data) throws -> [CNContact] {
    return try CNContactVCardSerialization.contacts(with: data)
}

