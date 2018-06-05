/*
The prolog script offers different meal options, sandwich options, meat options, salad options, sauce options, top-up options, sides options etc. to create a customized list of person’s choice. The options should be intelligently selected based on previous choices. For example, if the person chose a veggie meal, meat options should not be offered. If a person chose healthy meal, fatty sauces should not be offered. If a person chose vegan meal, cheese top-up should not be offered. If a person chose value meal, no top-up should be offered.
*/


% User will start off the program by keying in the command - ask(0).
ask(0):-
    % The program will display a list of meal options for user to choose from.
    % User is to key in the corresponding number representing the meal option.
    write("Hi! Please choose a meal option. (Select the number corresponding to the meal)"), nl,
    write("The meal options available are -  "), nl,
    write("1 - Vegan "), nl,
    write("2 - Healthy "), nl,
    write("3 - Veggie "), nl,
    write("4 - Value "), nl,
    read(Chose), % take in user's choice of meal
    assertz(meal_selected(Chose)), % assert user's meal choice and store in DB
    /* Chose is a number representing the meal option */
    meal_options(0). % Call the predicate meal_options(0) and depending on the meal choice assertion made earlier, different ingredient options will be available

/*
This predicate select_veg(FV) allows users to select more than 1 veggie.
When user indicated that they want to add more veggie, the same predicate will be called again, keeping the user in the same loop.
User will exit the loop when they select 'n'.
*/

select_veg(FV):-
        print_options(FV), nl, % prints the list of veggie
        read(SelectedVeg), % takes in user's selection of veggie
        assert(selected_veg(SelectedVeg)), % assert user's selection of veggie into the DB
        write("You can choose more veggie, do you want to? (y/n)"), nl,
        read(SelectMore), % Determine whether user wants to select more veggie
        (SelectMore == y -> select_veg(FV);
        SelectMore == n -> write("Alright then, I heard veggie is good for your body!"), nl;
        select_veg(FV)).
        % if user selected 'y', the same predicate will be called again and user will go through the same decision process
        % if user selected 'n', user will exit the loop and return to the main program
        % if user selected none of the appropriate responses, same predicate will be called again to prompt user for an appropriate response

