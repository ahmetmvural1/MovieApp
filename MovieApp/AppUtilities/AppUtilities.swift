//
//  AppUtilities.swift
//  MovieApp
//
//  Created by koineks teknoloji on 10.02.2020.
//  Copyright © 2020 Ahmet Muhammet Vural. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func alert(message: String, title: String = "") {
      let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
      alertController.addAction(OKAction)
      self.present(alertController, animated: true, completion: nil)
    } 
}
extension Array where Element: Equatable{
    mutating func remove (element: Element) {
        if let i = self.firstIndex(of: element) {
            self.remove(at: i)
        }
    }
}
