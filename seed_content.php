<?php
require_once 'config/db.php';

// Disable foreign key checks to allow truncating if needed, but we will use INSERT IGNORE
// $pdo->exec("SET FOREIGN_KEY_CHECKS=0");

echo "<h2>Seeding Database Content...</h2>";

// 1. Subjects
$subjects = [
    ['name' => 'English', 'icon' => 'assets/img/subjects/english.png'],
    ['name' => 'Mathematics', 'icon' => 'assets/img/subjects/math.png'],
    ['name' => 'Science', 'icon' => 'assets/img/subjects/science.png'],
    ['name' => 'General Knowledge', 'icon' => 'assets/img/subjects/gk.png']
];

$subjectIds = [];

foreach ($subjects as $sub) {
    $stmt = $pdo->prepare("SELECT subject_id FROM subjects WHERE subject_name = ?");
    $stmt->execute([$sub['name']]);
    $existing = $stmt->fetch();

    if ($existing) {
        $subjectIds[$sub['name']] = $existing['subject_id'];
        echo "Subject '{$sub['name']}' already exists.<br>";
    } else {
        $stmt = $pdo->prepare("INSERT INTO subjects (subject_name, subject_icon) VALUES (?, ?)");
        $stmt->execute([$sub['name'], $sub['icon']]);
        $subjectIds[$sub['name']] = $pdo->lastInsertId();
        echo "Inserted Subject: {$sub['name']}<br>";
    }
}

// 2. Lessons (Mapped to Subjects)
$lessonsData = [
    'English' => [
        ['title' => 'Alphabets (A–Z)', 'desc' => 'Learn the alphabet from A to Z with fun images.', 'video' => 'https://www.youtube.com/embed/hq3yfQnllfQ'],
        ['title' => 'Phonics & Letter Sounds', 'desc' => 'Understand how each letter sounds.', 'video' => 'https://www.youtube.com/embed/P-eDpLke0Vs'],
        ['title' => 'Simple Words', 'desc' => 'Learn simple words like Cat, Bat, and Dog.', 'video' => 'https://www.youtube.com/embed/M0T_bK4oD8k'],
        ['title' => 'Simple Sentences', 'desc' => 'Read easy sentences for beginners.', 'video' => 'https://www.youtube.com/embed/5mGh0hU3uYc'],
        ['title' => 'Rhymes & Short Stories', 'desc' => 'Enjoy fun rhymes and short stories.', 'video' => 'https://www.youtube.com/embed/yCjJyiqpAuU']
    ],
    'Mathematics' => [
        ['title' => 'Numbers & Counting', 'desc' => 'Count from 1 to 100!', 'video' => 'https://www.youtube.com/embed/0TgLtF3PMOc'],
        ['title' => 'Addition', 'desc' => 'Learn how to add numbers together.', 'video' => 'https://www.youtube.com/embed/AuX7nPBqDts'],
        ['title' => 'Subtraction', 'desc' => 'Learn how to take away numbers.', 'video' => 'https://www.youtube.com/embed/IgPrhL6uB_g'],
        ['title' => 'Shapes', 'desc' => 'Identify Circle, Square, Triangle, and more.', 'video' => 'https://www.youtube.com/embed/guNdJ5MtX1A'],
        ['title' => 'Number Games', 'desc' => 'Fun games with numbers.', 'video' => 'https://www.youtube.com/embed/4I2j1s8y8y8']
    ],
    'Science' => [
        ['title' => 'Animals', 'desc' => 'Learn about wild and domestic animals.', 'video' => 'https://www.youtube.com/embed/5oYdN1FXz9E'],
        ['title' => 'Plants', 'desc' => 'Understand parts of a plant and how they grow.', 'video' => 'https://www.youtube.com/embed/Z_I_P-8_pC8'],
        ['title' => 'Human Body', 'desc' => 'Learn about body parts like Eyes, Ears, and Nose.', 'video' => 'https://www.youtube.com/embed/BwHMMZQGFoM'],
        ['title' => 'Water & Air', 'desc' => 'Why do we need water and air?', 'video' => 'https://www.youtube.com/embed/PjPOi5q2aIE'],
        ['title' => 'Day & Night', 'desc' => 'Understand the sun, moon, and stars.', 'video' => 'https://www.youtube.com/embed/Wr-CRKsTYSw']
    ],
    'General Knowledge' => [
        ['title' => 'Colours', 'desc' => 'Identify Red, Blue, Green, and more.', 'video' => 'https://www.youtube.com/embed/jYAWf8Y91hA'],
        ['title' => 'Fruits & Vegetables', 'desc' => 'Healthy food names and identification.', 'video' => 'https://www.youtube.com/embed/ut_3a6x3k4M'],
        ['title' => 'Festivals', 'desc' => 'Learn about Diwali, Christmas, and Eid.', 'video' => 'https://www.youtube.com/embed/XqZsoesa55w'],
        ['title' => 'Good Habits', 'desc' => 'Daily habits for a healthy life.', 'video' => 'https://www.youtube.com/embed/d1Cv9aJrlOw'],
        ['title' => 'Our Country', 'desc' => 'Learn about our national flag and symbols.', 'video' => 'https://www.youtube.com/embed/K8iC10qjF78']
    ]
];