meal_options(0) :- (

    /* Vegan Meal */
    meal_selected(1) ->
        bread(BreadList), veg(VegList), condiment(CondimentList),
        vegan(VeganList),
        % this binds the elements of the various ingredients list into their respective variable e.g(BreadList, VegList, CondimentList, etc)

        findall(A, ( member(A, BreadList), member(A, VeganList) ), FilteredBread ),
        findall(C, ( member(C, VegList), member(C, VeganList) ), FilteredVeg ),
        findall(E, ( member(E, CondimentList), member(E, VeganList) ), FilteredCondiment ),
        % findall predicate will compare the elements of ingredient list and the meal list e.g BreadList and VeganList
        % and put the elements which exist in both list into another list e.g FilteredBread, FilteredVeg

        write("Please select a bread: "), nl,
	print_options(FilteredBread), nl,
        read(SelectedBread),
        assert(selected_bread(SelectedBread)),
        /*
         1. displays the filtered list of bread
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select veggie"), nl,
        select_veg(FilteredVeg),
        % run the predicate mentioned earlier to select veggie

        write("Please select your condiment: "), nl,
        print_options(FilteredCondiment), nl,
        read(SelectedCondiment),
        assert(selected_condiment(SelectedCondiment)),
        /*
         1. displays the filtered list of condiment
         2. takes in user's choice
         3. assert the selection into database
        */
    done(1) % displays the list of ingredients selected
    ;

    /* Healthy Meal */
    meal_selected(2) ->
        bread(BreadList), veg(VegList), meat(MeatList), topping(ToppingList), condiment(CondimentList),
        soup(SoupList), cookie(CookieList), healthy(HealthyList),
        % this binds the elements of the various ingredients list into their respective variable e.g(BreadList, VegList, CondimentList, etc)

        findall(A, ( member(A, BreadList), member(A, HealthyList) ), FilteredBread ),
        findall(B, ( member(B, MeatList), member(B, HealthyList) ), FilteredMeat),
        findall(C, ( member(C, VegList), member(C, HealthyList) ), FilteredVeg ),
        findall(D, ( member(D, ToppingList), member(D, HealthyList) ), FilteredTopping ),
        findall(E, ( member(E, CondimentList), member(E, HealthyList) ), FilteredCondiment ),
        findall(F, ( member(F, SoupList), member(F, HealthyList) ), FilteredSoup ),
        findall(G, ( member(G, CookieList), member(G, HealthyList) ), FilteredCookie ),
        % findall predicate will compare the elements of ingredient list and the meal list e.g BreadList and VeganList
        % and put the elements which exist in both list into another list e.g FilteredBread, FilteredVeg

        write("Please select a bread: "), nl,
	print_options(FilteredBread), nl,
        read(SelectedBread),
        assertz(selected_bread(SelectedBread)),
        /*
         1. displays the filtered list of bread
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a meat: "), nl,
        print_options(FilteredMeat), nl,
        read(SelectedMeat),
        assertz(selected_meat(SelectedMeat)),
        /*
         1. displays the filtered list of meat
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select veggie"), nl,
        select_veg(FilteredVeg),
        % run the predicate mentioned earlier to select veggie

        write("Please select a topping: "), nl,
        print_options(FilteredTopping), nl,
        read(SelectedTopping),
        assertz(selected_topping(SelectedTopping)),
        /*
         1. displays the filtered list of topping
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a condiment: "), nl,
        print_options(FilteredCondiment), nl,
        read(SelectedCondiment),
        assertz(selected_condiment(SelectedCondiment)),
        /*
         1. displays the filtered list of condiment
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a soup: "), nl,
        print_options(FilteredSoup), nl,
        read(SelectedSoup),
        assertz(selected_soup(SelectedSoup)),
        /*
         1. displays the filtered list of soup
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a cookie: "), nl,
        print_options(FilteredCookie), nl,
        read(SelectedCookie),
        assertz(selected_cookie(SelectedCookie)),
        /*
         1. displays the filtered list of cookie
         2. takes in user's choice
         3. assert the selection into database
        */

    done(1) % displays the list of ingredients selected
    ;

    /* Veggie Meal */
    meal_selected(3) ->
	bread(BreadList), veg(VegList), condiment(CondimentList),
        soup(SoupList), cookie(CookieList), veggie(VeggieList),
        % this binds the elements of the various ingredients list into their respective variable e.g(BreadList, VegList, CondimentList, etc)

        findall(A, ( member(A, BreadList), member(A, VeggieList) ), FilteredBread ),
        findall(C, ( member(C, VegList), member(C, VeggieList) ), FilteredVeg ),
        findall(E, ( member(E, CondimentList), member(E, VeggieList) ), FilteredCondiment ),
        findall(F, ( member(F, SoupList), member(F, VeggieList) ), FilteredSoup ),
        findall(G, ( member(G, CookieList), member(G, VeggieList) ), FilteredCookie ),
        % findall predicate will compare the elements of ingredient list and the meal list e.g BreadList and VeganList
        % and put the elements which exist in both list into another list e.g FilteredBread, FilteredVeg

        write("Please select a bread: "), nl,
	print_options(FilteredBread), nl,
        read(SelectedBread),
        assertz(selected_bread(SelectedBread)),
        /*
         1. displays the filtered list of bread
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select veggie"), nl,
        select_veg(FilteredVeg),
        % run the predicate mentioned earlier to select veggie

        write("Please select a condiment: "), nl,
        print_options(FilteredCondiment), nl,
        read(SelectedCondiment),
        assertz(selected_condiment(SelectedCondiment)),
        /*
         1. displays the filtered list of condiment
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a soup: "), nl,
        print_options(FilteredSoup), nl,
        read(SelectedSoup),
        assertz(selected_soup(SelectedSoup)),
        /*
         1. displays the filtered list of soup
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a cookie: "), nl,
        print_options(FilteredCookie),
        read(SelectedCookie),
        assertz(selected_cookie(SelectedCookie)),
        /*
         1. displays the filtered list of cookie
         2. takes in user's choice
         3. assert the selection into database
        */

    done(1) % displays the list of ingredients selected
    ;
    /* Value Meal */
    meal_selected(4) ->
        bread(BreadList), veg(VegList), meat(MeatList), condiment(CondimentList),
        value(ValueList),
        % this binds the elements of the various ingredients list into their respective variable e.g(BreadList, VegList, CondimentList, etc)

        findall(A, ( member(A, BreadList), member(A, ValueList) ), FilteredBread ),
        findall(B, ( member(B, MeatList), member(B, ValueList) ), FilteredMeat),
        findall(C, ( member(C, VegList), member(C, ValueList) ), FilteredVeg ),
        findall(E, ( member(E, CondimentList), member(E, ValueList) ), FilteredCondiment ),
        % findall predicate will compare the elements of ingredient list and the meal list e.g BreadList and VeganList
        % and put the elements which exist in both list into another list e.g FilteredBread, FilteredVeg

        write("Please select a bread: "), nl,
        print_options(FilteredBread), nl,
        read(SelectedBread),
        assertz(selected_bread(SelectedBread)),
        /*
         1. displays the filtered list of bread
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select a meat: "), nl,
        print_options(FilteredMeat), nl,
        read(SelectedMeat),
        assertz(selected_meat(SelectedMeat)),
        /*
         1. displays the filtered list of meat
         2. takes in user's choice
         3. assert the selection into database
        */

        write("Please select veggie"), nl,
        select_veg(FilteredVeg),
        % run the predicate mentioned earlier to select veggie

        write("Please select a condiment: "), nl,
        print_options(FilteredCondiment), nl,
        read(SelectedCondiment),
        assertz(selected_condiment(SelectedCondiment)),
        /*
         1. displays the filtered list of cookie
         2. takes in user's choice
         3. assert the selection into database
        */

    done(1) % displays the list of ingredients selected by the user.

; ask(0) /* else branch, if user did not select any of the 4 options, the user will be redirected to select a meal option. */
).

