//
//  ViewController.swift
//  Music-iOS
//
//  Created by Sai Krishna Dubagunta on 6/8/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import MediaPlayer
import RealmSwift

class ViewController: UIViewController, MPMediaPickerControllerDelegate{
    internal lazy var heights = [IndexPath: CGFloat]()
    
    var playlists  : Results<Playlist>!
    var songs : MPMediaQuery!
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var realm = try! Realm()
    fileprivate var buttons = [Button]()
    fileprivate var tabBar: TabBar!
    static var notificationToken : NotificationToken?
    static var realm : Realm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStarButton()
        prepareMenuButton()
        prepareNavigation()
        self.view.backgroundColor = Color.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        override func viewWillDisappear(_ animated: Bool) {
    }
    
}

extension ViewController {
    
    fileprivate func prepareNavigation() {
        navigationItem.title = "Playlists"
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
    
}

extension ViewController : TabBarDelegate {
    func tabBar(tabBar: TabBar, willSelect button: UIButton) {
        print("will select")
    }
    
    func tabBar(tabBar: TabBar, didSelect button: UIButton) {
        print("did select")
    }
}
