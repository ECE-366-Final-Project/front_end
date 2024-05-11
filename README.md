# Final Project for ECE-366 "Software Engineering and Large System Design"
### Cooper Union, Spring 2024
> #### Lani Wang, James Ryan, Evan Rosenfeld, Vaibhav Hariani

## Cloning the repo 
Clone the repo by running   
```
$ git clone https://github.com/ECE-366-Final-Project/front_end.git
```

## Build & Run  
This project primarily uses Flutter! [Get it here.](https://docs.flutter.dev/get-started/install)  
You can host a local instance of our frontend by running (in the root directory): 
```
flutter pub get
$ flutter run
``` 
## Development
If running the entire system locally, a change will need to be made in generics.dart involving the port & source of the backend.
We recommend changing line 22 to  ```const SRC = "localhost:8080";```
Two chrome extensions are also necessary in this situation: 

https://chromewebstore.google.com/detail/cors-unblock/lfhmikememgdcahcdlaciloancbhjino
https://chromewebstore.google.com/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm

The first extension allows the frontend to make localhost calls, whilst the second enables the dart debug environment in the browser. These are not necessary when accessing the production build. 

## Android Release
For android, the Android Studio IDE is needed, alongside necessary plugins: See these instructions for more information: https://docs.flutter.dev/get-started/install/windows/mobile?tab=physical
Once you've set up the IDE, run ```flutter create .``` in a suitable development environment to create an android manifest: This then allows any android device with USB Debugging to execute the application.