/*
done(1) predicate is to print all the ingredients selected by the user.

In the case where an ingredient does not have any selection, the program
will display a message e.g "No meat selected."
This is done by using the \+ 'not provable' operator where the the logic
fails the condition, the OR part of the predicate will run.

In this program, the condition to print the selected ingredient is to
check if the asserted ingredient is a member of the ingredient list
defined in the database.
e.g selected_bread(X), bread(Bread), member(X, Bread)
If the condition is true, the OR part will run which prints the list
of selected ingredient.

Only displaying veggie has a slightly different logic to print which is
explained below.
*/

done(1):-
    write("Enjoy your meal!"), nl, nl,
    (\+ ( selected_bread(X), bread(Bread), member(X, Bread) ) -> write("No bread selected."), nl;
    ( write("Selected bread: "), selected_bread(X), bread(Bread), member(X, Bread), write(X), nl )),

    (\+ ( selected_meat(Y), meat(Meat), member(Y, Meat) ) -> write("No meat selected."), nl;
    ( write("Selected meat: "), selected_meat(Y), meat(Meat), member(Y, Meat), write(Y), nl )),

    (\+ selected_veg(_) -> write("No veggie selected."), nl;
    ( veg(VegList), findall(Z,(selected_veg(Z), member(Z, VegList)), List), write("Selected veggie: "), nl ,print_options(List) )),
    /*
    as there may be multiple veggie selected by the user,
    findall predicate is used to add all the selected_veg assertions
    into a list. print_options(List) predicate is then called to print out all
    elements in the list.
    */

    (\+ ( selected_topping(A), topping(Topping), member(A, Topping)) -> write("No topping selected."), nl;
    ( write("Selected topping: "), topping(Topping), member(A, Topping), write(A), nl )),

    (\+ ( selected_condiment(B), condiment(Condiment), member(B, Condiment) ) -> write("No condiment selected."), nl;
    ( write("Selected condiment: "), selected_condiment(B), condiment(Condiment), member(B, Condiment), write(B), nl )),

    (\+ ( selected_soup(C), soup(Soup), member(C, Soup) ) -> write("No soup selected."), nl;
    ( write("Selected soup: "), selected_soup(C), soup(Soup), member(C, Soup), write(C), nl )),

    (\+ ( selected_cookie(D), cookie(Cookie), member(D, Cookie) ) -> write("No cookie selected."), nl;
    ( write("Selected cookie: "), selected_cookie(D), cookie(Cookie), member(D, Cookie), write(D), nl )),

    retractall(selected_veg(_)),
    retractall(meal_selected(_)),
    % retractall predicate is used to remove all previously asserted clauses in the database so that when the user rerun the program, it will start afresh.
    % Otherwise the past clauses will remain in the database the next time the user run the program.
    abort. % terminate the program

