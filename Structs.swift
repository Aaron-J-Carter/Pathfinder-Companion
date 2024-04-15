/*
Initialization:
Strike:
    name: String
    hitMod: Int
    damage: [String:String]
    labels: [String])

Monster:
    Name: String
    Perception: Int
    AC: Int
    Fort: Int
    Ref: Int
    Will: Int
    Speed: Int
    HP: Int

Methods you can call:
Strike: 
    rollHit(attackCount: Int) -> Int
    rollDamage() -> [String:Int]

Monster
    setAbilityScores(Str: Int, Dex: Int, Con: Int, Intel: Int, Wis: Int, Cha: Int) -> Void
    addAttacks(Attacks: [Strike]) -> Void
    addSkills(Skills: [String:Int]) -> Void
    addConditions(Conditions: [String:Int]) -> Void
    setResistancesWeaknesses(Resistances: [String:Int], Weaknesses: [String:Int]) -> Void
    isTurnOver() -> Bool
    stillAliveChecker() -> Bool
    strikeAttempt(name: String) -> [String:Int]
    takeDamage(damage: [String: Int]) -> Bool
    endTurn() -> Void
    conditionReducer(conditions: [String]) -> Void
    rollSave(type: String) -> Int
    rollInitiative() -> Int
    rollInitiative(skill: String) -> Int

*/


//Structure for a singular Strike. Will include to hit modifier, damage of all types, and labels for type of attack. Monsters are outfitted with an array of Strikes
struct Strike {

//Strike Parameters
var name: String
var hitMod: Int
var damage: [String : String]
var labels: [String]

//Initializer
init(name: String, hitMod: Int, damage: [String:String], labels: [String]) {
    self.name = name
    self.hitMod = hitMod
    self.damage = damage
    self.labels = labels
}

//Parameter Editing Functions
mutating func editName(name: String) {
    self.name = name
}

mutating func editHitmod(hitMod: Int) {
    self.hitMod = hitMod
}

mutating func addDamage(name: String, value: String) {
    self.damage[name] = value
}

mutating func removeDamage(name: String) {
    self.damage.removeValue(forKey: name)
}

mutating func addLabel(name: String) {
    self.labels.append(name)
}

mutating func removeLabel(name: String) {
    if let index = self.labels.firstIndex(of: name) {
        self.labels.remove(at: index)
    }
}


//Public Functions

//returns Int of number for an attack to hit
func rollHit(attackCount: Int) -> Int {
    if labels.contains("agile") {
        let MAP = 4 * (attackCount - 1)
        return d20() - MAP + hitMod
    }

    let MAP = 5 * (attackCount - 1)
    return d20() - MAP + hitMod
    }



//returns dict of damage number plus damage type
func rollDamage() -> [String:Int] {
    var damageDict: [String:Int] = [:]
    var damageSum: Int = 0
    for (type, number) in damage {
        let splitDamage = damageSplitter(number: number)
        var damageTotal: Int = 0

        for _ in 1...splitDamage[0] {
            damageTotal += Int.random(in: 1...splitDamage[1])
        }

        damageTotal += splitDamage[2]
        damageSum += damageTotal
        damageDict[type] = damageTotal
    }
    damageDict["Total Damage"] = damageSum

    return damageDict
}



//Private Functions

//d20 roll
private func d20() -> Int {
    return Int.random(in: 1...20)
}

//takes a damage in the form of "xdy+z" and returns [x,y,z]
private func damageSplitter (number: String) -> [Int] {
        let damageSplit = number.split(separator: "d")
        let numberOfDice = Int(damageSplit[0]) ?? 1
        
        var sizeOfDice:Int
        var addBonus: Int = 0

        if damageSplit[1].count > 2 {
            sizeOfDice = Int(damageSplit[1].split(separator: "+")[0]) ?? 1
            addBonus = Int(damageSplit[1].split(separator: "+")[1]) ?? 0
        } 
        
        else {
            sizeOfDice = Int(damageSplit[1].split(separator: "+")[0]) ?? 1
        }
        
        let splitDamage: [Int] = [numberOfDice, sizeOfDice, addBonus]
        
        return splitDamage
}

}

