## video-Gen

video-gen is a Flutter app that allows users to generate short video clips based on a given topic. The app uses the Dio package to make HTTP requests to a web service that generates the video clip.

## Requirements
- Flutter

## Installation
To install the required dependencies, run:

`flutter pub get`

## Usage
To run the app, use the following command:

`flutter run`

To generate a video clip, enter the topic in the text input field and click the "Generate" button. The app will make a POST request to the /generate-video endpoint of the web service with the topic as the request body. If the request is successful, the app will navigate to a success page that displays the URL of the generated video clip. The app also provides a loading indicator while the video is being generated.
