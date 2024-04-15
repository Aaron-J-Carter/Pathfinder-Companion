/*
Pathfinder 2e Encounter Helper!

Overall Goal: Make a program to track monsters stat blocks and attacks, making calculating things like MAP and conditions.

First, just making a rig for ^ would be nice, then add in support to put in monster blocks in the program as opposed to in the code. (Possibly insert a .csv file?)



Observations/Ideas: Make a monster struct that holds all needed values
    (Do we even need to add base ability scores? Or are just generally useful skills and given attack bonuses enough?)
    Struct should contain an action counter per turn
    Should have functions calling things like attack that keeps track of MAP inherently based on interal count of 'Attack' actions


Eventually add some overall functions that prompts for things like how many monsters of what kind and such, and include an initiative tracker for monsters and players alike. Then handle a monsters turn by calling appropriat functions on that monster
*/

//Idea, in Main is where we make a loop of actions. I.e. we ask user for input and a function in a separate file gets called based on input, then its a while loop that resets back to start, asking for more input
func getUserInput() -> String {
    return readLine() ?? ""
}

print("Welcome to the Pathfinder Encounter Helper!")
var QUIT = false
repeat {
    print("1: Add Blank Monster Template")
    print("2: Edit/Check Monster Templates")
    print("3: Run Encounter")
    print("4: Quit Program")
    var userInput = getUserInput()
    switch userInput {
        case "1":
            addMonster()
        case "2":
            editMonster()
        case "3":
            runEncounter()
        case "4":
            print("Are you sure you'd like to quit? (y/n)")
            userInput = getUserInput()
            if userInput == "y" {
                QUIT = true
            }

        default:
            print("Command not understood\n")
    }



} while !QUIT