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
    var DONE: Bool = false
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
            editConditions(givenMonster: &givenMonster)
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
            case "name":
                print("What would you like the new name to be?")
                newName = getUserInput()
                monName = newName
            case "perception":
                print("What would you like the new perception to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monPerception = newAttribute
            case "armor class":
                print("What would you like the new Armor Class to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monAC = newAttribute
            case "fortitude save":
                print("What would you like the new Fortitude Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monFort = newAttribute
            case "reflex save":
                print("What would you like the new Reflex Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monRef = newAttribute
            case "will save":
                print("What would you like the new Will Save to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monWill = newAttribute
            case "speed":
                print("What would you like the new Speed to be?")
                newAttribute = Int(getUserInput()) ?? 0
                monSpeed = newAttribute
            case "health":
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
            case "strength":
                print("What would you like the new Strength Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monStr = newAbility
            case "dexterity":
                print("What would you like the new Dexterity Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monDex = newAbility
            case "constitution":
                print("What would you like the new Constitution Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monCon = newAbility
            case "intelligence":
                print("What would you like the new Intelligence Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monIntel = newAbility
            case "wisdom":
                print("What would you like the new Wisdom Score to be?")
                newAbility = Int(getUserInput()) ?? 0
                monWis = newAbility
            case "charisma":
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
func editConditions(givenMonster: inout Monster) -> Void {
    var editConditionsDONE = false
    
    repeat{
        print("Would you like to:\n1: Edit existing conditions?\n2: Add new ones?\n3: Exit")
        let editOrAddInput = getUserInput()
        switch editOrAddInput {
            case "1": //Edit Existing Conditions
                _editConditions(givenMonster: &givenMonster)

            case "2": //Add New Conditions
                _addConditions(givenMonster: &givenMonster)

            case "3", "Exit", "exit":
                return
            
            default:
                print("\n\nCommand not understood\n")

        }


    } while !editConditionsDONE
}

//Helper for editConditions that handles Names for editing
func _editConditions(givenMonster: inout Monster) -> Void {
    if givenMonster.Conditions.isEmpty {
        print("Monster has no conditions, please add a condition to edit")
        return
    }
    var editExistingConditionsDONE = false
    repeat{
        print("Please type the name of the condition you'd like to edit")
        print(givenMonster.Conditions)
        let editConditionInput = getUserInput()

        for name in givenMonster.Conditions.keys {
            if name.lowercased() == editConditionInput.lowercased() {
                _editConditionValue(givenMonster: &givenMonster, conditionName: name)
            }
            else if editConditionInput.lowercased() == "exit" {
                return
            }
            else {
                print("Condition not found")
            }
        }


        print("Would you like to edit another condition? (y/n)")
        let endConditionEditInput = getUserInput()
        switch endConditionEditInput.lowercased() {
            case "n":
                editExistingConditionsDONE = true
            default:
                editExistingConditionsDONE = false
        }

    } while !editExistingConditionsDONE
}

//Helper for editConditions that handles Values for editing
func _editConditionValue(givenMonster: inout Monster, conditionName: String) -> Void {
    var editGivenConditionDONE = false
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
    var addGivenConditionValueDONE = false
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
    var editSkillsDONE = false
    
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
    var editGivenSkillDONE = false
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
    var addGivenSkillValueDONE = false
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