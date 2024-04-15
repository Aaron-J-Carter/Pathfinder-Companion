//Monster Adding/Editing/Printing
import Foundation

var monsterArray:[Monster] = []


func addMonster() -> Void {
    print("\n")
    print("Adding Blank Monster Template")
    print("\n")
    monsterArray.append(Monster())
}

//Main function called from initial menu. Lists all monsters and calls function to edit specific monster
func editMonster() -> Void {
    while true {
        printMonsters()
        print("Please input index number of Monster you wish to edit, or \"Exit\" to exit the monster editor")
        let monsterChoice = getUserInput()

        if monsterChoice.lowercased() == "exit" {
            return
        }

        if Int(monsterChoice) == nil {
            print("Please input a number")
            print("\n")
        }


        for (monsterIndex, _) in monsterArray.enumerated() {
            if (Int(monsterChoice) ?? 0) - 1 == monsterIndex {
                editGivenMonster(givenMonster: &monsterArray[monsterIndex])
            }
        }

    }
}


//Second stage of edit monster function, takes specific monster and breaks dows the editing to specific attributes and calls function for each
func editGivenMonster(givenMonster: inout Monster) -> Void {
    while true {
        print("\n")
        print(givenMonster)
        print("What would you like to edit?")
        print("1: Core Attributes")
        print("2: Ability Scores")
        print("3: Conditions")
        print("4: Skills")
        print("5: Attacks")
        print("6: Resistances")
        print("7: Weaknesses")
        print("8: Exit")
        let whatToEditInput = getUserInput()

        switch whatToEditInput {
            case "1", "Core Attributes":
                editAttributes(givenMonster: &givenMonster)
            case "2", "Ability Scores":
                editAbilityScores(givenMonster: &givenMonster)
            case "3", "Conditions":
                editChoice(givenMonster: &givenMonster, choice: "condition")
            case "4", "Skills":
                editChoice(givenMonster: &givenMonster, choice: "skill")
            case "5", "Attacks":
                editAttacks(givenMonster: &givenMonster)
            case "6", "Resistances":
                editChoice(givenMonster: &givenMonster, choice: "resistance")
            case "7", "Weaknesses":
                editChoice(givenMonster: &givenMonster, choice: "weakness")
            case "8", "exit", "Exit", "EXIT":
                return
            default:
                print("Command Not Understood")
        }

    }

}

