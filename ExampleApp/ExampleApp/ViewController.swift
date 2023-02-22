//
//  ViewController.swift
//  ExampleApp
//
//  Created by Paras Navadiya on 22/02/23.
//

import UIKit
import DAContactSync

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getContacts()
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

