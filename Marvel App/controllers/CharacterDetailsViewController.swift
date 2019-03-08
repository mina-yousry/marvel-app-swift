//
//  CharacterDetailsViewController.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: ParentViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descreptionTxtView: UITextView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var eventsCollectionView: UICollectionView!
    @IBOutlet weak var relatedUrlsTableView: UITableView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    
    var character : Character?
    var characterDetailsViewModel : CharacterDetailsViewModel?
    var comicsDelegate : CharacterCollectionDelegate?
    var seriesDelegate : CharacterCollectionDelegate?
    var eventsDelegate : CharacterCollectionDelegate?
    var storiesDelegate : CharacterCollectionDelegate?
    var offset : CGFloat = 0.0
    
    override func viewWillAppear(_ animated: Bool) {
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController?.navigationBar.isTranslucent = true
        self.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterDetailsViewModel = ModelsFactory.sharedInstance().getCharacterDetailsViewModelInstace()
        if #available(iOS 11.0, *) {
            self.mainScrollView.contentInsetAdjustmentBehavior = .never
        }
        self.registerCells()
        self.setViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViews(){
        if let _ = self.character {
            let thumbnailUrlGenerator = ModelsFactory.sharedInstance().getThumbnailUrlGeneratorInstance()
            let urlString = thumbnailUrlGenerator.generateThumbnailUrl(fromThumbnail: self.character?.thumbnail, withSizeKey: SQUARE_SIZE_KEY)
            let url = URL(string : urlString)
            self.backGroundImage.kf.setImage(with: url)
            self.coverImage.kf.setImage(with: url)
            self.nameLbl.text = self.character?.name
            self.descreptionTxtView.text = self.character?.description
            self.relatedUrlsTableView.delegate = self
            self.relatedUrlsTableView.dataSource = self
            self.relatedUrlsTableView.reloadData()
            self.loadCollections()
        }
    }
    
    func loadCollections(){
        self.characterDetailsViewModel?.getCharacterCollection(forCharacterCollection: self.character?.comics, completion: { (apiItems) in
            self.comicsDelegate = self.modelsFactory.getCharacterCollectionViewDelegateInstance()
            self.comicsDelegate?.items = apiItems ?? [Item]()
            self.comicsCollectionView.delegate = self.comicsDelegate
            self.comicsCollectionView.dataSource = self.comicsDelegate
            self.comicsCollectionView.reloadData()
        })
        
        self.characterDetailsViewModel?.getCharacterCollection(forCharacterCollection: self.character?.series, completion: { (apiItems) in
            self.seriesDelegate = self.modelsFactory.getCharacterCollectionViewDelegateInstance()
            self.seriesDelegate?.items = apiItems ?? [Item]()
            self.seriesCollectionView.delegate = self.seriesDelegate
            self.seriesCollectionView.dataSource = self.seriesDelegate
            self.seriesCollectionView.reloadData()
        })
        
        self.characterDetailsViewModel?.getCharacterCollection(forCharacterCollection: self.character?.events, completion: { (apiItems) in
            self.eventsDelegate = self.modelsFactory.getCharacterCollectionViewDelegateInstance()
            self.eventsDelegate?.items = apiItems ?? [Item]()
            self.eventsCollectionView.delegate = self.eventsDelegate
            self.eventsCollectionView.dataSource = self.eventsDelegate
            self.eventsCollectionView.reloadData()
        })
        
        self.characterDetailsViewModel?.getCharacterCollection(forCharacterCollection: self.character?.stories, completion: { (apiItems) in
            self.storiesDelegate = self.modelsFactory.getCharacterCollectionViewDelegateInstance()
            self.storiesDelegate?.items = apiItems ?? [Item]()
            self.storiesCollectionView.delegate = self.storiesDelegate
            self.storiesCollectionView.dataSource = self.storiesDelegate
            self.storiesCollectionView.reloadData()
        })
    }
    
    private func registerCells(){
        let urlCellNib = UINib.init(nibName: String(describing: UrlTableViewCell.self), bundle: nil)
        self.relatedUrlsTableView.register(urlCellNib, forCellReuseIdentifier: "urlCell")
        
        let collectionCellNib = UINib.init(nibName: String(describing: CharacterCollectionViewCell.self), bundle: nil)
        self.comicsCollectionView.register(collectionCellNib, forCellWithReuseIdentifier: "characterCollectionCell")
        self.seriesCollectionView.register(collectionCellNib, forCellWithReuseIdentifier: "characterCollectionCell")
        self.eventsCollectionView.register(collectionCellNib, forCellWithReuseIdentifier: "characterCollectionCell")
        self.storiesCollectionView.register(collectionCellNib, forCellWithReuseIdentifier: "characterCollectionCell")
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.offset = scrollView.contentOffset.y
        //250 is my cover uimage view height
        let threshould = 250.0 - (60.0)
        if scrollView.contentOffset.y >= CGFloat(threshould) {
            self.navigationController?.navigationBar.isTranslucent = false
            self.title = self.character?.name
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.title = ""
        }
    }
}

extension CharacterDetailsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.character?.urls?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.relatedUrlsTableView.dequeueReusableCell(withIdentifier: "urlCell", for: indexPath) as! UrlTableViewCell
        cell.url = self.character?.urls?[indexPath.row]
        cell.setViews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: self.character?.urls?[indexPath.row].url ?? "")
        UIApplication.shared.open(url!)
    }
}