/*
 *  print_options([A|B]) is a predicate used to print all the elements
 *  in a list. It is a recursive predicate which starts printing the
 *  elements from the head element and call itself with the list from
 *  the tail element. This continues until the list is empty.
 */
print_options([A|B]):- write(A), nl, print_options(B).
print_options([]).

/*
 * Database
Following are the lists containing elements of the various ingredients
i.e bread, meat, veg, topping, condiment, soup, cookie.

The lists of ingredients for various meal choice (e.g healthy, vegan)
are also defined below.
*/
bread([italian, multigrain, parmesanoregano, honeyoat, heartyitalian, flatbread, wrap]).
meat([whitechicken, teriyakichicken, bologna, salami, pepperoni, ham, meatballs, roastbeef, roastchickenbreast, turkeybreast, bacon, tuna, egg, veggiepatty]).
veg([avocado, cucumbers, lettuce, tomatoes, onions, greenpeppers, olives, pickles]).
topping([mushroomslices, cornflakes,baconstrips, americancheese, montereycheddar]).
condiment([chipotle, honeymustard, mayonnaise, mustard, oliveoil, ranch, sweetonion, bbq, chilli, redwinevinegar, ketchup]).
soup([broccolicheddar, creamofbroccoli, creamofmushroom, creamytomatobasil]).
cookie([chocolatechip, doublechocolatechip, oatmealraisin, peanutbutter, pineapple, whitechipmacadamianut]).

vegan([italian, multigrain, parmesanoregano, honeyoat, heartyitalian, flatbread, wrap, avocado, cucumbers, lettuce, tomatoes, onions, greenpeppers, olives, pickles, bbq, chilli, mustard, oliveoil, redwinevinegar, sweetonion, ketchup, chocolatechip, doublechocolatechip, oatmealraisin, peanutbutter, pineapple, whitechipmacadamianut]).
healthy([italian, multigrain, parmesanoregano, heartyitalian, flatbread, wrap, avocado, cucumbers, lettuce, tomatoes, onions, greenpeppers, olives, pickles, mushroomslices, cornflakes, teriyakichicken, ham, roastchickenbreast, roastbeef, turkeybreast, honeymustard, mustard, sweetonion, broccolicheddar, creamofbroccoli, creamofmushroom, creamytomatobasil, chocolatechip, oatmealraisin, whitechipmacadamianut]).
veggie([italian, multigrain, parmesanoregano, honeyoat, heartyitalian, flatbread, wrap, egg, veggiepatty, chipotle, honeymustard, mayonnaise, mustard, oliveoil, ranch, sweetonion, bbq, chilli, redwinevinegar, ketchup, broccolicheddar, creamofbroccoli, creamofmushroom, creamytomatobasilchocolatechip, doublechocolatechip, oatmealraisin, peanutbutter, pineapple, whitechipmacadamianut]).
value([italian, multigrain, parmesanoregano, honeyoat, heartyitalian, flatbread, wrap, whitechicken, teriyakichicken, bologna, salami, pepperoni, ham, meatballs, roastbeef, roastchickenbreast, turkeybreast, bacon, tuna, egg, veggiepatty, avocado, cucumbers, lettuce, tomatoes, onions, greenpeppers, olives, pickles, chipotle, honeymustard, mayonnaise, mustard, oliveoil, ranch, sweetonion, bbq, chilli, redwinevinegar, ketchup]).

% Each ingredient is "initialized" with an empty assertion
selected_meat(nothing).
selected_veg(nothing).
selected_topping(nothing).
selected_condiment(nothing).
selected_soup(nothing).
selected_cookie(nothing).
