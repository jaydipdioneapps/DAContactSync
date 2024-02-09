//
//  DAContactSync+Closures.swift
//  
//
//  Created by Paras Navadiya on 18/02/23.
//

@_exported import Contacts

/// Requests access to the user's contacts.
/// - Parameter completion: returns either a success or a failure,
/// on sucess: returns true if the user allows access to contacts
/// on error: error information, if an error occurred.
public func requestAccess(_ completion: @escaping (Result<Bool, Error>) -> Void) {
    ContactStore.default.requestAccess(for: .contacts) { bool, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        completion(.success(bool))
    }
}

/// Fetch all contacts from device
/// - Parameters:
///   - keysToFetch: The contact fetch request that specifies the search criteria.
///   - order: The sort order for contacts.
///   - unifyResults: A Boolean value that indicates whether to return linked contacts as unified contacts.
///   - completion: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
///
 public func fetchContacts(keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], order: CNContactSortOrder = .none, unifyResults: Bool = true, _ completion: @escaping (Result<[DAContactModel], Error>) -> Void) {
    do {
        var contacts: [DAContactModel] = [DAContactModel]()
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactEmailAddressesKey as CNKeyDescriptor
        ]

        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        fetchRequest.unifyResults = unifyResults
        fetchRequest.sortOrder = order
        try ContactStore.default.enumerateContacts(with: fetchRequest) { contact, _ in
            contacts.append(getContactModel(contact: contact))
        }
        completion(.success(contacts))
    } catch {
        completion(.failure(error))
    }
}

/// fetch contacts matching a conditions.
/// - Parameters:
///   - predicate: A definition of logical conditions for constraining a search for a fetch or for in-memory filtering.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(predicate: NSPredicate, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// fetch contacts matching a name.
/// - Parameters:
///   - name: The name can contain any number of words.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(matchingName name: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: CNContact.predicateForContacts(matchingName: name), keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// Fetch contacts matching an email address.
/// - Parameters:
///   - emailAddress: The email address to search for. Do not include a scheme (e.g., "mailto:").
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(matchingEmailAddress emailAddress: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: CNContact.predicateForContacts(matchingEmailAddress: emailAddress), keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// Fetch contacts matching a phone number.
/// - Parameters:
///   - phoneNumber: A CNPhoneNumber representing the phone number to search for. Do not include a scheme (e.g., "tel:").
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(matching phoneNumber: CNPhoneNumber, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: CNContact.predicateForContacts(matching: phoneNumber), keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// To fetch contacts matching contact identifiers.
/// - Parameters:
///   - identifiers: Contact identifiers to be matched.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(withIdentifiers identifiers: [String], keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[DAContactModel]?, Error>) -> Void) {
    do {
        var contacts : [DAContactModel]?
        for identifier in identifiers {
            
            let contatct = try ContactStore.default.unifiedContact(withIdentifier: identifier, keysToFetch: keysToFetch)
            contacts?.append(getContactModel(contact: contatct))
        }
        completion(.success(contacts))
    } catch {
        completion(.failure(error))
    }
}

/// To fetch contacts matching contact identifiers.
/// - Parameters:
///   - identifier: Contact identifiers to be matched.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchSingleContact(withIdentifiers identifier: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<DAContactModel?, Error>) -> Void) {
    do {
        var contactModel : DAContactModel?
        let contatct = try ContactStore.default.unifiedContact(withIdentifier: identifier, keysToFetch: keysToFetch)
        contactModel = getContactModel(contact: contatct)
        completion(.success(contactModel))
    } catch {
        completion(.failure(error))
    }
}

