import 'package:flutter/material.dart';
import '../models/language.dart';
import '../models/lesson.dart';

class CourseData {
  static List<ProgrammingLanguage> getLanguages() {
    return [
      ProgrammingLanguage(
        id: 'html',
        name: 'HTML',
        description: 'Structure the web with HyperText Markup Language',
        iconPath: 'HTML',
        color: const Color(0xFFE34C26),
        topics: ['Basics', 'Forms', 'Semantic HTML', 'Media', 'Best Practices'],
        totalLessons: 5,
      ),
      ProgrammingLanguage(
        id: 'javascript',
        name: 'JavaScript',
        description: 'Add interactivity and logic to your websites',
        iconPath: 'JS',
        color: const Color(0xFFF7DF1E),
        topics: ['Variables', 'Functions', 'DOM', 'Async', 'ES6+'],
        totalLessons: 5,
      ),
      ProgrammingLanguage(
        id: 'react',
        name: 'React.js',
        description: 'Build modern UIs with components and hooks',
        iconPath: 'React',
        color: const Color(0xFF61DAFB),
        topics: ['Components', 'JSX', 'State', 'Hooks', 'Routing'],
        totalLessons: 5,
      ),
      ProgrammingLanguage(
        id: 'php',
        name: 'PHP',
        description: 'Server-side scripting for dynamic web applications',
        iconPath: 'PHP',
        color: const Color(0xFF777BB4),
        topics: ['Syntax', 'Arrays', 'Functions', 'OOP', 'MySQL'],
        totalLessons: 5,
      ),
    ];
  }