foreach ($lessonsData as $subjName => $lessons) {
    if (!isset($subjectIds[$subjName])) continue;
    $subjId = $subjectIds[$subjName];

    foreach ($lessons as $lesson) {
        // Insert Lesson
        $stmt = $pdo->prepare("SELECT lesson_id FROM lessons WHERE lesson_title = ? AND subject_id = ?");
        $stmt->execute([$lesson['title'], $subjId]);
        $existLesson = $stmt->fetch();

        $lessonId = null;
        if ($existLesson) {
            $lessonId = $existLesson['lesson_id'];
            // Update desc/video just in case
            $upd = $pdo->prepare("UPDATE lessons SET lesson_description = ?, video_url = ? WHERE lesson_id = ?");
            $upd->execute([$lesson['desc'], $lesson['video'], $lessonId]);
            echo "Updated Lesson: {$lesson['title']}<br>";
        } else {
            $stmt = $pdo->prepare("INSERT INTO lessons (subject_id, lesson_title, lesson_description, video_url) VALUES (?, ?, ?, ?)");
            $stmt->execute([$subjId, $lesson['title'], $lesson['desc'], $lesson['video']]);
            $lessonId = $pdo->lastInsertId();
            echo "Inserted Lesson: {$lesson['title']}<br>";
        }

        // 3. Create Quiz for this Lesson (Topic)
        $quizTitle = $lesson['title'] . " Quiz";
        $stmt = $pdo->prepare("SELECT quiz_id FROM quizzes WHERE quiz_title = ?");
        $stmt->execute([$quizTitle]);
        $existQuiz = $stmt->fetch();

        $quizId = null;
        if ($existQuiz) {
            $quizId = $existQuiz['quiz_id'];
            echo "-- Quiz exists: $quizTitle<br>";
        } else {
            $stmt = $pdo->prepare("INSERT INTO quizzes (subject_id, quiz_title) VALUES (?, ?)");
            $stmt->execute([$subjId, $quizTitle]);
            $quizId = $pdo->lastInsertId();
            echo "-- Created Quiz: $quizTitle<br>";
        }

        // 4. Add Questions (Sample questions based on lesson title)
        addQuestionsForQuiz($pdo, $quizId, $lesson['title']);
    }
}

function addQuestionsForQuiz($pdo, $quizId, $topic) {
    // Check if questions exist
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM quiz_questions WHERE quiz_id = ?");
    $stmt->execute([$quizId]);
    if ($stmt->fetchColumn() > 0) return; // Skip if already populated

    $questions = [];
    
    // Generate simple questions based on keywords
    if (strpos($topic, 'Alphabets') !== false) {
        $questions[] = ['q' => 'Which letter comes after A?', 'a' => 'B', 'b' => 'C', 'c' => 'D', 'd' => 'E', 'cor' => 'A'];
        $questions[] = ['q' => 'Which letter is for Apple?', 'a' => 'B', 'b' => 'A', 'c' => 'Z', 'd' => 'M', 'cor' => 'B'];
        $questions[] = ['q' => 'How many letters are in the alphabet?', 'a' => '10', 'b' => '20', 'c' => '26', 'd' => '5', 'cor' => 'C'];
    } elseif (strpos($topic, 'Numbers') !== false || strpos($topic, 'Addition') !== false) {
        $questions[] = ['q' => 'What is 1 + 1?', 'a' => '1', 'b' => '2', 'c' => '3', 'd' => '4', 'cor' => 'B'];
        $questions[] = ['q' => 'Count the fingers on one hand.', 'a' => '4', 'b' => '6', 'c' => '5', 'd' => '10', 'cor' => 'C'];
        $questions[] = ['q' => 'Which number comes after 9?', 'a' => '8', 'b' => '10', 'c' => '11', 'd' => '7', 'cor' => 'B'];
    } elseif (strpos($topic, 'Animals') !== false) {
        $questions[] = ['q' => 'Which animal says "Meow"?', 'a' => 'Dog', 'b' => 'Cat', 'c' => 'Cow', 'd' => 'Lion', 'cor' => 'B'];
        $questions[] = ['q' => 'Who is the King of the Jungle?', 'a' => 'Lion', 'b' => 'Tiger', 'c' => 'Elephant', 'd' => 'Bear', 'cor' => 'A'];
        $questions[] = ['q' => 'Which animal has a long trunk?', 'a' => 'Snake', 'b' => 'Elephant', 'c' => 'Monkey', 'd' => 'Rabbit', 'cor' => 'B'];
    } elseif (strpos($topic, 'Colours') !== false) {
        $questions[] = ['q' => 'What is the color of the sky?', 'a' => 'Green', 'b' => 'Red', 'c' => 'Blue', 'd' => 'Yellow', 'cor' => 'C'];
        $questions[] = ['q' => 'What is the color of a banana?', 'a' => 'Yellow', 'b' => 'Purple', 'c' => 'Black', 'd' => 'Pink', 'cor' => 'A'];
        $questions[] = ['q' => 'What color is an apple?', 'a' => 'Blue', 'b' => 'Red', 'c' => 'White', 'd' => 'Black', 'cor' => 'B'];
    } else {
        // Generic Questions
        $questions[] = ['q' => "What is this topic about: $topic?", 'a' => 'Learning', 'b' => 'Sleeping', 'c' => 'Eating', 'd' => 'Running', 'cor' => 'A'];
        $questions[] = ['q' => 'Is this fun?', 'a' => 'Yes', 'b' => 'No', 'c' => 'Maybe', 'd' => 'I dont know', 'cor' => 'A'];
        $questions[] = ['q' => 'Click the correct answer.', 'a' => 'Wrong', 'b' => 'Wrong', 'c' => 'Correct', 'd' => 'Wrong', 'cor' => 'C'];
    }

    foreach ($questions as $q) {
        $stmt = $pdo->prepare("INSERT INTO quiz_questions (quiz_id, question, option_a, option_b, option_c, option_d, correct_option) VALUES (?, ?, ?, ?, ?, ?, ?)");
        $stmt->execute([$quizId, $q['q'], $q['a'], $q['b'], $q['c'], $q['d'], $q['cor']]);
    }
    echo "---- Added " . count($questions) . " questions.<br>";
}

echo "<h3>Seeding Completed Successfully!</h3>";
?>
