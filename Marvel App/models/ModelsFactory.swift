//
//  ModelsFactory.swift
//  Marvel App
//
//  Created by Mina  on 3/7/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

class ModelsFactory {
    
    private static var modelsFactory : ModelsFactory?
    private static let serialQueue = DispatchQueue(label: "modelsFactoryQueue")
    private init(){}
    
    static func sharedInstance() -> ModelsFactory{
        if self.modelsFactory == nil{
            self.serialQueue.sync {
                if self.modelsFactory == nil{
                    self.modelsFactory = ModelsFactory()
                }
            }
        }
        return self.modelsFactory!
    }
    
    func getClientInstance() -> ParentClient {
        return ParentClient.sharedInstance()
    }
    
    func getCharactersResponseInstace(JSON : [String : Any]) -> CharactersResponse? {
        return CharactersResponse(JSON: JSON)
    }
    
    func getCharactersCollectionResponseInstace(JSON : [String : Any]) -> CharacterCollectionResponse? {
        return CharacterCollectionResponse(JSON: JSON)
    }
    
    func getCharactersListViewModelInstace() -> CharactersListViewModel {
        return CharactersListViewModel()
    }
    
    func getCharacterDetailsViewModelInstace() -> CharacterDetailsViewModel {
        return CharacterDetailsViewModel()
    }
    
    func ApiHashGeneratorInstace() -> APIHashGenerator{
        return APIHashGenerator()
    }
    
    func getThumbnailUrlGeneratorInstance() -> ThumbnailUrlGenerator {
        return ThumbnailUrlGenerator.sharedInstance()
    }
    
    func getCharacterCollectionViewDelegateInstance() -> CharacterCollectionDelegate {
        return CharacterCollectionDelegate()
    }
    
    func getCharactersSearchViewModelInstance() -> CharactersSearchViewModel {
        return CharactersSearchViewModel()
    }
}
