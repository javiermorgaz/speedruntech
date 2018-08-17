# Speedruntech

Technical Test for iOS

The App must show the folowing information from the api http://www.speedrun.com:

  * A list with the games with its logo and name.
    There is no need to implement pagination.
    
  * When you select a game from the list, the app must open a new screen containing
    information of the first run in the api runs list. The screen must contain:
    - A button to see the video in an outside app.
    - The name of the player (if there is more than one, you must show only the first player’s name).
    - The time of that run.
    - The game’s logo.
    - The game’s name.

## Prerequisites

- Xcode 9.4
- Swift 4
- CocoaPods

## Installing

Run 'pods install' in speedruntech root folder.

Open generated 'speedruntech.xcworkspace'.

## Running the tests

Tests can be run from the Tests navigation tab.


## Built With

* Alamofire: https://github.com/Alamofire/Alamofire
* MBProgressHUD: https://github.com/jdg/MBProgressHUD
* SDWebImage: https://github.com/rs/SDWebImage
* CocoaLumberjack: https://github.com/CocoaLumberjack/CocoaLumberjack
* SwiftLint: https://github.com/realm/SwiftLint

## Authors

* **Javier Morgaz**

## License

This project is licensed under the MIT License
