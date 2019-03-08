//
//  CharactersListViewModel.swift
//  Marvel App
//
//  Created by Mina  on 3/6/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

class CharactersListViewModel {
    
    let modelsFactory = ModelsFactory.sharedInstance()
    var charactersArray = [Character]()
    var charactersApiResponse : CharactersResponse?
    
    func getAllCharacters(completion : @escaping ()->()) {
        let offset = ((self.charactersApiResponse?.data?.count ?? 0) + (self.charactersApiResponse?.data?.offset ?? 0))
        
        if offset < self.charactersApiResponse?.data?.total ?? 20 {
            let url = CHARACTERS_API_URL + "&offset=\(offset)"
            self.modelsFactory.getClientInstance().fetchData(url: url, method: .get, parameters: nil) { (charactersResponse) in
                self.charactersApiResponse = self.modelsFactory.getCharactersResponseInstace(JSON: charactersResponse)
                if let characters = self.charactersApiResponse?.data?.results {
                    for character in characters {
                        self.charactersArray.append(character)
                    }
                    completion()
                }
            }
        }
    }
    
    func getCharatersCount() -> Int {
        return self.charactersArray.count
    }
    
    func getCharacter(atIndex index: Int) -> Character? {
        return self.charactersArray[index]
    }
    
}

