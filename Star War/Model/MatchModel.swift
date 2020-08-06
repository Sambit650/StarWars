//
//  MatchModel.swift
//  StarWar
//
//  Created by DigiCollect on 05/08/20.
//  Copyright © 2020 sambit.das. All rights reserved.
//

import Foundation


struct MatchModel : Codable{
    var match : Int?
    var player1 = PlayerDetail()
    var player2 = PlayerDetail()
}


struct PlayerDetail : Codable{
    var id : Int?
    var score : Int?
    
}
