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
        print(contactsChangeNotifier!)
        NotificationCenter.default.addObserver(self, selector: #selector(contactsStoreChanged), name: NSNotification.Name.CNContactStoreDidChange, object: nil)
    }
    
   
    @objc func contactsStoreChanged(_ notification: Notification){
        print("Contact updated : \(notification.userInfo)")
        guard let events = notification.contactsChangeEvents else { return }
        events.map { temp in
            debugPrint("Change history : \(temp)")
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

