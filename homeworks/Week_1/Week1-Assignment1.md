# Week 1 Homework Assignments: Introduction to MATLAB

## 1. Exploring the MATLAB Interface

### Task
Perform a guided tour of the MATLAB interface.

### Instructions
- Open MATLAB and explore the different components:
    - **Command Window**: Type `help` and read about how to use MATLAB’s help system.
    - **Workspace**: Observe how variables appear in the Workspace as you create them.
    - **Editor**: Create a new script file and save it with a name like `week1_script.m`.
    - **Command History**: Note how commands entered in the Command Window appear here.

- **Deliverable**: Write a brief report (1-2 paragraphs) describing what each part of the interface is used for and any observations made while exploring. Include a screenshot of the MATLAB interface with the important sections labeled.

---

## 2. Basic Commands and Calculations

### Task
Practice using basic MATLAB commands and performing simple calculations.

### Instructions
- In the Command Window, type and execute the following commands:
    ```matlab
    % Basic arithmetic
    a = 5;
    b = 3;
    sum = a + b;
    difference = a - b;
    product = a * b;
    quotient = a / b;
    power = a ^ b;

    % Clear the Command Window and Workspace
    clc;
    clear;
    ```
- Experiment with different values for `a` and `b`.
- Use `whos` to check which variables are currently in the Workspace.

- **Deliverable**: Submit a script file (`week1_commands.m`) containing the above commands. Include comments explaining what each line of code does. Additionally, answer the following questions:
    - What does `clc` do?
    - What happens when you use `clear`?
    - What does `whos` display?

---

## 3. Creating and Using Variables

### Task
Get comfortable with creating and manipulating variables.

### Instructions
- Create variables for storing different types of data:
    ```matlab
    % Variables
    name = 'John Doe'; % String
    age = 20; % Integer
    height = 5.9; % Float
    is_student = true; % Boolean

    % Perform a calculation using these variables
    age_next_year = age + 1;
    ```
- Try changing the values of these variables and see how it affects the calculation.

- **Deliverable**: Submit a script file (`week1_variables.m`) that includes the code above, with comments explaining what each variable represents. Include an additional section where you create at least three more variables of different types and perform operations with them.

---

## 4. Simple Script Creation

### Task
Write a simple script to perform a basic task.

### Instructions
- Create a new script in the MATLAB Editor and save it as `calculate_area.m`.
- Write a script that calculates the area of a rectangle. Use variables for length and width, and print out the area.
    ```matlab
    % Calculate the area of a rectangle
    length = 8; % Length of the rectangle
    width = 5; % Width of the rectangle
    area = length * width; % Calculate area
    fprintf('The area of the rectangle is: %.2f\n', area);
    ```
- Run the script from the Command Window by typing `calculate_area`.

- **Deliverable**: Submit the script file (`calculate_area.m`). Include comments explaining each line. Run the script with different values for length and width, and note down the results.

---

## 5. Using the Help System

### Task
Learn to use MATLAB’s help system to find information on commands and functions.

### Instructions
- Use the `help` command to learn about at least three different MATLAB functions or commands (e.g., `plot`, `disp`, `sin`).
- Find the documentation for a function that interests you, and write a summary of what it does and how to use it.

- **Deliverable**: Write a short report (1 page) summarizing the three functions you researched, including examples of how to use each function. Use comments in MATLAB to demonstrate your understanding.
