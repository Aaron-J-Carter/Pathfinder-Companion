//Actually running the Encounter
/*
Notes on what we actually need this to do:
    For now, can just use all monsters in the database
    Rolls Initiative for all of them, plus gets initiatives input from the player characters
        Need to think about how this gets stored and utilizd proprly ^
        As well, would want some way for all of the same monster type to roll same initiative
            For given monster in database, list how many will be fighting? roll initiative once and apply to all that way?
    Then must have some overall 'Run Turn' function or something, where we have options to pick what we need, and it keeps track of actions and such and lets me know when turn is over
        When players turn, need functionality to make monsters make saving throws and take damage
    Must check when monsters are dead and remove from initiative track
    



*/

fileprivate var initiativeList: [(Monster: Monster, Initiative: Int)] = []
fileprivate var currentInitiativeIndex = 0


func runEncounter() -> Void {
    print("\n")
    print("Running Encounter")
    addMonstersToEncounter()
    addPlayersToEncounter()


    if initiativeList.isEmpty {
        print("No monsters or characters in initiative")
        return
    }


    sortInitiative()

    _runEncounter()
    print("\n")
    print("Encounter Over")
    finishEncounter()

}


func _runEncounter() -> Void {
    while true {

    if isTurnMonster(initiativeIndex: currentInitiativeIndex) {
        runMonsterTurn()
    } else {
        runPlayerTurn()
    }


    if isEncounterDone() {
        return
    }


    initiativeIndexIncrement()

    }
}

//Checks if given turn is a monster turn
func isTurnMonster(initiativeIndex: Int) -> Bool {
    return !initiativeList[initiativeIndex].Monster.Name.contains("Player: ") //Checks if the character in the initiative list, which is a struct Monster, has "Player: " in the name. Any PC character is given this as part of the name
}



//-----------------------------------
//Adds characters (player or monster) to initiative

func addMonstersToEncounter() -> Void {
    for candidate in monsterArray {
        print("\n")
        print(candidate)
        print("How many copies of this monster will be in the combat?")
        var numOfMon = getUserInput()

        while !isInputPositiveIntger(numOfMon, includeZero: true) {
            print("Please input a positive integer, or 0 to have this monster not appear")
            numOfMon = getUserInput()
        }


        var initiativeRoll:Int

        print("\n")
        print("Is this monster going to roll perception for initiative? (y/n)")
        let initiativePerceptionInput = getUserInput()
        if (initiativePerceptionInput.lowercased() == "n") || (initiativePerceptionInput.lowercased() == "no") {
            print("\n")
            print("What skill will be used for initiative?")
            let initiativeSkillInput = getUserInput()
            
            initiativeRoll = candidate.rollInitiative(skill: initiativeSkillInput)
        } else {
            initiativeRoll = candidate.rollInitiative()
        }






        for _ in 0..<Int(numOfMon)! {
            initiativeList.append((Monster: candidate, Initiative: initiativeRoll))
        }

        print("\n")
        print("\(numOfMon) copies of \(candidate.Name) added to the encounter list")

    }
}

func addPlayersToEncounter() -> Void {
    print("\n")
    print("How many player characters will be in the encounter?")
    var numOfPC = getUserInput()
    while !isInputPositiveIntger(numOfPC, includeZero: true) {
            print("Please input a positive integer, or 0 to have no player characters in this combat")
            numOfPC = getUserInput()
        }

    for repeatIndex in 0..<Int(numOfPC)! {
        print("\n")
        
        if repeatIndex == 0 {
            print("What is the first player's name?")
        } else if repeatIndex == Int(numOfPC)! - 1 {
            print("What is the last player's name?")
        } else {
            print("What is the next player's name?")
        }

        let PCName = getUserInput()
        
        print("\n")
        print("What is the player's initiative?")
        
        var initiativeDONE = false

        while !initiativeDONE {
            let PCInitiative = getUserInput()
        
            if Int(PCInitiative) == nil {
                print("Please input an integer")
            }

            else {
                let listIndex = initiativeList.count
                initiativeList.append((Monster: Monster(), Initiative: Int(PCInitiative)!))
                initiativeList[listIndex].Monster.setCoreAttributes(Name: "Player: " + PCName, Perception: -1, AC: -1, Fort: -1, Ref: -1, Will: -1, Speed: -1, HP: -1)

                initiativeDONE = true
            }

        }

        print("Player character added! \n")

    }
}




