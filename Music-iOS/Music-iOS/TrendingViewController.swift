//
//  TrendingViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/21/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {

    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preparePageTabBarItem()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
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


extension TrendingViewController {
    fileprivate func preparePageTabBarItem() {
        pageTabBarItem.image = #imageLiteral(resourceName: "follow")
        pageTabBarItem.depthPreset = .depth4
    }
}
