//
//  SearchViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/21/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material

class SearchViewController: UIViewController {

    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        prepareMenuButton()
        prepareStarButton()
        prepareNavigation()
        preparePageTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController {
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Search"
        navigationItem.titleLabel.textColor = Color.blue.base
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton]
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
        starButton.tintColor = Color.blue.base
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        //        menuButton.addTarget(self, action: #selector(handleMenuButton), for: .touchUpInside)
    }

    
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.image = #imageLiteral(resourceName: "search")
        pageTabBarItem.depthPreset = .depth4
    }
}