//-----------------------------------
//Monster turn functions
func runMonsterTurn() -> Void {
    print("Running turn for \(initiativeList[currentInitiativeIndex].Monster.Name)")

    while !initiativeList[currentInitiativeIndex].Monster.isTurnOver() {
        print("\n")
        print("1: Attack")
        print("2: Move")
        print("3: Skill Check")
        print("4: Alternate Ability")
        print("Please input what you would like for your action")
        print("You have taken \(initiativeList[currentInitiativeIndex].Monster.currentActionCount - 1) action(s) so far")

        let actionInput = getUserInput()

        switch actionInput.lowercased() {
            case "1", "attack":
                monsterAttackTurn()
            case "2", "move":
                monsterMoveTurn()
            case "3", "skill", "skill check":
                monsterSkillTurn()
            case "4", "alternate", "alternate ability":
                monsterAlternateTurn()
            default:
                print("Command not understood")
        }

    }

    initiativeList[currentInitiativeIndex].Monster.endTurn()
    if !initiativeList[currentInitiativeIndex].Monster.stillAliveChecker() {
        removeMonsterFromInitiative(initiativeIndex: currentInitiativeIndex)
        currentInitiativeIndex -= 1

        print("\(initiativeList[currentInitiativeIndex].Monster.Name) is now dead and removed from initiative!")
    }
}

func monsterAttackTurn() -> Void {
    if initiativeList[currentInitiativeIndex].Monster.Attacks.count == 1 {
        let attackName = initiativeList[currentInitiativeIndex].Monster.Attacks[0].name
        print(initiativeList[currentInitiativeIndex].Monster.strikeAttempt(name: attackName))
        
        initiativeList[currentInitiativeIndex].Monster.actionCountIncrement()

    } else if initiativeList[currentInitiativeIndex].Monster.Attacks.count == 0 {
        print("Error, no attacks found, action not completed")
    } else {
        _monsterAttackTurn()
    }
}

func _monsterAttackTurn() -> Void {
    print("\n")
    for index in 1...initiativeList[currentInitiativeIndex].Monster.Attacks.count {
        print("\(index): \(initiativeList[currentInitiativeIndex].Monster.Attacks[index-1].name)")
    }
    
    print("Which strike?")
    let strikeNameInput = getUserInput()

    for index in 1...initiativeList[currentInitiativeIndex].Monster.Attacks.count {
        let strikeName = initiativeList[currentInitiativeIndex].Monster.Attacks[index - 1].name

        if (strikeNameInput == String(index)) || (strikeNameInput.lowercased() == strikeName) {
            print(initiativeList[currentInitiativeIndex].Monster.strikeAttempt(name: strikeName))

            initiativeList[currentInitiativeIndex].Monster.actionCountIncrement()

            return
        }
    }

    print("Strike not found")
    _monsterAttackTurn()
}

func monsterMoveTurn() -> Void {
    print("\n")
    print("Speed is:\(initiativeList[currentInitiativeIndex].Monster.Speed)")
    initiativeList[currentInitiativeIndex].Monster.actionCountIncrement()
}

func monsterSkillTurn() -> Void {
    print("\n")
    print("What skill will be rolled?")
    let skillInput = getUserInput()
    print(initiativeList[currentInitiativeIndex].Monster.rollSkill(skill: skillInput))
    initiativeList[currentInitiativeIndex].Monster.actionCountIncrement()
}

func monsterAlternateTurn() -> Void {
    print("\n")
    print("No in program implementation yet, action count incremented")
    initiativeList[currentInitiativeIndex].Monster.actionCountIncrement()
}




