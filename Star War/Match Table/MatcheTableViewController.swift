//
//  MatchTableViewController.swift
//  StarWar
//
//  Created by sambit on 05/08/20.
//  Copyright © 2020 sambit.das. All rights reserved.
//

import UIKit

class MatcheTableViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var matchTableView: UITableView!
    
    var selectedID : Int = 0
    var playerName = ""
    var matchListArray : [MatchModel] = []
    var sortedMatchArray : [MatchModel] = []
    var playerNameArray : [PlayersDetailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    func setUI(){
        matchTableView.delegate = self
        matchTableView.dataSource = self
        navigationItem.title = playerName
        getMatchList()
        
    }
    
    func getMatchList(){
        for match in matchListArray{
            if selectedID == match.player1.id || selectedID == match.player2.id{
                sortedMatchArray.append(match)
            }
        }
    }
    
    //For identify name by id
    func getIdToPlayerName(id : Int)->String{
        var playerName = ""
        for name in playerNameArray{
            if id == name.id{
                playerName = name.name!
            }
        }
        return playerName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedMatchArray.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let matchCell = matchTableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
        matchCell.firstPlayer.text = getIdToPlayerName(id: sortedMatchArray[indexPath.row].player1.id!)
        matchCell.secondPlayer.text = getIdToPlayerName(id: sortedMatchArray[indexPath.row].player2.id!)
        matchCell.matchScore.text = "\(sortedMatchArray[indexPath.row].player1.score!) - \(sortedMatchArray[indexPath.row].player2.score!)"
    
        //for checking cell color
        if selectedID == sortedMatchArray[indexPath.row].player1.id{
            if sortedMatchArray[indexPath.row].player1.score! > sortedMatchArray[indexPath.row].player2.score!{
                //win
                matchCell.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else if sortedMatchArray[indexPath.row].player1.score! == sortedMatchArray[indexPath.row].player2.score!{
                //draw
                matchCell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                //lose
                matchCell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }else{
            if sortedMatchArray[indexPath.row].player2.score! > sortedMatchArray[indexPath.row].player1.score!{
                //win
                matchCell.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }else if sortedMatchArray[indexPath.row].player2.score! == sortedMatchArray[indexPath.row].player1.score!{
                //draw
                matchCell.contentView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                //lose
                matchCell.contentView.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            }
        }
        return matchCell
       }

}
