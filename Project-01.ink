/*
    Project 01
    
    Requirements (for 15 base points)
    - Create an interactive fiction story with at least 8 knots 
    - Create at least one major choice that the player can make
    - Reflect that choice back to the player
    - Include at least one loop
    
    To get a full 20 points, expand upon the game in the following ways
    [+2] Include more than eight passages
    [+1] Allow the player to pick up items and change the state of the game if certain items are in the inventory. Acknowledge if a player does or does not have a certain item
    [+1] Give the player statistics, and allow them to upgrade once or twice. Gate certain options based on statistics (high or low. Maybe a weak person can only do things a strong person can't, and vice versa)
    [+1] Keep track of visited passages and only display the description when visiting for the first time (or requested)
    
    Make sure to list the items you changed for points in the Readme.md. I cannot guess your intentions!

*/

VAR health = 100
VAR rations = 0
VAR health_potions = 2
VAR time = 0
VAR gold = 2000
VAR green_apple_eaten = false
VAR strength = 10

VAR visited_town_square = false
VAR visited_mythical_land = false 

-> village

== village ==
You wake up next to a hay bale with little memory of how you got here. As you look around, you notice you are next to a horse stable inside a large village. The village spans out with hundreds of buildings visible.

It is { advance_time() }

+ [Make your way to the town square] -> town_square
* [Grab your sword from the hay stack] -> grab_sword
+ [Rest] -> rest

== town_square ==
    {not visited_town_square: You encounter a bustling market. People are chatting, bartering, and going about their day. You see a butcher cutting meat and a fruit salesman with a shiny green apple creating a large crowd.}
    ~ visited_town_square = true
    {visited_town_square: You see the town market. You have been here before.}

+ [Speak to the butcher] -> butcher
+ [Speak to the fruit salesman] -> fruit_salesman
+ [Rent a room in the local inn] -> local_inn

== grab_sword ==
You grab your sword from the hay bale. It shines as you hold it towards the sun.
~ strength = strength + 5
-> town_square

== rest ==
You lay down to rest, hoping to wake up with more energy.

After you wake up, it is { advance_time() }
-> town_square

== butcher ==
You walk up to the butcher and successfully barter for some rations.
~ rations = rations + 5
-> town_square

== fruit_salesman ==
The fruit salesman presents a shiny, gemstone-like green apple and says, "For only 1000 gold, this apple can be yours!"

* [Buy the green apple] -> green_apple
* [Pass up the green apple] -> town_square

== green_apple ==
You decide to buy the green apple for 1000 gold. As you take a bite, the world around you begins to shimmer and dissolve. You find yourself in a breathtakingly beautiful mythical land with towering crystal spires and vibrant magical creatures.

~ gold = gold - 1000
~ green_apple_eaten = true

+ [Explore the Enchanted Forest] -> enchanted_forest
+ [Visit the Crystal Spire] -> crystal_spire
* [Return to the Village] -> village

== local_inn ==
You rest in the inn overnight. When you wake up, you notice all of your items have been stolen. Your adventure has come to a bitter end.

-> END

== mythical_land ==
{not visited_mythical_land: You are in a breathtakingly beautiful magical land. Towering crystal spires rise into the sky almost scraping the stars, and vibrant magical creatures scurry about. You notice that time seems to work differently here.}
~ visited_mythical_land = true
{visited_mythical_land: You see the lushious green landscape again. You can't help but admire the beauty of this mythical land.}

+ [Explore the Enchanted Forest] -> enchanted_forest
+ [Visit the Crystal Spire] -> crystal_spire
* [Return to the Village] -> end

== enchanted_forest ==
The Enchanted Forest is dense with ancient trees whose leaves glow softly. You hear the gentle rustling of magical creatures.

+ [Follow a glowing path] -> glowing_path
* [Return to the Mythical Land] -> mythical_land

== crystal_spire ==
The Crystal Spire is a towering structure of shimmering crystals. A staircase winds around it.

+ [Climb the staircase] -> spire_top
* [Return to the Mythical Land] -> mythical_land

== glowing_path ==
The glowing path leads you to a serene clearing where a wise old wizard awaits.

+ [Speak to the wizard] -> wizard
* [Return to the Enchanted Forest] -> enchanted_forest

== spire_top ==
At the top of the spire, you find a breathtaking view and a magical artifact.

+ [Take the magical artifact] -> artifact
* [Return to the Crystal Spire] -> crystal_spire

== wizard ==
The wizard greets you and offers assistance with your travels.

+ [Ask for help] -> wizard_help
* [Thank the wizard and return to the clearing] -> glowing_path

== wizard_help ==
The wizard provides you with valuable information about magic in the form of scrolls and tomes. He offers an apprenticeship which you hastily accept. You will train and learn under him for the foreseeable future.

-> END

== artifact ==
The magical artifact is a powerful item that might help you on your journey.

* [Return to the Spire Top] -> spire_top

== end ==
You have betrayed your instincts of adventure and travels. You lose!

-> END

== function advance_time ==
    ~ time = time + 1
    {
        - time > 2:
            ~ time = 0
    }
    {
        - time == 0:
            ~ return "Morning"
        - time == 1:
            ~ return "Noon"
        - time == 2:
            ~ return "Night"
    }
    ~ return time
    