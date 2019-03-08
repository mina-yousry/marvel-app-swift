//
//  CharactersSearchViewModel.swift
//  Marvel App
//
//  Created by Mina  on 3/8/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

class CharactersSearchViewModel {
    
    let modelsFactory = ModelsFactory.sharedInstance()
    var charactersSearchArray = [Character]()
    var charactersApiResponse : CharactersResponse?
    
    func getAllCharacters(thatStartswith keyWord:String,completion : @escaping (String)->()) {
        let allowedCharacterSet = (CharacterSet(charactersIn: "! * ' ( ) ; : @ & = + $ , / ? % # [ ]").inverted)
        let keyWordEncoded = keyWord.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
        let url = CHARACTERS_API_URL + "&nameStartsWith=\(keyWordEncoded ?? "")"
        self.modelsFactory.getClientInstance().fetchData(url: url, method: .get, parameters: nil) { (charactersResponse) in
            self.charactersApiResponse = self.modelsFactory.getCharactersResponseInstace(JSON: charactersResponse)
            if let characters = self.charactersApiResponse?.data?.results {
                for character in characters {
                    self.charactersSearchArray.append(character)
                }
                completion(keyWord)
            }
        }
    }
    
    func getCharatersCount() -> Int {
        return self.charactersSearchArray.count
    }
    
    func getCharacter(atIndex index: Int) -> Character? {
        return self.charactersSearchArray[index]
    }
    
    func resetData(){
        self.charactersApiResponse = nil
        self.charactersSearchArray = [Character]()
    }
}
