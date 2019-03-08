//
//  CharactersSearchViewController.swift
//  Marvel App
//
//  Created by Mina  on 3/8/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import UIKit

class CharactersSearchViewController: ParentViewController, UITableViewDelegate , UITableViewDataSource ,UISearchBarDelegate {
    
    @IBOutlet weak var characterSearchBar: UISearchBar!
    @IBOutlet weak var characterSearchTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var searchViewModel : CharactersSearchViewModel?
    var selectedCHaracter : Character?
    var keyWord : String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchViewModel = self.modelsFactory.getCharactersSearchViewModelInstance()
        self.characterSearchBar.delegate = self
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        self.registerCells()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func registerCells(){
        let characterSearchCellNib = UINib.init(nibName: String(describing: SearchTableViewCell.self), bundle: nil)
        self.characterSearchTableView.register(characterSearchCellNib, forCellReuseIdentifier: "searchCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CHARACTER_DETAIL_SEGUE {
            let destinationVc = segue.destination as? CharacterDetailsViewController
            destinationVc?.character = self.selectedCHaracter
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyWord = searchText
        if self.characterSearchBar.text == nil || self.characterSearchBar.text == "" {
            self.searchViewModel?.resetData()
            self.characterSearchTableView.reloadData()
        }else{
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            self.searchViewModel?.getAllCharacters(thatStartswith: searchText, completion: {searchKeyword in
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
                if searchKeyword == self.keyWord{
                    if self.searchViewModel?.getCharatersCount() ?? 0 > 0 {
                        self.characterSearchTableView.reloadData()
                    }else{
                        AlertViewer().showAlertView(withMessage: "no characters start with this name", onController: self)
                    }
                }else{
                    self.searchBar(searchBar, textDidChange: self.keyWord ?? "")
                }
            })
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CharactersSearchViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchViewModel?.getCharatersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.characterSearchTableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        cell.character = self.searchViewModel?.getCharacter(atIndex: indexPath.row)
        cell.setCellViews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView(tableView, heightForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedCHaracter = self.searchViewModel?.getCharacter(atIndex: indexPath.row)
        self.performSegue(withIdentifier: CHARACTER_DETAIL_SEGUE , sender: self)
    }
}
