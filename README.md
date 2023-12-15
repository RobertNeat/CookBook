# CookBook

SwiftUI app for mobile devices (IPhones) that is functioning like cook book that user can add new dishes as well as informations asscoated with them. User can write multiple indredients, multiple steps to prepare dish as well as set difficulty level. Cook book also stores those informaction using Core Data (persistant storage between app launches) for user to browse through those recipes. There are multiple gestures implemented in application such as swipe to delete element from dish category as zoom in difficulty level on dish description page. 

## Features

The app features:

- dish grouping bu category (meat/pasta/soups),
- browsing through defined elements and deleting or adding new recipe,
- persistant data storage using Core Data,
- setting new dish title, difficulty level, ingredients as well as preparing steps on the "add new" page,
- dish details page with formatted title, ingredients, steps as well as difficulty in form of gauge indicator,

## Installation

To use/install the app you have to have installed XCode IDE in the MacOS. Simply launch the IDE and the preffered simulator.

## App run video demonstration

https://github.com/RobertNeat/CookBook/assets/47086490/b04205bd-feb1-40ad-ab1f-d239d9561bba
<!--To embed the video make sure it is less than 25MB and it have the mp4 format (dont know what types are supported bu this is safe). Then just drag the file to readme in github and wait to upload the video-->


## Screenshots

1. Main page of the app with the meal categories

<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/1_first_launch.png" width="200"/>

1. Meat recipes list inside meat category and recipe details page

<span>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/2_meat_category.png" width="200"/>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/3_meat_category_dish_details.png" width="200"/>
</span>

1. Soup recipes list inside soup category and add page for new recipe

<span>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/4_soup_category.png" width="200"/>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/5_add_soup.png" width="200"/>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/6_soup_filled.png" width="200"/>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/7_soup_added_to_core_data.png" width="200"/>
<img src="https://github.com/RobertNeat/CookBook/blob/main/screenshots/8_soup_details.png" width="200"/>
</span>