extension Strike: CustomStringConvertible {
    var description: String {
        var _description: String = "\n"
        _description += "Name: \(name) \n"
        _description += "Bonus to hit: \(hitMod) \n"

        if damage.count == 0 {
            _description += "Damage: None"
        } else if damage.count == 1 {
            _description += "Damage: "

            for (type, number) in damage {
                _description += "\(number) \(type)"
            }
        } else {
            _description += "Damage:\n"

            for (type, number) in damage {
                _description += "    \(number) \(type)"
            }
        }



        _description += "\n"
        _description += "Traits: "
        for trait in labels {
            _description += trait + ", "
        }
        _description.removeLast(2)

        return _description
    }

}



//------------------------------------------------------------
//Struct for monster, will contain all base stats needed for combat. Requires Perception, AC, saving throws, Speed, and HP. Ability scores can be added later, along with attacks of type Strike, Extra skills, Name, and Conditions can be added as they occur
struct Monster {

//Monster Parameters
var Str = 0, Dex = 0, Con = 0, Intel = 0, Wis = 0, Cha = 0
var Perception = 0, AC = 0, Fort = 0, Ref = 0, Will = 0, Speed = 0, HP = 0
var Skills: [String : Int] = [:]
var Conditions: [String : Int] = [:]
var Resistances: [String : Int] = [:]
var Weaknesses: [String : Int] = [:]
var Name: String = ""
var Attacks: [Strike] = []

//Combat Parameters
var currentAttackCount: Int = 1 //If first attack, should be 1, second attack, should be 2 ...
var currentActionCount: Int = 1//Similar to ^, starts at 1 and once an action is taken when the count is 3 turn should end


//Functions to add core attributes, ability scores, skills, conditions, and attacks
mutating func setCoreAttributes(Name: String, Perception: Int, AC: Int, Fort: Int, Ref: Int, Will: Int, Speed: Int, HP: Int) -> Void {
    self.Name = Name
    self.Perception = Perception
    self.AC = AC
    self.Fort = Fort
    self.Ref = Ref
    self.Will = Will
    self.Speed = Speed
    self.HP = HP
}


mutating func setAbilityScores(Str: Int, Dex: Int, Con: Int, Intel: Int, Wis: Int, Cha: Int) -> Void {
    self.Str = Str
    self.Dex = Dex
    self.Con = Con
    self.Intel = Intel
    self.Wis = Wis
    self.Cha = Cha
}

mutating func addAttacks(Attacks: [Strike]) -> Void {
    self.Attacks += Attacks
}

mutating func addSkills(Skills: [String:Int]) -> Void {
    for (name, value) in Skills {
        self.Skills[name] = value
    }
}

mutating func removeSkill(Skill: String) -> Void {
    self.Skills.removeValue(forKey: Skill)
}



mutating func addConditions(Conditions: [String:Int]) -> Void {
    for (name, value) in Conditions {
        self.Conditions[name] = value
    }
}

mutating func removeCondition(Condition: String) -> Void {
    self.Conditions.removeValue(forKey: Condition)
}




mutating func addResistances(Resistances: [String:Int]) -> Void {
    for (name, value) in Resistances {
        self.Resistances[name] = value
    }
}

mutating func removeResistance(Resistance: String) -> Void {
    self.Resistances.removeValue(forKey: Resistance)
}



mutating func addWeaknesses(Weaknesses: [String:Int]) -> Void {
    for (name, value) in Weaknesses {
        self.Weaknesses[name] = value
    }
}

mutating func removeWeakness(Weakness: String) -> Void {
    self.Weaknesses.removeValue(forKey: Weakness)
}


//--------------------------------------------------------------
//Public Functions

//Print Attacks
func printAttacks() -> Void {
    for attack in Attacks {
        print(attack)
        print("\n")
    }
}



//Roll Perception for Initiative
func rollInitiative() -> Int {
    return d20() + Perception
}

//Overloaded func for alt skill
func rollInitiative(skill: String) -> Int {
    if let skillToUse = Skills[skill] {
        return d20() + skillToUse
    }

    else {
        return d20() + Perception
    }
}

//Rolls given skill, or straight d20 roll if skill not found
func rollSkill(skill: String) -> Int {
    if let skillToUse = Skills[skill] {
        return d20() + skillToUse
    }

    else {
        return d20()
    }
}


//isTurnOver -> Bool. Checks if turn is over and returns true if so
func isTurnOver() -> Bool {
    var actionNumberAdjuster = 0

    if let value = Conditions["Slowed"] {
        actionNumberAdjuster -= value
    }
    if let value = Conditions["Quickened"] {
        actionNumberAdjuster += value
    }
    if (Conditions["Stunned"] != nil) || (Conditions["Paralyzed"] != nil) || (Conditions["Unconscious"] != nil) {
        return true
    }

    return currentActionCount > 3 + actionNumberAdjuster
}

//Returns True if monster is still Alive
func stillAliveChecker() -> Bool {
    return HP > 0
}

//Calls an attack roll plus damage for given Strike
mutating func strikeAttempt(name: String) -> [String:Int] {
    for candidate in Attacks {
        if name.lowercased() == candidate.name.lowercased() {
            return _strikeAttempt(candidate)
        }
    }

    print("Strike not found in Attack list")
    return ["Error":-1]
}

//Input raw damage given to monster to affect HP
mutating func takeDamage(damage: [String : Int]) -> Void {
    let damageTotal:Int = _takeDamage(damage)
    
    HP -= damageTotal
}

//Resets all action/attack counters and deals persistance damage
mutating func endTurn() -> Void {
    currentActionCount = 1
    currentAttackCount = 1

    for (type, value) in Conditions {
        if type.contains("Persistent") {
            var newType = type
            newType.removeSubrange("Persistent".startIndex..."Persistent".endIndex)

            takeDamage(damage: [newType : value]) 
                 
            if d20() >= 15 {
                Conditions.removeValue(forKey: type)
            }

            


        }
    }


}


//Reduces given conditions by 1 or removes them if their value would go to 0
mutating func conditionReducer(conditions: [String]) -> Void {
    for condition in conditions {
        _conditionReducer(condition)
    }
}


//Rolls Saving Throws
func rollSave(type: String) -> Int {
    switch type {
        case "Reflex":
            return d20() + Ref
        case "Fortitude":
            return d20() + Fort
        case "Will":
            return d20() + Will
        default:
            return d20()
    }
}

//Increments attack count
mutating func attackCountIncrement() -> Void {
    self.currentAttackCount += 1
}

//Increments action count
mutating func actionCountIncrement() -> Void {
    self.currentActionCount += 1
}

//-------------------------------------------------------------
//Private Functions

//d20 roll
private func d20() -> Int {
    return Int.random(in: 1...20)
}


//Body for Strike Attempt function
private mutating func _strikeAttempt(_ strike: Strike) -> [String:Int] {
    var strikeResults: [String:Int] = [:]
    
    strikeResults["Roll to Hit"] = strike.rollHit(attackCount: currentAttackCount) + conditionChecker_Attack(strike)

    let damageResults: [String:Int] = strike.rollDamage()
    for (type, number) in damageResults {
        strikeResults[type] = number
    }
    
    attackCountIncrement()

    return strikeResults
}


//Helper for _strikeAttempt. Checks if any conditions affecting the monster affect its roll to hit
private func conditionChecker_Attack(_ strike: Strike) -> Int {
    var conditionAdjuster_Attack = 0
    for (type, value) in Conditions {
        switch type {
            case "Enfeebled":
                if !strike.labels.contains("Finesse") && !strike.labels.contains("Ranged") {
                    conditionAdjuster_Attack -= value
                }
            case "Frightened", "Sickened":
                conditionAdjuster_Attack -= value
            case "Prone":
                conditionAdjuster_Attack -= 2
            case "Clumsy":
                if strike.labels.contains("Finesse") || strike.labels.contains("Ranged") {
                    conditionAdjuster_Attack -= value
                }
            default:
                break
        }
    }
    return conditionAdjuster_Attack
}


//Body for takeDamage, takes damage and returns total damage taken. Checks if persistent and adds condition
private mutating func _takeDamage(_ damage: [String: Int]) -> Int {
    var damageTotal = 0
    for (type, value) in damage {
        if type.contains("Persistent") {
            addConditions(Conditions: [type : value])
        }
        else {
            damageTotal += _damageResistanceAndWeaknessChecker(type: type, value: value)
        }
    }
    return damageTotal
}

//Helper for _takeDamage, takes a single damage type and value and returns adjusted amount based on resistances and weaknesses
private func _damageResistanceAndWeaknessChecker(type: String, value: Int) -> Int {
    for (Wtype, Wvalue) in Weaknesses {
        if type == Wtype {
            return value + Wvalue
        }
    }

    for (Rtype, Rvalue) in Resistances {
        if type == Rtype && Rvalue >= value {
            return 0
        }

        if type == Rtype {
            return value - Rvalue
        }
    }

    return value
}


//Body for conditionReducer, takes one condition at a time and reduces by 1 or removes if at 0 after reducing
private mutating func _conditionReducer(_ condition: String) -> Void {
    if Conditions[condition]! <= 1 {
        Conditions.removeValue(forKey: condition)
    }

    else {
        Conditions[condition]! -= 1
    }
}









}




