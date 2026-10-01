# QuizApp

QuizApp is a cross-platform quiz application developed using Flutter that runs on Android, iOS, and the web. It allows users to create and take quizzes on various topics. This README provides an overview of the app's features and how to use them.
- [Demo Video is available here...](readme-assets/screenrecorder-2023-09-13-17-48-49-686_0_compressed.mp4)

## Features

1. **Custom App Icon**:
   - Uses `flutter_launcher_icons` to set a custom app icon.
   - <img src="readme-assets/img_20230913_192958.jpg" width ="100">

2. **Native Splash Screen**:
   - Utilizes the `flutter_native_splash` package to display a native splash screen on app launch.
   - <img src="readme-assets/screenshot-2023-09-13-192823.png">

3. **Home Screen**:
   - Contains various features, including:
     - Adding questions to database.
     - Displaying all questions.
     - Filtering questions by categories.
     - Creating quizzes with random questions.
     - Taking quizzes by quiz ID or title.
     - Customizing and creating your own quizzes.
     - <img src="readme-assets/screenshot-2023-09-13-192439.png" >
     - <img src="readme-assets/screenshot-2023-09-13-192450.png">
     
4. **Add Question**:
   - Users can:
     - Select a category.
     - Specify the difficulty.
     - Provide a question, options, and answer.
     - Add question to the database.
     - <img src="readme-assets/screenshot-2023-09-13-201443.png">

5. **Show All Questions**:
   - Displays all questions.
   - Users can filter questions by category.
   - <img src="readme-assets/screenshot-2023-09-13-192607.png">

6. **Create Custom Quiz**:
   - Allows users to create custom quizzes by selecting questions options and it will be added to the list.
   - Users can give the quiz a title, and it will be added to the database.
   - <img src="readme-assets/screenshot-2023-09-13-201545.png">
   - <img src="readme-assets/screenshot-2023-09-13-201538.png">

7. **Create Quiz with Random Questions**:
   - Users can select a category, give it a title, and specify the number of questions.
   - Clicking the create button generates the quiz.
   - <img src="readme-assets/screenshot-2023-09-13-192741.png">

8. **Take Quiz by ID**:
   - Enter a quiz ID to access the quiz.
   - Users select the correct options for questions and submit answers.
   - The score is displayed upon completion.
   - <img src="readme-assets/screenshot-2023-09-13-192631.png">
   - <img src="readme-assets/screenshot-2023-09-13-192646.png">
   - <img src="readme-assets/screenshot-2023-09-13-192656.png">

9. **Take Quiz by Title**:
   - Enter a quiz title to access the quiz.
   - Users select the correct options for questions and submit answers.
   - The score is displayed upon completion.
   - <img src="readme-assets/screenshot-2023-09-13-192802.png">
   - <img src="readme-assets/screenshot-2023-09-13-192815.png">
   - Note: If multiple quizzes share the same title, the first created quiz is displayed.

## Rest Api resource
The backend API is developed using Spring Boot and is available in the repository [Quiz App Spring Boot Backend](https://github.com/Ultranmus/Quiz-App-Spring-Boot-Backend).
