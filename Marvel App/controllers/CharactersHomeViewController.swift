//
//  CharactersHomeViewController.swift
//  Marvel App
//
//  Created by Mina  on 3/6/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit

class CharactersHomeViewController: ParentViewController, UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var charactersTableView: UITableView!
    var charactersListViewModel : CharactersListViewModel?
    var loadMoreCharacters = false
    var selectedCHaracter : Character?
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
    }
    override func viewDidAppear(_ animated: Bool) {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
        imageView.contentMode = .center
        let image = UIImage(named: "icn-nav-marvel")
        imageView.image = image
        self.navigationItem.titleView = imageView
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.charactersListViewModel = self.modelsFactory.getCharactersListViewModelInstace()
        self.registerCells()
        self.loadCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func registerCells(){
        let characterCellNib = UINib.init(nibName: String(describing: CharactersHomeTableViewCell.self), bundle: nil)
        self.charactersTableView.register(characterCellNib, forCellReuseIdentifier: "characterCell")
        let nibLoading = UINib.init(nibName: String(describing: LoadingTableViewCell.self), bundle: nil)
        self.charactersTableView.register(nibLoading, forCellReuseIdentifier: "loadingCell")
    }
    
    private func loadCharacters () {
        self.charactersListViewModel?.getAllCharacters {
            self.loadMoreCharacters = true
            self.charactersTableView.reloadData()
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > (contentHeight - scrollView.frame.height) {
            if self.loadMoreCharacters {
                self.loadMoreCharacters = false
                let loadingIndexPath = IndexPath(row: 0, section: 1)
                self.charactersTableView.reloadRows(at: [loadingIndexPath], with: .none)
                self.loadCharacters()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CHARACTER_DETAIL_SEGUE {
            let destinationVc = segue.destination as? CharacterDetailsViewController
            destinationVc?.character = self.selectedCHaracter
        }
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {
        self.performSegue(withIdentifier: SEARCH_SEGUE, sender: self)
    }
}

extension CharactersHomeViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.charactersListViewModel?.getCharatersCount() ?? 0
        }else if section == 1 && !self.loadMoreCharacters {
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.charactersTableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharactersHomeTableViewCell
            cell?.character = self.charactersListViewModel?.getCharacter(atIndex: indexPath.row)
            cell?.setCellViews()
            return cell ?? UITableViewCell()
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingTableViewCell
            if !self.loadMoreCharacters {
                cell?.activityIndicatorView.startAnimating()
            }else{
                cell?.activityIndicatorView.stopAnimating()
            }
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150.0
        }else{
            return 60.0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCHaracter = self.charactersListViewModel?.getCharacter(atIndex: indexPath.row)
        self.performSegue(withIdentifier: CHARACTER_DETAIL_SEGUE , sender: self)
    }
}