  static List<Lesson> getLessons(String languageId) {
    final lessons = {
      'html': [
        Lesson(
          id: 'html_1',
          languageId: 'html',
          title: 'HTML Basics',
          order: 1,
          language: 'html',
          content: '''HTML (HyperText Markup Language) is the standard markup language for documents designed to be displayed in a web browser.
Key Concepts:
• Elements are the building blocks of HTML
• Tags usually come in pairs: opening and closing
• Attributes provide additional information about elements
• The DOM (Document Object Model) represents the page structure''',
          codeExample: '''<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My First Page</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is my first paragraph.</p>
</body>
</html>''',
          quizzes: [
            Quiz(
              question: 'What does HTML stand for?',
              options: [
                'HyperText Markup Language',
                'HighTech Modern Language',
                'HyperTransfer Markup Language',
                'Home Tool Markup Language'
              ],
              correctIndex: 0,
              explanation: 'HTML stands for HyperText Markup Language.',
            ),
            Quiz(
              question: 'Which tag is used for the largest heading?',
              options: ['<h6>', '<head>', '<h1>', '<header>'],
              correctIndex: 2,
              explanation: '<h1> defines the most important heading.',
            ),
          ],
        ),
        Lesson(
          id: 'html_2',
          languageId: 'html',
          title: 'Forms & Input',
          order: 2,
          language: 'html',
          content: '''HTML forms are used to collect user input. Form elements include text fields, checkboxes, radio buttons, submit buttons, and more
          Important Form Elements:
• <input> - Various input types (text, email, password, etc.)
• <textarea> - Multi-line text input
• <select> - Dropdown list
• <button> - Clickable button''',
          codeExample: '''<form action="/submit" method="POST">
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>
    
    <label for="message">Message:</label>
    <textarea id="message" name="message" rows="4"></textarea>
    
    <button type="submit">Send</button>
</form>''',
          quizzes: [
            Quiz(
              question: 'Which input type is used for email validation?',
              options: ['text', 'email', 'mail', 'string'],
              correctIndex: 1,
            ),
          ],
        ),
      ],
      'javascript': [
        Lesson(
          id: 'js_1',
          languageId: 'javascript',
          title: 'Variables & Data Types',
          order: 1,
          language: 'javascript',
          content: '''JavaScript variables can be declared using let, const, or var (legacy).

Data Types:
• String: Text data
• Number: Numeric values
• Boolean: true/false
• Array: Ordered collection
• Object: Key-value pairs
• Undefined & Null: Absence of value''',
          codeExample: '''// Variable declarations
let name = "Alice";
const PI = 3.14159;
var isActive = true;

// Data types
let age = 25;           // Number
let hobbies = ["coding", "reading"];  // Array
let user = {            // Object
    name: "Bob",
    age: 30
};console.log(typeof name);  // "string"''',
          quizzes: [
            Quiz(
              question: 'Which keyword declares a constant variable?',
              options: ['var', 'let', 'const', 'static'],
              correctIndex: 2,
              explanation: 'const creates a read-only reference to a value.',
            ),
          ],
        ),
        Lesson(
          id: 'js_2',
          languageId: 'javascript',
          title: 'Functions & Arrow Functions',
          order: 2,
          language: 'javascript',
          content: '''Functions are reusable blocks of code. ES6 introduced arrow functions for shorter syntax.

Function Types:
• Function declarations
• Function expressions
• Arrow functions
• Immediately Invoked Function Expressions (IIFE)''',
          codeExample: r'''// Traditional function
function greet(name) {
    return "Hello, " + name;
}

// Arrow function
const greet = (name) => {
    return `Hello, ${name}`;
};

// Shorter arrow function
const greet = name => `Hello, ${name}`;

// Default parameters
const multiply = (a, b = 1) => a * b;''',
          quizzes: [
            Quiz(
              question: 'What is the output of: const add = a => a + 5; add(3)?',
              options: ['3', '5', '8', 'undefined'],correctIndex: 2,
            ),
          ],
        ),
      ],
      'react': [
        Lesson(
          id: 'react_1',
          languageId: 'react',
          title: 'Components & JSX',
          order: 1,
          language: 'javascript',
          content: '''React components are independent and reusable pieces of code. JSX is a syntax extension that looks like HTML.

Key Points:
• Components can be class-based or function-based
• JSX must return a single parent element
• Use camelCase for attributes (className instead of class)
• Expressions go inside curly braces {}''',
          codeExample: '''// Functional Component
function Welcome(props) {
    return <h1>Hello, {props.name}</h1>;
}

// Arrow function component
const Welcome = ({ name, age }) => {
    return (
        <div className="card">
            <h1>Hello, {name}</h1>
            <p>You are {age} years old</p>
        </div>
    );
};

// Usage
<Welcome name="Alice" age={25} />''',
          quizzes: [
            Quiz(
              question: 'What does JSX stand for?',options: [
                'JavaScript XML',
                'Java Syntax Extension',
                'JSON XML',
                'JavaScript Xtra'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'react_2',
          languageId: 'react',
          title: 'State & Hooks',
          order: 2,
          language: 'javascript',
          content: '''Hooks let you use state and other React features in function components.

Common Hooks:
• useState - Manage local state
• useEffect - Side effects (data fetching, subscriptions)
• useContext - Access React context
• useRef - Reference DOM elements''',
          codeExample: r'''import { useState, useEffect } from 'react';

function Counter() {
    const [count, setCount] = useState(0);
    
    useEffect(() => {
        document.title = `Count: ${count}`;
    }, [count]);
    
    return (
        <div>
            <p>You clicked {count} times</p>
            <button onClick={() => setCount(count + 1)}>
                Click me
            </button>
        </div>
    );
}''',
          quizzes: [
            Quiz(
              question: 'Which hook is used for side effects?',
              options: ['useState', 'useEffect', 'useContext', 'useReducer'],
              correctIndex: 1,
            ),
          ],
        ),
      ],
      'php': [
        Lesson(
          id: 'php_1',
          languageId: 'php',
          title: 'PHP Basics',
          order: 1,
          language: 'php',
          content: r'''PHP (PHP: Hypertext Preprocessor) is a server-side scripting language designed for web development.Basics:
• Code is wrapped in <?php ?> tags
• Statements end with semicolons
• Variables start with $
• echo/print output text''',
          codeExample: r'''<?php
// Variables
$name = "Alice";
$age = 25;
$isStudent = true;

// Output
echo "Hello, $name!";
print "You are $age years old.";

// Concatenation
$greeting = "Hello" . " " . "World";// Arrays
$fruits = array("apple", "banana", "orange");
$colors = ["red", "green", "blue"]; // PHP 5.4+
?>''',
          quizzes: [
            Quiz(
              question: 'How do you declare a variable in PHP?',
              options: ['var name', 'name', r'$name', '@name'],
              correctIndex: 2,
            ),
          ],
        ),
        Lesson(
          id: 'php_2',
          languageId: 'php',
          title: 'Arrays & Loops',
          order: 2,
          language: 'php',
          content: '''PHP supports indexed arrays, associative arrays, and multidimensional arrays.

Loop Types:
• for - Count-controlled loop
• foreach - Iterate over arrays
• while - Condition-controlled loop
• do...while - Executes at least once''',
          codeExample: r'''<?php
// Indexed array
$numbers = [1, 2, 3, 4, 5];
// Associative array
$person = [
    "name" => "Bob",
    "age" => 30,
    "city" => "New York"
];

// foreach loop
foreach ($person as $key =>$value) {
    echo "$key:$value\n";
}

// for loop
for ($i = 0; $i < count($numbers);$i++) {
    echo $numbers[$i];
}
?>''',
          quizzes: [
            Quiz(
              question: 'Which loop is best for iterating over an array?',
              options: ['for', 'while', 'foreach', 'do-while'],
              correctIndex: 2,
            ),
          ],
        ),
      ],
    };
return lessons[languageId] ?? [];
  }
}
