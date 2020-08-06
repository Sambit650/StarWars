//
//  PointTableViewController.swift
//  StarWar
//
//  Created by sambit on 05/08/20.
//  Copyright © 2020 sambit.das. All rights reserved.
//

import UIKit

class PointTableViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var pointTableView: UITableView!
    
    var playerData : [PlayersDetailModel] = []
    var matchData : [MatchModel] = []
    var pointDictionary = [Int : Int]()
    var sortedArray : [SortedModel] = []
    var scoreCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI(){
        pointTableView.delegate = self
        pointTableView.dataSource = self
        playersJson()
        matchJson()
        claculatingPoints()
    }
    
    func playersJson() {
        if let url = Bundle.main.url(forResource: "StarWarsPlayers", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([PlayersDetailModel].self, from: data)
               // print(jsonData[0].name as Any)
                playerData = jsonData
            } catch {
                print("error:\(error)")
            }
        }
    }
    func matchJson() {
           if let url = Bundle.main.url(forResource: "StarWarsMatches", withExtension: "json") {
               do {
                   let data = try Data(contentsOf: url)
                   let decoder = JSONDecoder()
                   let jsonData = try decoder.decode([MatchModel].self, from: data)
               // print(jsonData[0].match as Any)
                   matchData = jsonData
               } catch {
                   print("error:\(error)")
               }
           }
       }
    
    func claculatingPoints(){
        for player in playerData{
            scoreCount = 0
            for match in matchData{
                if (match.player1.score)! > (match.player2.score)!{
                    if match.player1.id == player.id{
                        // print("player1 is winer")
                       scoreCount += 3
                    }
                }else if (match.player1.score) == (match.player2.score){
                    if match.player1.id == player.id{
                       // print("match is draw")
                        scoreCount += 1
                    }
                }else if (match.player2.score) == (match.player1.score){
                    if match.player1.id == player.id{
                       // print("match is draw")
                        scoreCount += 1
                    }
                }else{
                    if match.player2.id == player.id{
                        // print("player2 is winer")
                        scoreCount += 3
                    }
                }
            }
            pointDictionary[player.id!] = scoreCount
            var sortedModelData = SortedModel()
            sortedModelData.name = player.name
            sortedModelData.icon = player.icon
            sortedModelData.id = player.id
            sortedModelData.score = scoreCount
            sortedArray.append(sortedModelData)
        }
        //for sorting the array
        sortedArray = sortedArray.sorted(by:{ $0.score! > $1.score!})
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pointCell = pointTableView.dequeueReusableCell(withIdentifier: "PointTableViewCell", for: indexPath) as! PointTableViewCell
        pointCell.playerName.text = sortedArray[indexPath.row].name
        pointCell.playerScore.text = String(sortedArray[indexPath.row].score!)
        pointCell.configure(url: sortedArray[indexPath.row].icon!)
        return pointCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MatchTableViewController") as? MatcheTableViewController
        matchVC?.selectedID = sortedArray[indexPath.row].id!
        matchVC?.playerName = sortedArray[indexPath.row].name!
        matchVC?.matchListArray = matchData
        matchVC?.playerNameArray = playerData
        navigationController?.pushViewController(matchVC!, animated: true)
    }
    
}

extension UIImageView {
    //For extracting image from url
    func loadImage(Stringurl: String) {
        guard let url = URL(string: Stringurl) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
