CREATE DATABASE IF NOT EXISTS alzikrayat_db;
USE alzikrayat_db;

CREATE TABLE users (
                       id INT NOT NULL AUTO_INCREMENT,
                       first_name VARCHAR(50) NOT NULL,
                       last_name VARCHAR(50) NOT NULL,
                       email VARCHAR(100) NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       location VARCHAR(100) DEFAULT NULL,
                       description TEXT,
                       occupation VARCHAR(100) DEFAULT NULL,
                       PRIMARY KEY (id),
                       UNIQUE KEY email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE photos (
                        id INT NOT NULL AUTO_INCREMENT,
                        user_id INT NOT NULL,
                        file_name VARCHAR(255) NOT NULL,
                        title VARCHAR(200) NOT NULL,
                        description TEXT,
                        date_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                        PRIMARY KEY (id),
                        KEY user_id (user_id),
                        CONSTRAINT photos_ibfk_1
                            FOREIGN KEY (user_id)
                                REFERENCES users (id)
                                ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE comments (
                          id INT NOT NULL AUTO_INCREMENT,
                          photo_id INT NOT NULL,
                          user_id INT NOT NULL,
                          comment TEXT NOT NULL,
                          date_time TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
                          PRIMARY KEY (id),
                          KEY photo_id (photo_id),
                          KEY user_id (user_id),
                          CONSTRAINT comments_ibfk_1
                              FOREIGN KEY (photo_id)
                                  REFERENCES photos (id)
                                  ON DELETE CASCADE,
                          CONSTRAINT comments_ibfk_2
                              FOREIGN KEY (user_id)
                                  REFERENCES users (id)
                                  ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;