CREATE TABLE user (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARBINARY(32) NOT NULL,
    tutorial_step INT UNSIGNED NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
);

CREATE TABLE entry (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    title VARBINARY(255) NOT NULL,
    body BLOB NOT NULL,
    is_deleted TINYINT NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY (user_id, is_deleted)
);

CREATE TABLE user_tutorial_question_log (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    question_id INT UNSIGNED NOT NULL,
    answer_id INT UNSIGNED,
    answer_text VARBINARY(255),
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (user_id, question_id),
    KEY (user_id)
);

CREATE TABLE tutorial_question (
    id INT UNSIGNED NOT NULL,
    category INT UNSIGNED NOT NULL,
    title VARBINARY(255) NOT NULL,
    description VARBINARY(255) NOT NULL,
    PRIMARY KEY (id)
);

INSERT INTO `tutorial_question` VALUES (1001,1,'質問1','今日の朝食は何を食べましたか？'),(1002,1,'質問1','昨日の夕食は何を食べましたか？'),(2001,2,'質問2','音楽は好きですか？'),(2002,2,'質問2','読書は好きですか？'),(3001,3,'質問3','あだ名を教えてください'),(3002,3,'質問3','好きな食べ物を教えてください');
