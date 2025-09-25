# Study Platform :mortar_board:
## University study platform built with an SQL-based relational database and JavaFX GUI framework

This project is the implementation of a university study platform. The app uses a relational database to store information regarding users and various university activities. User interaction is carried out through a graphical user interface. Functionalities include managing students and professors, as well as coordinating tasks within study programs.<br><br>

## :hammer_and_wrench: Tools and Technologies
* MySQL Workbench – used to create the database, populate initial data, develop views, stored procedures, and triggers, and create the UML diagram of the data model
* IntelliJ IDEA – Java development environment
* MySQL Connector/J – a JDBC (Java Database Connectivity) driver provided by Oracle that allows Java applications to connect to and interact with MySQL databases. It facilitates executing SQL queries, manipulating data, and managing connections between the Java application and the MySQL server.
* JavaFX – a framework used for developing the graphical user interface (GUI) in Java<br><br>

## Login
The application can be accessed, following an authentication process, by multiple types of users: students, professors, and administrators. For each user, personal information such as first name, last name, address, phone number, etc., is stored. Users can view their personal data immediately after logging in, but they do not have the ability to modify it. The application also provides a logout functionality, which returns to the login screen, allowing another user to access the system without restarting the application.

<p align="center">
<img width="567" height="360" alt="image" src="https://github.com/user-attachments/assets/b57e6464-ac53-4ce4-bb2a-e35805043a91" />
</p><br><br>

## Administrator
The administrators can add, modify, and delete user information in the database. Additionally, there is a super-administrator role, which has the ability to manage administrator users as well. Administrators can search for users by name and filter them by type. They can also assign professors to courses and search for courses by name. Most of these operations are handled internally through stored procedures in the database (for example, **`AdaugaStudent`** procedure, which adds a new student’s information).

<div align="center">
  <img width="280" src="https://github.com/user-attachments/assets/d5992db1-2949-46e2-ad78-12e2e0d2d78c" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img width="280" src="https://github.com/user-attachments/assets/18d34754-6bfa-4d86-af74-382c6f442e07" />
  <br/><br/>
  <img width="300" src="https://github.com/user-attachments/assets/87d6c704-d581-43f4-be3b-6639fd68edc4" />
  &nbsp;&nbsp;&nbsp;&nbsp;
  <img width="300" src="https://github.com/user-attachments/assets/0f32aeca-649e-4610-8bd2-bde3fd41f6f4" />
</div><br><br>

## Professor
The app makes it easy to manage teaching activities and student–professor interactions. Courses are taught by multiple professors and include three types of activities: lecture, seminar, lab. The professor can schedule activities by day and time, also specifying the maximum number of participants. This is performed using the stored procedure **`ProfesorProgramareActivitate`**, which checks whether an activity already exists on the same day and time for that professor. In case of a conflict, an error message is displayed.

Students are graded for each type of activity and receive a final grade as a weighted average across all activities. The professor sets the percentage breakdown for each type through the graphical interface (e.g., 20% seminar, 35% lab, 45% lecture/exam). The **`activitati`** table has a trigger called **`TriggerRecalculeazaNoteFinala`**. When the professor updates the percentage weights of the activities, the final grades in the gradebook for all enrolled students are automatically recalculated. 

Professors can also access a gradebook where they can enter grades for students. This is managed by the **`SetareNoteStudent`** procedure.    

<div align="center">
    <img width="300" src="https://github.com/user-attachments/assets/81debd46-f119-4d9c-a6e7-62f3cc42c3ed" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="300" src="https://github.com/user-attachments/assets/a9b3c142-475a-408f-bb62-5a680e5c80f9" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="300" src="https://github.com/user-attachments/assets/58308a34-e05d-4071-8ebb-dfa6813a5f64" />
    <br/><br/>
    <img width="700" src="https://github.com/user-attachments/assets/b23910ff-259f-4ac2-92ca-d95afbec7e0d" />
</div><br><br>

