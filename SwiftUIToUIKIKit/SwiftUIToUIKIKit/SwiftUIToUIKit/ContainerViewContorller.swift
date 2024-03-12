//
//  ViewController.swift
//  SwiftUIToUIKIKit
//
//  Created by Nishant Kumar on 12/03/24.
//

import UIKit
import SwiftUI

class ContainerViewContorller: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateContainerView()
    }

    func updateContainerView() {
        let swiftUIView = UserView()
        let hostingController = UIHostingController(rootView:swiftUIView)
        if let userView = hostingController.view {
            userView.translatesAutoresizingMaskIntoConstraints = false
            self.containerView.addSubview(userView)
            self.containerView.addConstraints([
                userView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                userView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                userView.topAnchor.constraint(equalTo: containerView.topAnchor),
                userView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
        }
    }
}
