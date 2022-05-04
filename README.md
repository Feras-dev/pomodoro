# Pomodoro
Pomodoro is a mobile app, developed using Flutter , serves as a simple productivity and time-management tool.

# screenshots:
<img src="https://user-images.githubusercontent.com/72912013/166833874-cdc2ff1d-f3f6-4633-a5c0-a6529f120013.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166833898-d37dd4bc-166e-4597-807d-527f68eb671a.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834362-0a0eee9b-86b1-4cd0-bcde-2ed3c012bb8e.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834494-d8aa655d-5cb9-4a29-ae9c-fc30c06e3f8f.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834554-1c387676-0cb4-4fdc-8182-d5f7d4f7b9c5.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834574-118e52c5-4f30-4c24-8650-98378660b608.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834633-bbf44577-1445-4f01-8885-170cebf1ca66.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834692-6a37d06a-fd0a-456b-b393-aab4902cef07.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834730-9c2bbe8d-c27d-4bed-b1b8-1ac501342b52.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166834763-16fd8dac-ace7-4325-9aaa-fee78429e3de.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835187-7c7882ab-e202-4fc5-8801-fe863ff84395.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835200-ef275159-3359-4537-b63e-e0039adbd3f7.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835211-2b7733b2-a315-45fe-aadf-feb98064b30e.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835214-1f315af3-fedc-4ee2-bd55-24c65e523b7d.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835223-9c5b4d2f-db37-46a2-abea-687fd2c69442.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835233-5ebe872d-0009-4f6b-b0c3-8aed5b7dd1d7.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835238-21a115b0-f155-4d9b-8c32-102cf28120dc.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835245-13cec4e3-ce58-4950-b46b-2e54327df9e8.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835255-5a80dd74-9739-45aa-a2b2-2c222b2cfe48.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835263-d0b1fbfe-bfcb-419c-8e37-d9702642b30a.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835266-cdd233e0-efaf-4f64-8ddc-0b628f7b5e71.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835271-8c58b8b9-b16c-4391-8f3b-36b75b5dd4c2.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835281-c03278f1-0d0b-493f-94fa-3110634b1abc.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835296-fb1a0717-7d8b-4a4e-b2d4-581e991f4570.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835305-fdf978dd-cd50-48e7-8e2e-2a5652918881.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835318-a8cafef6-9127-43f0-b2d5-cd5180e03024.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835324-de6304e2-64e8-48b0-a918-eefb7cf429ef.png" width="300"><img src="https://user-images.githubusercontent.com/72912013/166835805-4e1d4498-0c43-4110-a22e-d8a5b9e5eda6.png" width="300">

# Design
## Block diagram
The block diagram below illustrates the logical flow of the Pomodoro application. First, the user will enter a task(s) they wish to complete. Once all pertinent information has been entered (ie. the task’s priority, its work time, and its break time) the work timer will run to completion before a break is initiated. After the break has ended, the user will be prompted to either continue working or exit out. The former occurs if the given task was not completed after one Pomodoro cycle or if the user chooses to work on another task, and the latter will allow the user to exit out of the application.
![image](https://user-images.githubusercontent.com/72912013/166833606-b0b2f133-10fc-4ee5-8ec4-9fa55fb48c91.png)

## Use case diagram
![image](https://user-images.githubusercontent.com/72912013/166833621-58ac5b9f-3881-4aae-b685-9e72a790dca2.png)

## Activity diagram
The following diagram shows the path from beginning a new session to exiting out of the Pomodoro application. The user will initiate a session and from there can populate and manage a task list containing one or more tasks they wish to complete, as well as select a task to begin work on. Once the task(s) has been entered, the user will enter a sprint state to begin work on said task for the allotted time. The user can cycle through as many sprint states as needed until the task is complete, and at any point can exit out of the application whether from in a sprint state or on the task list management page.
![image](https://user-images.githubusercontent.com/72912013/166833652-68f4708d-5b3b-4871-972c-95b4f4f4920c.png)

## State machine diagram
The following diagram has been revised to include the application’s various states (idle, work, and sprint) as well as the choices that can be made by a user to enter different states within the diagram. These choices were elaborated to decrease linearity and showcase all paths possible from launch to termination. 
![image](https://user-images.githubusercontent.com/72912013/166833697-25c4e82f-a023-411f-a50d-b49b902d66c0.png)

## Class diagram
The class diagram has been refined to indicate the changes in codebase and the addition of two classes: StateMachineManager and NotificationManager. Instead of having the Task class reference the Pomodoro class, the Pomodoro class now stores the reference to the Task class. This simplifies the storage and association of the Task class to the Pomodoro class. The current state of the user (State) has been moved to the newly created class to be accessible throughout the whole scope of the application. All the classes have been segregated into packages according to their roles.
![image](https://user-images.githubusercontent.com/72912013/166833740-0c1df34e-addc-4611-a824-9f06e909c52a.png)

## Interaction sequence diagram
The Interaction sequence diagram below describes the interactions between the Pomodoro app’s classes, the context of each interaction, and the sequence of events of the app as a whole.
Due to the diagram’s size, the diagram has been split into two images to be included in this document. Please refer to the attached Modelio project for the full diagram.
![image](https://user-images.githubusercontent.com/72912013/166833781-5340dd7e-6a26-4f1f-a282-5775be464be6.png)
![image](https://user-images.githubusercontent.com/72912013/166833791-3519d68b-56f2-473d-951b-d7f008fbd85b.png)

## Package diagram
The package diagram below shows the structure and design of our application at the level of packages. At the higher level our application follows the MVC architecture which further contains many packages organized according to the functions they serve. Upon the application’s launch the user interacts with the components of the “View” package. The application also interacts with some external packages that are necessary for its low-level functionality.
![image](https://user-images.githubusercontent.com/72912013/166833805-a6e3e1cb-5afe-401a-ab09-1bb6c24f3f26.png)

## Deployment diagram
The deployment diagram below indicates the Pomodoro application deployment to Android. Various components comprise the application, and the AnrdroidManifest.xml file is responsible for declaring each of these components. The AndroidManifest.xml file will also specify application requirements, including the minimum version of Android necessary for successful deployment.
![image](https://user-images.githubusercontent.com/72912013/166833830-ee93c154-df70-4afa-ac8f-6396a1eac8d3.png)




# Getting Started

How to run =>

- Install flutter from https://flutter.dev/docs/get-started/install
- Clone the project.
- Go to project directory and run the following command in command prompt
 "flutter run .\lib\main.dart"