## Student
Students can enroll in courses and are assigned to the professor with the fewest students at the time of enrollment (managed by **`StudentInscriereMaterie`** procedure). They can also drop courses and view their grades.

Each student must choose the activities they want to participate in. The trigger **`check_activity_enrollment`**, associated with the **`calendar`** table, checks whether a student can enroll in a specific activity. It verifies that there are available spots and ensures the student has no conflicting activities at the same time. Otherwise, an error message is displayed.

Upon logging in, students can view their activities for the current day and access a page listing all the activities they are enrolled in.

Additionally, students can join study groups for a course they are enrolled in (**`InscriereGrupStudiu`** procedure). They can view all group members and post messages. Within a study group, students can add activities and set a minimum number of participants as well as a time window for others to confirm attendance. For example, a student could add an activity for extra practice on 12.12.2025 at 16:00, lasting 2 hours, with a minimum of 5 participants and a 2-hour registration period. If the minimum number is not reached, the activity is cancelled.

<div align="center">
    <img width="250" src="https://github.com/user-attachments/assets/6af5d228-560f-4a4e-b139-1de6b839a85b" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="700" src="https://github.com/user-attachments/assets/4cd7b340-e9b2-4924-ac19-23809238d21d" />
    <br></br>
    <img width="250" src="https://github.com/user-attachments/assets/48ca2955-6caf-450c-b6f9-8d6b5aeff8bf" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="250" src="https://github.com/user-attachments/assets/3e63914a-5002-45a1-b04d-e15c4f13aedd" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="250" src="https://github.com/user-attachments/assets/e9b75021-ff49-41ca-958e-bf01d6503c15" />
    <br></br>
    <img width="250" src="https://github.com/user-attachments/assets/76a4fd71-3453-47ad-a98a-0822cdcc8685" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="250" src="https://github.com/user-attachments/assets/8bba5649-604c-45f0-9364-5e6be10da6b2" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="250" src="https://github.com/user-attachments/assets/5427e170-57a7-4995-bd6f-9a2cce8cedec" />
    <br></br>
    <img width="250" src="https://github.com/user-attachments/assets/36042658-b254-4e7d-89c5-979a7929dc30" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="250" src="https://github.com/user-attachments/assets/2a232263-8607-413a-8135-5674317873fe" />
    <br></br>
    <img width="500" src="https://github.com/user-attachments/assets/3d8ec7da-801c-4389-a19e-15a076aadb1c" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="400" src="https://github.com/user-attachments/assets/d61145b7-4823-4414-b0bf-8f0897a0b2fe" />
    <br></br>
    <img width="300" src="https://github.com/user-attachments/assets/4974496d-33fa-4f94-a446-178cd8728b57" />
    &nbsp;&nbsp;&nbsp;&nbsp;
    <img width="300" src="https://github.com/user-attachments/assets/646e9d98-5424-41c8-82fc-2f2ca1556980" />
</div><br><br>

## Data Model
<img width="1104" height="785" alt="image" src="https://github.com/user-attachments/assets/3c171551-e974-4b82-a4ea-a4dc73596c71" />
<br><br>

## Database Normalization
The database conforms to Boyce-Codd Normal Form (BCNF). Each table has a single primary key that uniquely identifies its records. For example, in the **`utilizatori`** table, the primary key is **`user_id`**, and all functional dependencies are fully dependent on this key. This ensures that each record can be uniquely identified and eliminates redundancy in the database.
<br><br>

## User Manual
When the application is launched, the user is greeted with the login window. To continue, they must enter their login credentials: email address and password.

After logging in, the page corresponding to the user’s role (student, professor, administrator, or super-administrator) will open. This window allows performing various operations within the study platform. Students can enroll in courses and activities. Professors can schedule different activities (lecture, seminar, lab) and grade students. Administrators and super-administrators can add, modify, and delete information in the database, as well as search for users by name and role.

The program also provides a logout feature, returning the user to the login window so that another user can access the platform without restarting the application.

The graphical interface makes all these operations easy to perform. In addition, the design is user-friendly, facilitating efficient data management.






















