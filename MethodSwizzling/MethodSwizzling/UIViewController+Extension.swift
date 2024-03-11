//
//  UIViewController+Extension.swift
//  MethodSwizzling
//
//  Created by Nishant Kumar on 11/03/24.
//

import UIKit

extension UIViewController {
    
    static func wrapViewControllerLifeCycleMethods() {
        
        //ViewDidLoad
        let viewDidLoadSelector = #selector(viewDidLoad)
        let customViewDidLoadSelector = #selector(customViewDidLoad)
        if let viewDidLoadClassMethod = class_getInstanceMethod(UIViewController.self, viewDidLoadSelector),
           let customViewDidLoadClassMethod = class_getInstanceMethod(UIViewController.self, customViewDidLoadSelector) {
            method_exchangeImplementations(customViewDidLoadClassMethod, viewDidLoadClassMethod)
        }
        
        //ViewWillAppear
        let viewWillAppearSelector = #selector(viewWillAppear)
        let customViewWillAppearSelector = #selector(customViewWillAppear)
        if let viewWillAppearClassMethod = class_getInstanceMethod(UIViewController.self, viewWillAppearSelector),
           let customViewWillAppearClassMethod = class_getInstanceMethod(UIViewController.self, customViewWillAppearSelector) {
            method_exchangeImplementations(customViewWillAppearClassMethod, viewWillAppearClassMethod)
        }
        
        //ViewDidAppear
        let viewDidAppearSelector = #selector(viewDidAppear)
        let customViewDidAppearSelector = #selector(customViewDidAppear)
        if let viewDidAppearClassMethod = class_getInstanceMethod(UIViewController.self, viewDidAppearSelector),
           let customViewDidAppearClassMethod = class_getInstanceMethod(UIViewController.self, customViewDidAppearSelector) {
            method_exchangeImplementations(customViewDidAppearClassMethod, viewDidAppearClassMethod)
        }
        
    }
}

extension UIViewController {
    
    @objc func customViewDidLoad() {
        print("customViewDidLoad called")
    }
    
    @objc func customViewWillAppear() {
        print("customViewWillAppear called")
    }
    
    @objc func customViewDidAppear() {
        print("customViewDidAppear called")
    }
}
