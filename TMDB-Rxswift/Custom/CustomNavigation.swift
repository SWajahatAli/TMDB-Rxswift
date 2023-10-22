//
//  CustomNavigation.swift
//  TMDB-Rxswift
//
//  Created by Syed Wajahat Ali on 15/10/2023.
//

import UIKit

class CustomNavigation: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

}
