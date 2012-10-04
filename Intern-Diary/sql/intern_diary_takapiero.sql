CREATE TABLE user (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARBINARY(32) NOT NULL,
    created_on DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY (name)
);

CREATE TABLE entry (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id INT UNSIGNED NOT NULL,
    title VARBINARY(255) NOT NULL,
    body BLOB NOT NULL,
    is_deleted TINYINT NOT NULL,
    created_on DATETIME NOT NULL,
    updated_on DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY (user_id, created_on)
);