//-----------------------------------
//Player turn functions
func runPlayerTurn() -> Void {
    print("\n")
    print("Running turn for \(initiativeList[currentInitiativeIndex].Monster.Name)")

    print("1: Armor Class (AC)")
    print("2: Saving Throw (ST)")
    print("3: End Turn")
    print("Please input if the attack will require a saving throw or an AC check")

    let playerTurnInput = getUserInput()
    
    switch playerTurnInput.lowercased() {
        case "1", "ac", "armor class":
            runPlayerTurnAC()
        case "2", "st", "saving throw":
            runPlayerTurnST()
        case "3", "exit", "end", "end turn":
            print("Player turn over")
            return
        default:
            print("Command not understood")
    }
    runPlayerTurn()
}

//Handles hitting a single monsters AC
func runPlayerTurnAC() -> Void {
    
    
    
    func hitMonster(_ index: Int) {

        let damageDict = getDamageDict()

        dealMonsterDamage(index: index, damage: damageDict)


        var totalDamage = 0
        for (_, damageValue) in damageDict {
            totalDamage += damageValue
        }

        print("\n")
        if initiativeList[index].Monster.stillAliveChecker() {
            print("Monster was dealt \(totalDamage) and now has \(initiativeList[index].Monster.HP) health left")
        } else {
            print("Monster is now dead")
            if index <= currentInitiativeIndex {
                currentInitiativeIndex -= 1
            }
            removeMonsterFromInitiative(initiativeIndex: (index))

            
        }
        return
    }
    

    func getDamageDict() -> [String : Int] {
        var damageDict: [String : Int] = [:]
        while true {
            print("\n")
            print("How much damage?")
            var playerAttackDamage = getUserInput()

            while Int(playerAttackDamage) == nil {
                print("Please type in an integer")
                playerAttackDamage = getUserInput()
            }

            print("\n")
            print("Of what kind?")
            let playerAttackType = getUserInput()

            damageDict[playerAttackType] = Int(playerAttackDamage)!

            print("\n")
            print("Add more damage types? (y/n)")
            let endLoopInput = getUserInput()
            
            switch endLoopInput.lowercased() {
                case "n", "no":
                    return damageDict
                default:
                    break
            }

        }
    }




    
    
    print("\n")
    for (index, monster) in initiativeList.enumerated() {
        print("\(index + 1): \(monster.Monster)")
    }

    print("\n")
    print("Who will be affected? Please input index number or name")
    let playerAttackTarget = getUserInput()

    for (index, monster) in initiativeList.enumerated() {
        let monName = monster.Monster.Name
        if (playerAttackTarget == String(index + 1)) || (playerAttackTarget == monName) {
            print("\n")
            print("Roll to hit?")
            var playerAttackRoll = getUserInput()

            while Int(playerAttackRoll) == nil {
                print("Please type in an integer")
                playerAttackRoll = getUserInput()
            }

            if Int(playerAttackRoll)! >= initiativeList[index].Monster.AC {
                hitMonster(index)
                return
            }
            else {
                print("Attack misses")
                return
            }

        }
    }
}

