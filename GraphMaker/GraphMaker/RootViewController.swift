//
//  RootViewController.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var pageViewController: UIPageViewController? {
        didSet {
            if (pageViewController != nil) {
                setupPageViewController()
            }
        }
    }
    
    var _modelController: ModelController? = nil
    var modelController: ModelController {
        if _modelController == nil {
            _modelController = ModelController()
        }
        return _modelController!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func setupPageViewController() {
        guard
            let pageViewController = self.pageViewController,
            let startingViewController: DataViewController = self.modelController.viewControllerAtIndex(0, storyboard: self.storyboard!)
            else { return }
        
        let viewControllers = [startingViewController]
        pageViewController.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        pageViewController.dataSource = self.modelController
        
        self.addChild(pageViewController)
        self.view.addSubview(pageViewController.view)
        
        var pageViewRect = self.view.bounds
        if UIDevice.current.userInterfaceIdiom == .pad {
            pageViewRect = pageViewRect.insetBy(dx: 40.0, dy: 40.0)
        }
        pageViewController.view.frame = pageViewRect
        pageViewController.didMove(toParent: self)
    }
}