//Edits core attributes for given monster
func editAttributes(givenMonster: inout Monster) -> Void {
    var monName = givenMonster.Name
    var monPerception = givenMonster.Perception
    var monAC = givenMonster.AC
    var monFort = givenMonster.Fort
    var monRef = givenMonster.Ref
    var monWill = givenMonster.Will
    var monSpeed = givenMonster.Speed
    var monHP = givenMonster.HP

    var newName:String
    var newAttribute: Int
    var attributeEXIT = false
    var attributeInput: String
    
    repeat {
        print("\n")
        print("Attributes to Change:")
        print("1: Name")
        print("2: Perception")
        print("3: Armor Class")
        print("4: Fortitude Save")
        print("5: Reflex Save")
        print("6: Will Save")
        print("7: Speed")
        print("8: Health")
        print("Type SAVE to save changes, or EXIT to discard them")
        attributeInput = getUserInput()
        switch attributeInput.lowercased() {
            case "name", "1":
                print("What would you like the new name to be?")
                newName = getUserInput()
                monName = newName
            case "perception", "2":
                print("What would you like the new perception to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monPerception = newAttribute
            case "armor class", "3":
                print("What would you like the new Armor Class to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monAC = newAttribute
            case "fortitude save", "4":
                print("What would you like the new Fortitude Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monFort = newAttribute
            case "reflex save", "5":
                print("What would you like the new Reflex Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monRef = newAttribute
            case "will save", "6":
                print("What would you like the new Will Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monWill = newAttribute
            case "speed", "7":
                print("What would you like the new Speed to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monSpeed = newAttribute
            case "health", "8":
                print("What would you like the new Health to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monHP = newAttribute
            case "save":
                attributeEXIT = true
            case "exit":
                return
            default:
                print("\n\nCommand not understood\n")
        }

    } while !attributeEXIT


    givenMonster.setCoreAttributes(Name: monName, Perception: monPerception, AC: monAC, Fort: monFort, Ref: monRef, Will: monWill, Speed: monSpeed, HP: monHP)
}

//Edits ability scores for given monster
func editAbilityScores(givenMonster: inout Monster) -> Void {
    var monStr = givenMonster.Str
    var monDex = givenMonster.Dex
    var monCon = givenMonster.Con
    var monIntel = givenMonster.Intel
    var monWis = givenMonster.Wis
    var monCha = givenMonster.Cha

    var newAbility: Int
    var abilityEXIT = false
    var abilityInput: String
    
    repeat {
        print("\n")
        print("Ability scores to Change:")
        print("1: Strength")
        print("2: Dexterity")
        print("3: Constitution")
        print("4: Intelligence")
        print("5: Wisdom")
        print("6: Charisma")
        print("Type SAVE to save changes, or EXIT to discard them")
        abilityInput = getUserInput()
        switch abilityInput.lowercased() {
            case "strength", "str", "1":
                print("What would you like the new Strength Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monStr = newAbility
            case "dexterity", "dex", "2":
                print("What would you like the new Dexterity Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monDex = newAbility
            case "constitution", "con", "3":
                print("What would you like the new Constitution Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monCon = newAbility
            case "intelligence", "int", "4":
                print("What would you like the new Intelligence Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monIntel = newAbility
            case "wisdom", "wis", "5":
                print("What would you like the new Wisdom Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monWis = newAbility
            case "charisma", "cha", "6":
                print("What would you like the new Charisma Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monCha = newAbility
            case "save":
                abilityEXIT = true
            case "exit":
                return
            default:
                print("\n\nCommand not understood\n")
        }

    } while !abilityEXIT


    givenMonster.setAbilityScores(Str: monStr, Dex: monDex, Con: monCon, Intel: monIntel, Wis: monWis, Cha: monCha)
}




//Edits conditions, or adds new conditions
func editChoice(givenMonster: inout Monster, choice: String) -> Void { 
    while true {
        print("\n")
        print("Would you like to:")
        print("1: Edit existing \(choicePluralizer(choice: choice))?")
        print("2: Add new ones?")
        print("3: Exit")
        let editOrAddInput = getUserInput()
        switch editOrAddInput {
            case "1": //Edit Existing Conditions
                _editChoice(givenMonster: &givenMonster, choice: choice)

            case "2": //Add New Conditions
                _addChoice(givenMonster: &givenMonster, choice: choice)

            case "3", "Exit", "exit":
                return
            
            default:
                print("\n\nCommand not understood\n")

        }


    }
}

//Helper for editConditions that handles Names for editing
func _editChoice(givenMonster: inout Monster, choice: String) -> Void {
    
    switch choice {
        case "condition":
            if givenMonster.Conditions.isEmpty {
                print("\n")
                print("Monster has no conditions, please add a condition to edit")
                return
            }
        case "skill":
            if givenMonster.Skills.isEmpty {
                print("\n")
                print("Monster has no skills, please add a skill to edit")
                return
            }
        case "resistance":
            if givenMonster.Resistances.isEmpty {
                print("\n")
                print("Monster has no resistances, please add a resistance to edit")
                return
            }
        case "weakness":
            if givenMonster.Weaknesses.isEmpty {
                print("\n")
                print("Monster has no weaknesses, please add a weakness to edit")
                return
            }
        default:
            return

    }

    func choicePrinter() {
        switch choice {
            case "condition":
                print(givenMonster.Conditions)
            case "skill":
                print(givenMonster.Skills)
            case "resistance":
                print(givenMonster.Resistances)
            case "weakness":
                print(givenMonster.Weaknesses)
            default:
                return
        }
    }

    func choiceExistCheck(_ input: String) -> Bool {
        switch choice {
            case "condition":
                guard givenMonster.Conditions[input] != nil else {
                    return false
                }
                return true
            case "skill":
                guard givenMonster.Skills[input] != nil else {
                    return false
                }
                return true
            case "resistance":
                guard givenMonster.Resistances[input] != nil else {
                    return false
                }
                return true
            case "weakness":
                guard givenMonster.Weaknesses[input] != nil else {
                    return false
                }
                return true
            default:
                return false
        }
    }



    var editExistingDONE = false
    repeat{
        print("\n")
        print("Please type the name of the \(choice) you'd like to edit")
        choicePrinter()
        let editChoiceInput = getUserInput()


        if editChoiceInput.lowercased() == "exit" {
            return
        }
        else if choiceExistCheck(editChoiceInput) {
            _editChoiceValue(givenMonster: &givenMonster, name: editChoiceInput, choice: choice)
        }
        else {
            print("\(choice.capitalized) not Found")
        }


        print("\n")
        print("Would you like to edit another \(choice)? (y/n)")
        let endEditInput = getUserInput()
        switch endEditInput.lowercased() {
            case "n":
                editExistingDONE = true
            default:
                editExistingDONE = false
        }

    } while !editExistingDONE
}

//Helper for editConditions that handles Values for editing
func _editChoiceValue(givenMonster: inout Monster, name: String, choice: String) -> Void {
    
    func choiceValueFinder() -> Int {
        switch choice {
            case "condition":
                return givenMonster.Conditions[name]!
            case "skill":
                return givenMonster.Skills[name]!
            case "resistance":
                return givenMonster.Resistances[name]!
            case "weakness":
                return givenMonster.Weaknesses[name]!
            default:
                return -1
        }
    }


    func choiceValueAdder(_ value: String) {
        switch choice {
            case "condition":
                givenMonster.Conditions[name] = Int(value)!
            case "skill":
                givenMonster.Skills[name] = Int(value)!
            case "resistance":
                givenMonster.Resistances[name] = Int(value)!
            case "weakness":
                givenMonster.Weaknesses[name] = Int(value)!
            default:
                return
        }
    }
    
    func removeChoice() {
        switch choice {
            case "condition":
                givenMonster.removeCondition(Condition: name)
            case "skill":
                givenMonster.removeSkill(Skill: name)
            case "resistance":
                givenMonster.removeResistance(Resistance: name)
            case "weakness":
                givenMonster.removeWeakness(Weakness: name)
            default:
                return
        }
    }



    
    while true {
        print("\n")
        print("What would you like the new value of \(name) to be? Its current value is \(choiceValueFinder()). Please type -1 to remove the \(choice)")
        let editValueInput = getUserInput() 
                    
        if !isInputPositiveIntger(editValueInput) {
            if editValueInput.lowercased() == "exit" {
                return
            }
            
            if let removalInput = Int(editValueInput) {
                if removalInput == -1 {
                    removeChoice()
                    return
                }
            }

            print("Please input a positive number, or -1 to remove this \(choice)")
        }
        else {
            choiceValueAdder(editValueInput)
            print("\(choice.capitalized) is changed")
            return
            }

    }
}


//Adds new conditions to the monster, handles names
func _addChoice(givenMonster: inout Monster, choice: String) -> Void {
    var DONE = false
    repeat{
        print("\n")
        print("Type in the name of the \(choice) you'd like to add, or type Exit to stop adding \(choicePluralizer(choice: choice))")
        let nameInput = getUserInput()
        if nameInput.lowercased() == "exit" {
            return
        }

        _addChoiceValue(givenMonster: &givenMonster, name: nameInput, choice: choice)
                
        print("\n")
        print("Would you like to add another \(choice)? (y/n)")
        let endAddInput = getUserInput()
        switch endAddInput.lowercased() {
            case "n":
                DONE = true
            default:
                DONE = false
                }


    } while !DONE
}

//Adds new conditions to the monster, handles values
func _addChoiceValue(givenMonster: inout Monster, name: String, choice: String) -> Void {
    
    func choiceAdder(value: String) {
        switch choice {
            case "condition":
                givenMonster.addConditions(Conditions: [name : Int(value)!])
            case "skill":
                givenMonster.addSkills(Skills: [name : Int(value)!])
            case "resistance":
                givenMonster.addResistances(Resistances: [name : Int(value)!])
            case "weakness":
                givenMonster.addWeaknesses(Weaknesses: [name : Int(value)!])
            default:
                return
        }
    }
    
    
    
    
    while true{
        print("\n")
        print("Type in the value you would like your \(choice) to start with")
        let valueInput = getUserInput() 
                    
        if !isInputPositiveIntger(valueInput) {
            if valueInput.lowercased() == "exit" {
                return
            }
            print("Please input a positive number")
        }
        else {

            choiceAdder(value: valueInput)

            print("\(choice.capitalized) added to Monster")

            return
        }

    }
}




func editAttacks(givenMonster: inout Monster) -> Void {
    let editAttacksDONE = false
    
    repeat{
        print("\n")
        print("Would you like to:\n1: Edit existing attacks?\n2: Add new ones?\n3: Exit")
        let editOrAddInput = getUserInput()
        switch editOrAddInput {
            case "1": //Edit Existing Attacks
                _editAttacks(givenMonster: &givenMonster)

            case "2": //Add New Attacks
                _addAttacks(givenMonster: &givenMonster)

            case "3", "Exit", "exit":
                return
            
            default:
                print("\n\nCommand not understood\n")

        }


    } while !editAttacksDONE
}


func _editAttacks(givenMonster: inout Monster) -> Void {
    if givenMonster.Attacks.isEmpty {
        print("\n")
        print("Monster has no attacks, please add an attack to edit")
        return
    }


    func attackExistanceChecker(_ attackToCheck: String) -> (exist: Bool, attack: Strike?) {
        for attack in givenMonster.Attacks {
            if attackToCheck == (attack.name) {
                return (true, attack)
            }
        }
        return (false, nil)
    }

    var editAttacksDONE = false
    repeat{
    
        print("\n")
        print("Please type in the name of the attack you'd like to edit")
        givenMonster.printAttacks()
        let attackToEditInput = getUserInput()
        var attackToEdit = attackExistanceChecker(attackToEditInput)

        if attackToEditInput.lowercased() == "exit" {
            return
        }
        else if attackToEdit.exist {
            _editGivenAttack(attack: &attackToEdit.attack!)
        }
        else {
            print("Attack not Found")
        }


        print("\n")
        print("Would you like to edit another attack? (y/n)")
        let endAttackEditInput = getUserInput()
        switch endAttackEditInput.lowercased() {
            case "n", "no":
                editAttacksDONE = true
            default:
                editAttacksDONE = false
        }


    } while !editAttacksDONE

}

func _editGivenAttack(attack: inout Strike) -> Void {
    while true{
        print("\n")
        print("Please type in which aspect of the strike you'd like to edit: Name, HitMod, Damage, or Labels, or type exit to exit")
        print(attack)
        let attackEditInput = getUserInput()
        switch attackEditInput.lowercased(){
            case "name", "1":
                _editGivenAttackName(attack: &attack)
            case "hitmod", "2":
                _editGivenAttackHitmod(attack: &attack)
            case "damage", "3":
                _editGivenAttackDamage(attack: &attack)
            case "labels", "4":
                _editGivenAttackLabels(attack: &attack)
            case "exit":
                return
            default:
                print("Command Not Understood")
        }

    }
}

func _editGivenAttackName(attack: inout Strike) -> Void {
    print("\n")
    print("Current attack name is \(attack.name), please type in the new name")
    let newName = getUserInput()
    attack.editName(name: newName)
}

func _editGivenAttackHitmod(attack: inout Strike) -> Void {
    print("\n")
    print("Current attack Hitmod is \(attack.hitMod), please type in the new Hitmod")
    var newhitMod = getUserInput()

    while !isInputPositiveIntger(newhitMod) {
        print("Please input a positive integer")
        newhitMod = getUserInput()
    }

    attack.editHitmod(hitMod: Int(newhitMod)!)
}

func _editGivenAttackDamage(attack: inout Strike) -> Void {
    func addNewDamage() {
        let newDamage = _addSingleDamageType()
        attack.addDamage(name: newDamage.name, value: newDamage.value)
        print("New damage type added")
    }
    
    func removeOldDamage() {
        print("Please type the name of the damage type you'd like to remove")
        let damageRemove = getUserInput()
        attack.removeDamage(name: damageRemove)
        print("Damage type removed")
    }

    func editExistingDamage() {
        print("Please type the name of the damage type you'd like to edit")
        let damageEditName = getUserInput()
        print("Please type the new value of the damage type")
        var damageEditValue = getUserInput()
        while !checkDamageValueFormat(damageEditValue) {
            print("Format incorrect, please retype and double check formatting. It must be the form XdY+Z, where X, Y, and Z are all integers")
            damageEditValue = getUserInput()
        }
        attack.removeDamage(name: damageEditName)
        attack.addDamage(name: damageEditName, value: damageEditValue)
        print("Damage type edited")

    }

    while true {
        print("\n")
        print(attack.damage)
        print("Would you like to:\n1: Add a new type of damage.\n2: Remove an existing type of damage. \n3: Edit an existing damage type. \n4: Exit")
        let editAttackInput = getUserInput()
        switch editAttackInput {
            case "1":
                addNewDamage()
            case "2":
                removeOldDamage()
            case "3":
                editExistingDamage()
            case "4", "exit", "Exit":
                return
            default:
                print("Command not understood\n")
        }
    }
}

func _editGivenAttackLabels(attack: inout Strike) -> Void {
    func removeLabel(name: String) {
        attack.removeLabel(name: name)
        print("Label removed")
    }

    func addLabel(name: String) {
        attack.addLabel(name: name)
        print("Label Added")
    }

    while true {
        print("\n")
        print("Would you like to:\n1: Add a new label\n2: Remove an existing label\n3: Exit")
        let labelInput = getUserInput()
        
        switch labelInput {
            case "1":
                print("Please type in the label you'd like to add to the attack")
                let labelToAdd = getUserInput()
                addLabel(name: labelToAdd)
            case "2":
                print("Please type in the label you'd like to remove from the attack")
                let labelToRemove = getUserInput()
                removeLabel(name: labelToRemove)
            case "3","exit","Exit":
                return
            default:
                print("Command not understood")
        }
    }
}



func _addAttacks(givenMonster: inout Monster) -> Void {
    var addAttacksDONE = false
    repeat{
        print("\n")
        print("Type in the name of the attack you'd like to add, or type Exit to stop adding skills")
        let attackNameInput = getUserInput()
        if attackNameInput.lowercased() == "exit" {
            return
        }
        
        print("\n")
        print("Please type in the 'to hit' modifier for this strike")
        var attackHitmodInput = getUserInput()
        if attackNameInput.lowercased() == "exit" {
            return
        }
        while !isInputPositiveIntger(attackHitmodInput) {
            print("Please input a positive number for the 'to hit' modifier")
            attackHitmodInput = getUserInput()
            if attackHitmodInput.lowercased() == "exit" {
                return
            }
        }

        var allDamageInputed = false
        var damageDict:[String : String] = [:]

        repeat {
            let singleDamageType = _addSingleDamageType()
            damageDict[singleDamageType.name] = singleDamageType.value
            
            var inputCycleDONE = false
            repeat {
                print("\n")
                print("Is there another type of damage this strike does? (y/n)")
                let damageDoneInput = getUserInput()
                switch damageDoneInput.lowercased() {
                    case "y", "yes":
                        allDamageInputed = false
                        inputCycleDONE = true
                    case "n", "no":
                        allDamageInputed = true
                        inputCycleDONE = true
                    default:
                        print("Input not understoon \n")
                        inputCycleDONE = false
                }

            } while !inputCycleDONE

        } while !allDamageInputed


        print("\n")
        print("Please input the labels for the attack one at a time, or type in DONE to finish typing in labels")

        var labelInputDONE = false
        var labelInput: String
        var labelArray: [String] = []
        repeat{
            labelInput = getUserInput()
            if labelInput.lowercased() == "done" {
                labelInputDONE = true
            } else {
                labelArray.append(labelInput)
            }
        } while !labelInputDONE



        let monsterStrike = Strike(name: attackNameInput, hitMod: Int(attackHitmodInput)!, damage: damageDict, labels: labelArray)
        givenMonster.addAttacks(Attacks: [monsterStrike])
        print("\n")
        print("Attack added to Monster!")
        
                

        print("\n")
        print("Would you like to add another attack? (y/n)")
        let endSkillAddInput = getUserInput()
        switch endSkillAddInput.lowercased() {
            case "n":
                addAttacksDONE = true
            default:
                addAttacksDONE = false
                }


    } while !addAttacksDONE
}


func _addSingleDamageType() -> (name: String, value: String) {
    print("\n")
    print("Please type the type of damage this strike does, for example a kukri would do 'Slashing' damage")
    let attackDamageType = getUserInput()

    print("\n")
    print("Please type the value of the damage done by this strike in the form of XdY+Z. For example, a kukri from an Adhukait would do '1d6+9' damage. Omit the '+Z' entirely, if its not applicable")
    var attackDamageValue = getUserInput()

    while !checkDamageValueFormat(attackDamageValue) {
        print("Format incorrect, please retype and double check formatting. It must be the form XdY+Z, where X, Y, and Z are all integers")
        attackDamageValue = getUserInput()
    }

    return (attackDamageType, attackDamageValue)
}








func printMonsters() -> Void {
    print("\n")
    print("Printing Monsters")
    print("\n")
    var index = 0
    for monster in monsterArray {
        print("Index: [\(index + 1)]")
        print(monster)
        print("\n")
        index += 1
    }
}


func isInputPositiveIntger(_ input: String, includeZero: Bool = false) -> Bool {
    if let num = Int(input) {
        if num > 0 {
            return true
        }
        if (num == 0) && includeZero {
            return true
        }
    }
    return false
}

//Checks if the string is of the form AdB+C
func checkDamageValueFormat(_ input: String) -> Bool {
    let regexFormat = #/^\d+d\d+(\+\d+)?$/#
    return try! regexFormat.wholeMatch(in: input) != nil
}


func choicePluralizer(choice: String) -> String {
    switch choice {
        case "condition":
            return "conditions"
        case "skill":
            return "skills"
        case "resistance":
            return "resistances"
        case "weakness":
            return "weaknesses"
        default:
            return ""
    }
}