//
//  URLsConstants.swift
//  Marvel App
//
//  Created by Mina  on 3/5/19.
//  Copyright © 2019 ITG. All rights reserved.
//

import Foundation

let BASE_URL = "https://gateway.marvel.com:443/"
let PUBLIC_API_RELATIVE_URL = "v1/public/"
let URL_KEY_PARAMETER = "?apikey=" + API_PUBLIC_KEY
let CHARACTERS_API_URL = BASE_URL + PUBLIC_API_RELATIVE_URL + "characters" + URL_KEY_PARAMETER