extension Monster: CustomStringConvertible {
    var description: String {
        let abilityScores = "Str: \(Str), Dex: \(Dex), Con: \(Con), Intel: \(Intel), Wis: \(Wis), Cha: \(Cha) \n"
        let keyAttributes = "Perception: \(Perception), AC: \(AC), Fortitude Save: \(Fort), Reflex Save: \(Ref), Will Save: \(Will), Speed: \(Speed) \n"



        var attacks: String
        if Attacks.isEmpty {
            attacks = "No Attacks"
        } else {
            attacks = "Attacks:  "
            for attack in Attacks {
                attacks += "\(attack.name), "
            }
            attacks.removeLast(2)
        }
        attacks += "\n"


        var skills: String
        if Skills.isEmpty {
            skills = "No Skills"
        } else {
            skills = "Skills: "
            for (name, value) in Skills {
                skills += "\(name) \(value), "
            }
            skills.removeLast(2)
        }
        skills += "\n"


        var conditions: String
        if Conditions.isEmpty {
            conditions = "No Conditions"
        } else {
            conditions = "Conditions: "
            for (name, value) in Conditions {
                conditions += "\(name) \(value), "
            }
            conditions.removeLast(2)
        }
        conditions += "\n"


        var resistances: String
        if Resistances.isEmpty {
            resistances = "No Resistances"
        } else {
            resistances = "Resistances: "
            for (name, value) in Resistances {
                resistances += "\(name) \(value), "
            }
            resistances.removeLast(2)
        }
        resistances += "\n"


        var weaknesses: String
        if Weaknesses.isEmpty {
            weaknesses = "No Weaknesses"
        } else {
            weaknesses = "Weaknesses: "
            for (name, value) in Weaknesses {
                weaknesses += "\(name) \(value), "
            }
            weaknesses.removeLast(2)
        }
        weaknesses += "\n"

        var name: String
        if Name == "" {
            name = "No Name Given"
        }
        else {
            name = Name
        }

        return "\(name) (\(HP) HP):\n" + abilityScores + keyAttributes + attacks + skills + conditions + resistances + weaknesses
    }
}