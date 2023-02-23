//
//  ViewController.swift
//  ExampleApp
//
//  Created by Paras Navadiya on 22/02/23.
//

import UIKit
import DAContactSync
import ContactStoreChangeHistory

class ViewController: UIViewController {
    let contactsChangeNotifier = try? ContactsChangeNotifier(
        store: CNContactStore(),
        fetchRequest: .fetchRequest(additionalContactKeyDescriptors: [
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
        ])
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getContacts()
        NotificationCenter.default.addObserver(self, selector:#selector(contactsStoreChanged(_:)), name: Notification.Name("contactChanged"),object: nil)
    }
    
    @objc func contactsStoreChanged(_ notification: Notification) {
        
        if let arr = notification.object as? [DAContactUpdateModel] {
            for model in arr {
                print("id : \(model.id) && status : \(model.status)")
                fetchContact(withIdentifier: model.id ?? "") { result in
                    switch result {
                    case let .success(contact):
                      print(contact)
                    case let .failure(error):
                      print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func getContacts() {
        requestAccess { result in
          switch result {
          case let .success(bool):
            print(bool)
            fetchContacts { result in
              switch result {
              case let .success(contacts):
                print(contacts)
              case let .failure(error):
                print(error.localizedDescription)
              }
            }
          case let .failure(error):
            print(error.localizedDescription)
          }
        }
      }

}

