//
//  ViewController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/8/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import MediaPlayer
import Material

class ViewController: UIViewController {
    
    var songs : MPMediaQuery?
    fileprivate var menuButton: IconButton!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareMenuButton()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigation()
//        MPMediaLibrary.requestAuthorization { (status) in
//            if status == MPMediaLibraryAuthorizationStatus.authorized {
//                self.songs = MPMediaQuery.songs().items
//            }
//        }
        if (MPMediaLibrary.authorizationStatus() == MPMediaLibraryAuthorizationStatus.authorized) {
            self.songs = MPMediaQuery.songs()
        }
        
        let predicate = MPMediaPropertyPredicate(value: (songs?.items?.first)?.persistentID, forProperty: MPMediaItemPropertyPersistentID)
        songs?.addFilterPredicate(predicate)
        print(songs?.items?.first?.albumArtist ?? "Nil")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    fileprivate func prepareNavigation() {
        navigationItem.title = "Material"
        navigationItem.detail = "Build Beautiful Software"
        navigationItem.titleLabel.textColor = Color.red
        navigationItem.detailLabel.textColor = Color.colorAccent
        navigationItem.leftViews = [menuButton]
        navigationItem.rightViews = [starButton, searchButton]
    }
    
    fileprivate func prepareMenuButton() {
        menuButton = IconButton(image: Icon.cm.menu)
        menuButton.tintColor = Color.red
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.star)
        starButton.tintColor = Color.red
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.search)
        searchButton.tintColor = Color.red
    }
}
