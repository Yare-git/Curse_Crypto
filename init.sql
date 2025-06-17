-- Создание таблицы Users
CREATE TABLE IF NOT EXISTS Users (
    Id SERIAL PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL -- Можно ENUM, но PostgreSQL не поддерживает ENUM по умолчанию, лучше VARCHAR или создайте тип ENUM отдельно
);

-- Создание таблицы Courses
CREATE TABLE IF NOT EXISTS Courses (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Description TEXT,
    CreatedById INT REFERENCES Users(Id)
);

-- Создание таблицы Groups
CREATE TABLE IF NOT EXISTS Groups (
    Id SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    CourseId INT REFERENCES Courses(Id)
);

-- Таблица StudentsInGroups
CREATE TABLE IF NOT EXISTS StudentsInGroups (
    Id SERIAL PRIMARY KEY,
    StudentId INT REFERENCES Users(Id),
    GroupId INT REFERENCES Groups(Id)
);

-- Таблица Lessons
CREATE TABLE IF NOT EXISTS Lessons (
    Id SERIAL PRIMARY KEY,
    Date TIMESTAMP NOT NULL,
    Topic VARCHAR(255),
    GroupId INT REFERENCES Groups(Id)
);

-- Таблица Attendances
CREATE TABLE IF NOT EXISTS Attendances (
    Id SERIAL PRIMARY KEY,
    LessonId INT REFERENCES Lessons(Id),
    StudentId INT REFERENCES Users(Id),
    IsPresent BOOLEAN NOT NULL
);