//Handles hitting a group of monsters (or a single one) with a saving throw style attack (Currently only deals damage on a basic save type deal, does not add other effects)
func runPlayerTurnST() -> Void {

    func STChecker() -> [(index: Int, saved: String)] {
        var savedArray: [(index: Int, saved: String)] = []
        
        for index in attackArray {
            if !initiativeList[index].Monster.Name.contains("Player: ") {
                var saved: String
                let savedValue = initiativeList[index].Monster.rollSave(type: STType) - Int(STDC)!
                switch savedValue {
                    case 10...:
                        saved = "Critical Success"
                    case 0...9:
                        saved = "Success"
                    case (-10)...(-1):
                        saved = "Failure"
                    case ...(-10):
                        saved = "Critical Failure"
                    default:
                        saved = "Failure"
                    
                }
                
                
                savedArray.append((index, saved))
            }
        }

        return savedArray
    }





    print("\n")
    for (index, monster) in initiativeList.enumerated() {
        print("\(index + 1): \(monster)")
    }

    print("\n")
    print("Who will be affected? Please input index's or name's of all monsters affected, separated by commas")

    //AttackArray holds the index in the initiative order for each monster effected by the attack
    var attackArray: [Int] = []
    let playerAttackTarget = getUserInput()
    let playerAttackTargetArray = playerAttackTarget.split(separator: ",")
    
    
    
    for attackName in playerAttackTargetArray {
        let _attackName = attackName.trimmingCharacters(in: .whitespaces)


        for (index, monster) in initiativeList.enumerated() {
            let monName = monster.Monster.Name
            if (_attackName == String(index + 1)) || (_attackName == monName) {
                attackArray.append(index)

            }
        }

    }

    print("\n")
    print("What type of saving throw is this?")
    print("1: Reflex")
    print("2: Fortitude")
    print("3: Will")

    let STTypeInput = getUserInput()
    var STType: String
    switch STTypeInput.lowercased() {
        case "1", "reflex", "ref","dex":
            STType = "Reflex"
        case "2", "fortitude", "fort","con":
            STType = "Fortitude"
        case "3", "will","wisdom","wis":
            STType = "Will"
        default:
            STType = ""
    }


    print("\n")
    print("What is the DC?")
    var STDC = getUserInput()

    while Int(STDC) == nil {
        print("Please input an integer")
        STDC = getUserInput()
    }


    //Saved Array is (index of monster in initiative array, string for what degree of success)
    let savedArray: [(index: Int, saved: String)] = STChecker()

    print("\n")
    print("How much damage was rolled?")
    var attackDamage = getUserInput()
    print("What type of damage is it?")
    let attackType = getUserInput()

    while Int(attackDamage) == nil {
        print("Please input an integer")
        attackDamage = getUserInput()
    }




    for (index, saved) in savedArray {
        switch saved {
            case "Critical Success":
                break
            case "Success":
                var damagedHalfed = Double(attackDamage)! * 0.5
                damagedHalfed.round(.up)
                dealMonsterDamage(index: index, damage: [attackType : Int(exactly: damagedHalfed)!])
            case "Failure":
                dealMonsterDamage(index: index, damage: [attackType : Int(attackDamage)!])
            case "Critical Failure":
                dealMonsterDamage(index: index, damage: [attackType : (Int(attackDamage)! * 2)])
            default:
                break
        }
    }


    for (index, _) in savedArray {
        if !initiativeList[index].Monster.stillAliveChecker() {
            print("\n")
            print("\(initiativeList[index].Monster.Name) is now dead")
            removeMonsterFromInitiative(initiativeIndex: index)
        }
        return
    }

}
















//-----------------------------------
//General helper functions


//Checks if battle is done, returns true if so
func isEncounterDone() -> Bool {
    return (onlyPlayers() || onlyMonsters())
}


func onlyPlayers() -> Bool {
    for (monster, _) in initiativeList {
        if !monster.Name.contains("Player: ") {
            return false
        }
    }
    
    return true
}


func onlyMonsters() -> Bool {
    for (monster, _) in initiativeList {
        if monster.Name.contains("Player: ") {
            return false
        }
    }
    
    return true
}







func finishEncounter() -> Void {
    initiativeList = []
    currentInitiativeIndex = 0
}



//Deals damage to monster at initiative index
func dealMonsterDamage(index: Int, damage: [String : Int]) -> Void {
    initiativeList[index].Monster.takeDamage(damage: damage)
}

//Removes monster at initiative index from the battle
func removeMonsterFromInitiative(initiativeIndex: Int) -> Void {
    initiativeList.remove(at: initiativeIndex)
}

//Increments the initiativelist array to go to the next turn
func initiativeIndexIncrement() -> Void {
    currentInitiativeIndex += 1

    if currentInitiativeIndex >= initiativeList.count {
        currentInitiativeIndex = 0
    }
}

//Sorts initiativeList by initiative number
func sortInitiative() -> Void {
    initiativeList.sort { $0.Initiative > $1.Initiative }
}