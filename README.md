# QuizApp

QuizApp is a cross-platform quiz application developed using Flutter that runs on Android, iOS, and the web. It allows users to create and take quizzes on various topics. This README provides an overview of the app's features and how to use them.
- [Demo Video is available here...](https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenrecorder-2023-09-13-17-48-49-686_0_COMPRESSED.mp4?alt=media&token=c3196549-0fbd-4f0f-aeb9-fa700097e1b2)

## Features

1. **Custom App Icon**:
   - Uses `flutter_launcher_icons` to set a custom app icon.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/IMG_20230913_192958.jpg?alt=media&token=c4ee5124-3231-44d8-904d-cf6fb762f1cf" width ="100">

2. **Native Splash Screen**:
   - Utilizes the `flutter_native_splash` package to display a native splash screen on app launch.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192823.png?alt=media&token=be67de02-92f2-4a0f-9edf-29b287f4ce4f">

3. **Home Screen**:
   - Contains various features, including:
     - Adding questions to database.
     - Displaying all questions.
     - Filtering questions by categories.
     - Creating quizzes with random questions.
     - Taking quizzes by quiz ID or title.
     - Customizing and creating your own quizzes.
     - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192439.png?alt=media&token=cd49710a-a47a-4c68-a26b-9fc2065acdf2" >
     - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192450.png?alt=media&token=38524a4d-f4d4-4314-9e8c-92e6d4dbf61a">
     
4. **Add Question**:
   - Users can:
     - Select a category.
     - Specify the difficulty.
     - Provide a question, options, and answer.
     - Add question to the database.
     - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20201443.png?alt=media&token=6ca5b651-5be0-4902-8c49-a2f0e6b2a130">

5. **Show All Questions**:
   - Displays all questions.
   - Users can filter questions by category.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192607.png?alt=media&token=f54ac8bb-f16f-44df-9bc4-7a96b1b3479b">

6. **Create Custom Quiz**:
   - Allows users to create custom quizzes by selecting questions options and it will be added to the list.
   - Users can give the quiz a title, and it will be added to the database.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20201545.png?alt=media&token=15455277-6058-4092-8698-433c49e48ad6">
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20201538.png?alt=media&token=0ad691bd-0e1c-4662-a5db-de0b9027def9">

7. **Create Quiz with Random Questions**:
   - Users can select a category, give it a title, and specify the number of questions.
   - Clicking the create button generates the quiz.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192741.png?alt=media&token=de6c81ab-d2a6-4b44-8b8b-a103c24bd6ca">

8. **Take Quiz by ID**:
   - Enter a quiz ID to access the quiz.
   - Users select the correct options for questions and submit answers.
   - The score is displayed upon completion.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192631.png?alt=media&token=9d2a50b4-9168-40a3-9827-6b7a770b9646">
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192646.png?alt=media&token=d4035f56-fa77-4c02-99ec-be3cb65ac393">
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192656.png?alt=media&token=5996d01e-f5a1-475d-bd1b-52e81ebcaf19">

9. **Take Quiz by Title**:
   - Enter a quiz title to access the quiz.
   - Users select the correct options for questions and submit answers.
   - The score is displayed upon completion.
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192802.png?alt=media&token=c1589dba-6e7b-43e1-83c8-e85f09824f48">
   - <img src="https://firebasestorage.googleapis.com/v0/b/github-895c7.appspot.com/o/Screenshot%202023-09-13%20192815.png?alt=media&token=5f67c873-ee5f-4088-90a5-884747fe843e">
   - Note: If multiple quizzes share the same title, the first created quiz is displayed.

## Rest Api resource
The backend API is developed using Spring Boot and is available in the repository [Quiz App Spring Boot Backend](https://github.com/Ultranmus/Quiz-App-Spring-Boot-Backend).
