//
//  SongsViewController.swift
//  Test_Music
//
//  Created by Sai Krishna Dubagunta on 6/10/17.
//  Copyright © 2017 Sai Krishna Dubagunta. All rights reserved.
//

import UIKit
import Material
import MediaPlayer
import RealmSwift

class SongsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MPMediaPickerControllerDelegate {

    static var playlist : Playlist!
    static var realm : Realm!
    fileprivate var starButton: IconButton!
    fileprivate var searchButton: IconButton!
    var tableView = UITableView()
    let songs = SongsViewController.playlist.songs
    let name = SongsViewController.playlist.name
    let id = SongsViewController.playlist.id
    var edit = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareStarButton()
        prepareSearchButton()
        prepareNavigation()
        prepareTableView()
        setEditingForTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return SongsViewController.playlist.songs.count;
    }
    
    
    @objc func setEditingForTable() {
        self.edit = !(edit)
        tableView.setEditing(self.edit , animated: true)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "songCell")
        cell.height = 75
        cell.textLabel?.text = songs[indexPath.row].songName
        cell.detailTextLabel?.text = songs[indexPath.row].artistName
        cell.imageView?.image = UIImage(data: Data(base64Encoded: songs[indexPath.row].imageData)!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let realm = SongsViewController.realm
            try! realm?.write {
                let playList1 = realm?.objects(Playlist.self).filter(NSPredicate(format: "id = \(id)")).first
                let songs = (playList1?.songs)!
                songs.remove(objectAtIndex: indexPath.row)
                if (songs.count) < 1 {
                    let alert = UIAlertController(title: "Warning!", message: "delete playlist?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
                        try! realm?.write {
                            realm?.delete(playList1!)
                        }
                        self.popToView()
                    })) //Remove Playlist
                        
                    alert.addAction(UIAlertAction(title: "No, Add more songs", style: .destructive, handler: { (action) in
                        self.setEditingForTable()
                        self.addMoreSongs()
                    })) //Add songs
                    self.present(alert, animated: true, completion: nil)
                }
                playList1?.songs = songs
                realm?.add(playList1!)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    @objc func addMoreSongs() {
        let picker  = MPMediaPickerController(mediaTypes: .music)
        picker.allowsPickingMultipleItems = true
        picker.delegate=self
        picker.showsCloudItems = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        mediaPicker.dismiss(animated: true, completion: nil)
    }
    
    public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection){
        let items = mediaItemCollection.items
        mediaPicker.dismiss(animated: true, completion: nil)
        addToRealm(playlist: SongsViewController.realm.objects(Playlist.self).filter(NSPredicate(format: "id = \(id)")).first!, mediaItems: items)
    }
    
    
    func addToRealm(playlist : Playlist, mediaItems : [MPMediaItem]){
        let realm = SongsViewController.realm
        try! realm?.write {
            for item in mediaItems {
                let image = item.artwork?.image(at: (item.artwork?.bounds.size)!)
                let imageData = UIImagePNGRepresentation(image!)
                realm?.object(ofType: Playlist.self, forPrimaryKey: id)?.songs.append(Song(value: ["imageData" : imageData?.base64EncodedString(options: .endLineWithCarriageReturn), "presistenID" : "\(item.persistentID)","songName":item.title,"artistName" : item.albumArtist]))
            }
        }
        self.tableView.reloadData()

    }
}

extension SongsViewController {
    
    fileprivate func popToView() {
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func prepareStarButton() {
        starButton = IconButton(image: Icon.cm.add)
        starButton.pulseColor = Color.colorPrimary
        starButton.tintColor = Color.colorPrimary
        starButton.addTarget(self, action: #selector(addMoreSongs), for: .touchUpInside)
    }
    
    fileprivate func prepareSearchButton() {
        searchButton = IconButton(image: Icon.cm.edit)
        searchButton.pulseColor = Color.colorPrimary
        searchButton.tintColor = Color.colorPrimary
        searchButton.addTarget(self, action: #selector(setEditingForTable), for: .touchUpInside)
    }
    
    fileprivate func prepareNavigation() {
        navigationItem.title = SongsViewController.playlist.name
        navigationItem.titleLabel.textColor = Color.colorPrimary
        navigationItem.backButton.tintColor = Color.colorPrimary
        navigationItem.rightViews = [starButton,searchButton]
    }
    
    func prepareTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "songCell")
        self.setEditingForTable()
        view.addSubview(tableView)
    }
    
}
