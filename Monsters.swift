//Monster Adding/Editing/Printing
var monsterArray:[Monster] = []


func addMonster() -> Void {
    print("Adding Monsters")
    var TESTMonster = Monster()
    TESTMonster.setCoreAttributes(Name: "TEST", Perception: 1, AC: 1, Fort: 1, Ref: 1, Will: 1, Speed: 1, HP: 1)
    monsterArray.append(TESTMonster)
    monsterArray.append(Monster())




}

//Main function called from initial menu. Lists all monsters and calls function to edit specific monster
func editMonster() -> Void {
    let DONE: Bool = false
    repeat {
        printMonsters()
        print("Please input index number of Monster you wish to edit, or \"Exit\" to exit the monster editor")
        let monsterChoice = getUserInput()

        if monsterChoice.lowercased() == "exit" {
            return
        }


        for (monsterIndex, _) in monsterArray.enumerated() {
            if (Int(monsterChoice) ?? 0) - 1 == monsterIndex {
                editGivenMonster(givenMonster: &monsterArray[monsterIndex])
            }
        }

    } while !DONE

}


//Second stage of edit monster function, takes specific monster and breaks dows the editing to specific attributes and calls function for each
func editGivenMonster(givenMonster: inout Monster) -> Void {
    print(givenMonster)
    print("What would you like to edit?")
    print("1: Core Attributes")
    print("2: Ability Scores")
    print("3: Conditions")
    print("4: Skills")
    print("5: Attacks")
    print("6: Resistances and Weaknesses")
    let whatToEditInput = getUserInput()

    switch whatToEditInput {
        case "1", "Core Attributes":
            editAttributes(givenMonster: &givenMonster)
        case "2", "Ability Scores":
            editAbilityScores(givenMonster: &givenMonster)
        case "3", "Conditions":
            editConditions(givenMonster: &givenMonster, choice: "condition")
        case "4", "Skills":
            editSkills(givenMonster: &givenMonster)
        case "5", "Attacks":
            editAttacks(givenMonster: &givenMonster)
        case "6", "Resistances and Weaknesses":
            editResisWeak(givenMonster: &givenMonster)
        default:
            print("ERROR")
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
        print("Attributes to Change:")
        print("Name, Perception, Armor Class, Fortitude Save, Reflex Save, Will Save, Speed, Health")
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
        print("Ability scores to Change:")
        print("Strength, Dexterity, Constitution, Intelligence, Wisdom, Charisma")
        print("Type SAVE to save changes, or EXIT to discard them")
        abilityInput = getUserInput()
        switch abilityInput.lowercased() {
            case "strength", "1":
                print("What would you like the new Strength Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monStr = newAbility
            case "dexterity", "2":
                print("What would you like the new Dexterity Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monDex = newAbility
            case "constitution", "3":
                print("What would you like the new Constitution Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monCon = newAbility
            case "intelligence", "4":
                print("What would you like the new Intelligence Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monIntel = newAbility
            case "wisdom", "5":
                print("What would you like the new Wisdom Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monWis = newAbility
            case "charisma", "6":
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
func editConditions(givenMonster: inout Monster, choice: String) -> Void { 
    while true {
        print("Would you like to:\n1: Edit existing \(choice)s?\n2: Add new ones?\n3: Exit")
        let editOrAddInput = getUserInput()
        switch editOrAddInput {
            case "1": //Edit Existing Conditions
                _editConditions(givenMonster: &givenMonster, choice: choice)

            case "2": //Add New Conditions
                _addConditions(givenMonster: &givenMonster, choice: choice)

            case "3", "Exit", "exit":
                return
            
            default:
                print("\n\nCommand not understood\n")

        }


    }
}

//Helper for editConditions that handles Names for editing
func _editConditions(givenMonster: inout Monster, choice: String) -> Void {
    
    switch choice {
        case "condition":
            if givenMonster.Conditions.isEmpty {
                print("Monster has no conditions, please add a condition to edit")
                return
            }
        case "skill":
            if givenMonster.Skills.isEmpty {
                print("Monster has no skills, please add a skill to edit")
                return
            }
        case "resistance":
            if givenMonster.Resistances.isEmpty {
                print("Monster has no resistances, please add a resistance to edit")
                return
            }
        case "weakness":
            if givenMonster.Weaknesses.isEmpty {
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
    }
}




    var editExistingDONE = false
    repeat{
        print("Please type the name of the \(choice) you'd like to edit")
        choicePrinter()
        let editChoiceInput = getUserInput()


        if editChoiceInput.lowercased() == "exit" {
            return
        }
        else if let conditionValue = givenMonster.Conditions[editConditionInput] {
            _editConditionValue(givenMonster: &givenMonster, conditionName: editConditionInput)
        }
        else {
            print("Condition not Found")
        }


        print("Would you like to edit another condition? (y/n)")
        let endConditionEditInput = getUserInput()
        switch endConditionEditInput.lowercased() {
            case "n":
                editExistingDONE = true
            default:
                editExistingDONE = false
        }

    } while !editExistingDONE
}






//Helper for editConditions that handles Values for editing
func _editConditionValue(givenMonster: inout Monster, conditionName: String) -> Void {
    let editGivenConditionDONE = false
    repeat{
        print("What would you like the new value of \(conditionName) to be? Its current value is \(givenMonster.Conditions[conditionName]!)")
        let editConditionValueInput = getUserInput() 
                    
        if !isInputPositiveIntger(editConditionValueInput) {
            if editConditionValueInput.lowercased() == "exit" {
                return
            }
            print("Please input a positive number")
        }
        else {
            givenMonster.Conditions[conditionName] = Int(editConditionValueInput)!
            print("Condition is changed")

            return
            }

    } while !editGivenConditionDONE
}





//Adds new conditions to the monster, handles names
func _addConditions(givenMonster: inout Monster) -> Void {
    var addConditionsDONE = false
    repeat{ //repeats entire condition adding process, broken out of at end by saying you would not like to add anymore
        print("Type in the name of the condition you'd like to add, or type Exit to stop adding conditions")
        let conditionNameInput = getUserInput()
        if conditionNameInput.lowercased() == "exit" {
            return
        }

        _addConditionsValue(givenMonster: &givenMonster, conditionName: conditionNameInput)
                

        print("Would you like to add another condition? (y/n)")
        let endConditionAddInput = getUserInput()
        switch endConditionAddInput.lowercased(){
            case "n":
                addConditionsDONE = true
            default:
                addConditionsDONE = false
                }


    } while !addConditionsDONE
}

//Adds new conditions to the monster, handles values
func _addConditionsValue(givenMonster: inout Monster, conditionName: String) -> Void {
    let addGivenConditionValueDONE = false
    repeat{
        print("Type in the value you would like your condition to start with")
        let conditionValueInput = getUserInput() 
                    
        if !isInputPositiveIntger(conditionValueInput) {
            if conditionValueInput.lowercased() == "exit" {
                return
            }
            print("Please input a positive number")
        }
        else {
            givenMonster.addConditions(Conditions: [conditionName:Int(conditionValueInput)!])

            print("Condition added to Monster")

            return
        }

    } while !addGivenConditionValueDONE
}




//Edits or Adds Skills
func editSkills(givenMonster: inout Monster) -> Void {
    let editSkillsDONE = false
    
    repeat{
        print("Would you like to:\n1: Edit existing skills?\n2: Add new ones?\n3: Exit")
        let editOrAddInput = getUserInput()
        switch editOrAddInput {
            case "1": //Edit Existing Conditions
                _editSkills(givenMonster: &givenMonster)

            case "2": //Add New Conditions
                _addSkills(givenMonster: &givenMonster)

            case "3", "Exit", "exit":
                return
            
            default:
                print("\n\nCommand not understood\n")

        }


    } while !editSkillsDONE
}

func _editSkills(givenMonster: inout Monster) -> Void {
    if givenMonster.Skills.isEmpty {
        print("Monster has no skills, please add a skill to edit")
        return
    }
    
    var editExistingSkillsDONE = false
    repeat{
        print("Please type the name of the skill you'd like to edit")
        print(givenMonster.Skills)
        let editSkillInput = getUserInput()

        for name in givenMonster.Skills.keys {
            if name.lowercased() == editSkillInput.lowercased() {
                _editSkillValue(givenMonster: &givenMonster, skillName: name)
            }
            else if editSkillInput.lowercased() == "exit" {
                return
            }
            else {
                print("Skill not found")
            }
        }


        print("Would you like to edit another skill? (y/n)")
        let endSkillEditInput = getUserInput()
        switch endSkillEditInput.lowercased() {
            case "n":
                editExistingSkillsDONE = true
            default:
                editExistingSkillsDONE = false
        }

    } while !editExistingSkillsDONE
}

func _editSkillValue(givenMonster: inout Monster, skillName: String) -> Void {
    let editGivenSkillDONE = false
    repeat{
        print("What would you like the new value of \(skillName) to be? Its current value is \(givenMonster.Skills[skillName]!)")
        let editSkillValueInput = getUserInput() 
                    
        if !isInputPositiveIntger(editSkillValueInput) {
            if editSkillValueInput.lowercased() == "exit" {
                return
            }
            print("Please input a positive number")
        }
        else {
            givenMonster.Skills[skillName] = Int(editSkillValueInput)!
            print("Skill is changed")

            return
        }

    } while !editGivenSkillDONE
}




//Helper for editSkills, handles adding new skills
func _addSkills(givenMonster: inout Monster) -> Void {
    var addSkillsDONE = false
    repeat{ //repeats entire skill adding process, broken out of at end by saying you would not like to add anymore
        print("Type in the name of the skil you'd like to add, or type Exit to stop adding skills")
        let skillNameInput = getUserInput()
        if skillNameInput.lowercased() == "exit" {
            return
        }

        _addSkillValue(givenMonster: &givenMonster, skillName: skillNameInput)
                

        print("Would you like to add another skill? (y/n)")
        let endSkillAddInput = getUserInput()
        switch endSkillAddInput.lowercased() {
            case "n":
                addSkillsDONE = true
            default:
                addSkillsDONE = false
                }


    } while !addSkillsDONE
}

func _addSkillValue(givenMonster: inout Monster, skillName: String) -> Void {
    let addGivenSkillValueDONE = false
    repeat{
        print("Type in the value you would like your skill to start with")
        let skillValueInput = getUserInput() 
                    
        if !isInputPositiveIntger(skillValueInput) {
            if skillValueInput.lowercased() == "exit" {
                return
            }
            print("Please input a positive number")
        }
        else {
            givenMonster.addSkills(Skills: [skillName:Int(skillValueInput)!])

            print("Skill added to Monster")

            return
        }

    } while !addGivenSkillValueDONE
}







func editAttacks(givenMonster: inout Monster) -> Void {
    let editAttacksDONE = false
    
    repeat{
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
        print("Monster has no attacks, please add an attack to edit")
        return
    }


    var editAttacksDONE = false
    repeat{
    func attackExistanceChecker() -> (exist: Bool, attack: Strike?) {
        for attack in givenMonster.Attacks {
            if attackToEdit == attack.name {
                return (true, attack)
            }
        }
        return (false, nil)
    }

    print("Please type in the name of the attack you'd like to edit")
    print(givenMonster.Attacks)
    let attackToEditInput = getUserInput()
    let attackToEdit = attackExistanceChecker()

    if attackToEditInput.lowercased() == "exit" {
        return
    }
    else if attackToEdit.exist {
        _editGivenAttack(attack: &attackToEdit.attack!)
    }
    else {
        print("Attack not Found")
    }


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
    let editGivenAttackDONE = false
    repeat{
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

    } while !editGivenAttackDONE
}

func _editGivenAttackName(attack: inout Strike) -> Void {
    print("Current attack name is \(attack.name), please type in the new name")
    let newName = getUserInput()
    attack.editName(name: newName)
}

func _editGivenAttackHitmod(attack: inout Strike) -> Void {
    print("Current attack Hitmod is \(attack.hitMod), please type in the new Hitmod")
    let newhitMod = getUserInput()
    attack.edithitMod(hitMod: newhitMod)
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
        let damageEditValue = getUserInput()
        while !checkDamageValueFormat(damageEditValue) {
            print("Format incorrect, please retype and double check formatting. It must be the form XdY+Z, where X, Y, and Z are all integers")
            attackDamageValue = getUserInput()
        }
        attack.removeDamage(name: damageEditName)
        attack.addDamage(name: damageEditName, value: damageEditValue)
        print("Damage type edited")

    }

    while true {
        print(attack.damage)
        print("Would you like to:\n1) Add a new type of damage.\n2) Remove an existing type of damage. \n3) Edit an existing damage type. \n4) Exit")
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
        print("Would you like to:\n1) Add a new label\n2) Remove an existing label\n3) Exit")
        let labelInput = getUserInput()
        
        switch labelInput {
            case "1":
                print("Please type in the label you'd like to add to the attack")
                let labelToAdd = getUserInput()
                addLabel(name: labelToAdd)
            case "2":
                print("Please type in the label you'd like to remove from the attack")
                let labelToRemove = getUserInput()
                addLabel(name: labelToRemove)
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
        print("Type in the name of the attack you'd like to add, or type Exit to stop adding skills")
        let attackNameInput = getUserInput()
        if attackNameInput.lowercased() == "exit" {
            return
        }

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


        print("Please input the labels for the attack one at a time, or type in DONE to finish typing in labels")

        var labelInputDONE = false
        var labelInput: String
        var labelArray: [String] = []
        repeat{
            labelInput = getUserInput()
            if labelInput == "DONE" {
                labelInputDONE = true
            } else {
                labelArray.append(labelInput)
            }
        } while !labelInputDONE



        let monsterStrike = Strike(name: attackNameInput, hitMod: Int(attackHitmodInput)!, damage: damageDict, labels: labelArray)
        givenMonster.addAttacks(Attacks: [monsterStrike])
        print("Attack added to Monster!")
        
                

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
    print("Please type the type of damage this strike does, for example a kukri would do 'Slashing' damage")
    let attackDamageType = getUserInput()

    print("Please type the value of the damage done by this strike in the form of XdY+Z. For example, a kukri from an Adhukait would do '1d6+9' damage. Omit the '+Z' entirely, if its not applicable")
    var attackDamageValue = getUserInput()

    while !checkDamageValueFormat(attackDamageValue) {
        print("Format incorrect, please retype and double check formatting. It must be the form XdY+Z, where X, Y, and Z are all integers")
        attackDamageValue = getUserInput()
    }

    return (attackDamageType, attackDamageValue)
}






func editResisWeak(givenMonster: inout Monster) -> Void {
    
}






func printMonsters() -> Void {
    print("Printing Monsters")
    var index = 0
    for monster in monsterArray {
        print("Index: [\(index + 1)]")
        print(monster)
        index += 1
    }
}


func isInputPositiveIntger(_ input: String) -> Bool {
    if let num = Int(input) {
        if num > 0 {
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