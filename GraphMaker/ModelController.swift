//
//  ModelController.swift
//  GraphMaker
//
//  Created by Tatiana Bernatskaya on 2018-09-22.
//  Copyright © 2018 Tatiana Bernatskaya. All rights reserved.
//

import UIKit

class ModelController: NSObject {

    var pageData: [String] = []

    override init() {
        super.init()
        let dateFormatter = DateFormatter()
        pageData = dateFormatter.monthSymbols
    }

    func viewControllerAtIndex(_ index: Int, storyboard: UIStoryboard) -> DataViewController? {
        if (self.pageData.count == 0) || (index >= self.pageData.count) {
            return nil
        }

        let dataViewController = storyboard.instantiateViewController(withIdentifier: "DataViewController") as! DataViewController
        dataViewController.dataObject = self.pageData[index]
        return dataViewController
    }

    func indexOfViewController(_ viewController: DataViewController) -> Int {
        return pageData.index(of: viewController.dataObject) ?? NSNotFound
    }
}

extension ModelController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index -= 1
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        
        index += 1
        if index == self.pageData.count {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard!)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageData.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let presentedVC = pageViewController.presentedViewController as? DataViewController else { return 5 }
        return self.indexOfViewController(presentedVC)
    }
}
