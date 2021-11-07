## Riddikulus

Problem
----------
Have you ever had to confront your greatest fear, and wish you could turn it into something that would make you laugh? Riddikulus is built for just that. It is a real-time SwiftUI Messaging App which turns the words of your beneficiary into silly strings. It's great for de-stressing extremely stressful situations.

Functionality
----------
Riddikulus really is a full messaging app. It lets you sign up, sign in, and sign out of your own Riddikulus account. Once in the app, you can search for other users to chat with, or continue conversations from your conversation history. It also stays signed in when you leave the app, so you don't have to keep signing in and out to message people. Once you've opened a conversation, you can send and receive text messages. And most importantly, you can call a Riddikulus charm, which uses random functions to jumble and play with the other person's texts.

Architecture
----------
The app was built with SwiftUI using CocoaPods for dependencies. The backend is attached through Firebase Authentication and Firebase Datastore, which track, organize, and update the information needed for the app in real-time. The only technology here I had encountered before was SwiftUI.

Things I learned
----------
This Jam was a great learning experience. I learned, well... a lot of things, and I'll list them here:

* What Firebase Is and how to use Firebase Authentication and Firebase Datastore
* What CocoaPods is and how to use dependencies to enhance your SwiftUI app.
* Best practices for organizing project files and setting up XCode projects
* Using Navigation to create multiple pages (something I'd never done before)
* Using DispatchQueue to ensure things run smoothly
* Using properties such as @EnvironmentObject, @AppStorage, and @State
* Small hacks such as creating CustomModifier structs and using Optionals to display for light/dark mode accordingly
* Taking and using user input through TextFields and Binding variables
* How to use Images, Spacers, Modifiers to make my app look nice
* How to set up an AppDelegate to connect to Firebase
* How to navigate Firebase and create event listeners for Firebase Datastore
* How to create a set of AppIcons with Asset Catalog Creator
* Using guard let else to catch bugs
* And a lot more!

Things I need to work on
----------
*The app doesn't -really- work... I didn't have the time to learn how to connect the Riddikulus charm to Firebase, so this data is not updated in real-time for users. I hard-coded variables and used poorly written if-else statements to create the demonstration.
*ScrollView doesn't scroll when new messages are added! Gah.
*Images are hard-coded optionals that work for 2 users (here, Matt and Jillian).
*Previews arent loading, maybe because the model requires Firebase.


Credits
----------
Inspiration: https://www.youtube.com/watch?v=doxxfXqpKYA

To build this app, I followed this tutorial: https://www.skillshare.com/classes/SwiftUI-Build-Chat-App-for-Beginners-2021/266407467

MIT License