/// To fetch contacts matching group identifier
/// - Parameters:
///   - groupIdentifier: The group identifier to be matched.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(withGroupIdentifier groupIdentifier: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: CNContact.predicateForContactsInGroup(withIdentifier: groupIdentifier), keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// find the contacts in the specified container.
/// - Parameters:
///   - containerIdentifier: The container identifier to be matched.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: returns array of contacts
/// on error: error information, if an error occurred.
public func fetchContacts(withContainerIdentifier containerIdentifier: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContacts(matching: CNContact.predicateForContactsInContainer(withIdentifier: containerIdentifier), keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// Fetch a  contact with a given identifier.
/// - Parameters:
///   - identifier: The identifier of the contact to fetch.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
/// - Returns: returns either a success or a failure,
/// on sucess: contact matching or linked to the identifier
/// on error: error information, if an error occurred.
public func fetchContact(withIdentifier identifier: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<CNContact, Error>) -> Void) {
    do {
        completion(.success(try ContactStore.default.unifiedContact(withIdentifier: identifier, keysToFetch: keysToFetch)))
    } catch {
        completion(.failure(error))
    }
}

/// Adds the specified contact to the contact store.
/// - Parameters:
///   - contact: The new contact to add.
///   - identifier: The container identifier to add the new contact to. Set to nil for the default container.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func addContact(_ contact: CNMutableContact, toContainerWithIdentifier identifier: String? = nil, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: identifier)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Updates an existing contact in the contact store.
/// - Parameters:
///   - contact: The contact to update.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func updateContact(_ contact: CNMutableContact, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.update(contact)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Deletes a contact from the contact store.
/// - Parameters:
///   - contact: Contact to be delete.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func deleteContact(_ contact: CNMutableContact, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.delete(contact)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Fetches all groups matching the specified predicate.
/// - Parameters:
///   - predicate: The predicate to use to fetch the matching groups. Set predicate to nil to match all groups.
///   - completion: returns either a success or a failure,
/// on sucess: An array of CNGroup objects that match the predicate.
/// on error: error information, if an error occurred.
public func fetchGroups(matching predicate: NSPredicate? = nil, _ completion: @escaping (Result<[CNGroup], Error>) -> Void) {
    do {
        let groups = try ContactStore.default.groups(matching: predicate)
        completion(.success(groups))
    } catch {
        completion(.failure(error))
    }
}

/// Adds a group to the contact store.
/// - Parameters:
///   - name: The new group to add.
///   - identifier: The container identifier to add the new group to. Set to nil for the default container.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func addGroup(_ name: String, toContainerWithIdentifier identifier: String? = nil, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        let group = CNMutableGroup()
        group.name = name
        request.add(group, toContainerWithIdentifier: identifier)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Updates an existing group in the contact store.
/// - Parameters:
///   - group: The group to update.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func updateGroup(_ group: CNMutableGroup, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.update(group)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Deletes a group from the contact store.
/// - Parameters:
///   - group: The group to delete.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func deleteGroup(_ group: CNMutableGroup, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.delete(group)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// find the contacts that are members in the specified group.
/// - Parameters:
///   - group: The group identifier to be matched.
///   - keysToFetch: The contact fetch request that specifies the search criteria.
///   - completion: returns either a success or a failure,
/// on sucess: Array  of contacts
/// on error: error information, if an error occurred.
public func fetchContact(in group: String, keysToFetch: [CNKeyDescriptor] = [CNContactVCardSerialization.descriptorForRequiredKeys()], _ completion: @escaping (Result<[CNContact], Error>) -> Void) {
    do {
        let contacts = try fetchContacts(predicate: CNContact.predicateForContactsInGroup(withIdentifier: group), keysToFetch: keysToFetch)
        completion(.success(contacts))
    } catch {
        completion(.failure(error))
    }
}

/// Add a new member to a group.
/// - Parameters:
///   - contact: The new member to add to the group.
///   - group: The group to add the member to.
///   - completion: returns either a success or a failure,
/// on sucess: returns true
/// on error: error information, if an error occurred.
public func addContact(_ contact: CNContact, to group: CNGroup, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.addMember(contact, to: group)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}

/// Removes a contact as a member of a group.
/// - Parameters:
///   - contact: The contact to remove from the group membership.
///   - group: The group to remove the contact from its membership.
///   - completion: Error information, if an error occurred.
public func deleteContact(_ contact: CNContact, from group: CNGroup, _ completion: @escaping (Result<Bool, Error>) -> Void) {
    do {
        let request = CNSaveRequest()
        request.removeMember(contact, from: group)
        try ContactStore.default.execute(request)
        completion(.success(true))
    } catch {
        completion(.failure(error))
    }
}


public func getContactModel(contact : CNContact) -> DAContactModel {
    var arrPhone : [Phone] = [Phone]()
    
    for phoneNumber in contact.phoneNumbers {
        let cCode = phoneNumber.value.value(forKey: "countryCode") as? String ?? "+1"
        var cNumner = phoneNumber.value.value(forKey: "digits") as? String ?? ""
        let countryCode = cCode.getCountryCode()
        cNumner = cNumner.replacingOccurrences(of: countryCode, with: "")
        
        let phone = Phone(code: countryCode, number: cNumner)
        arrPhone.append(phone)
    }
    
    var arrEmail : [String] = [String]()
    for email in contact.emailAddresses {
        arrEmail.append(email.value as String)
    }
    
    var arrAddress : [Address] = [Address]()
    for address in contact.postalAddresses {
        let addressModel = Address(subLocality: address.value.subLocality, street: address.value.street, subAdminitrativeArea: address.value.subAdministrativeArea, city: address.value.city, state: address.value.state, country: address.value.country, postalCode: address.value.postalCode, isoCountryCode: address.value.isoCountryCode)
        arrAddress.append(addressModel)
    }
    
    let model = DAContactModel(phone: arrPhone, name: contact.givenName + contact.familyName, email: arrEmail, id: contact.identifier, address: arrAddress, createdDate: "", updatedDate: "", status: ContactStatus.added, profilePic: contact.imageData)
    return model
}
