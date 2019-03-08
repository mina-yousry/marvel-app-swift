//
//  CharacterDetailsViewModel.swift
//  Marvel App
//
//  Created by Mina  on 3/8/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

class CharacterDetailsViewModel {
    
    let modelsFactory = ModelsFactory.sharedInstance()
    
    func getCharacterCollection(forCharacterCollection collection : CharacterCollection? ,completion : @escaping ([Item]?)->()) {
        let url = collection?.collectionURI ?? ""
        let urlWithKey = url + URL_KEY_PARAMETER
        self.modelsFactory.getClientInstance().fetchData(url: urlWithKey, method: .get, parameters: nil) { (charactersCollectionResponse) in
            let collectionApiResponse = self.modelsFactory.getCharactersCollectionResponseInstace(JSON: charactersCollectionResponse)
            completion(collectionApiResponse?.data?.results)
        }
    }
}
