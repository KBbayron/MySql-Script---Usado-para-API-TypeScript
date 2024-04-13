CREATE DATABASE Textiles COLLATE utf8mb4_general_ci;

USE Textiles;

CREATE TABLE ProductCategories (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `code` VARCHAR(50),
    `status` INT DEFAULT 1
);

CREATE TABLE Corporations (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE ContactInformation (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE JobTitles (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE Persons (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name1` VARCHAR(50) NOT NULL,
    `firstLastname` VARCHAR(50) NOT NULL,
    `secondLastname` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE Sizes (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50),
    `code` VARCHAR(50),
    `status` INT DEFAULT 1
);

CREATE TABLE Permission (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE HiringTypes (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE OrderStatues (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE ProductSizes (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `productId` INT NOT NULL,
    `sizeId` INT NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE PaidTypes (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE PersonalContact (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `personId` INT NOT NULL,
    `contactId` INT NOT NULL,
    `description` VARCHAR(100),
    `status` INT DEFAULT 1,
    FOREIGN KEY (`personId`) REFERENCES Persons (`id`),
    FOREIGN KEY (`contactId`) REFERENCES ContactInformation (`id`)
);

CREATE TABLE Clients (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `personlId` INT NOT NULL,
    `createdAt` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`personlId`) REFERENCES Persons (`id`)
);

CREATE TABLE Employees (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `personlId` INT NOT NULL,
    `jobTitleId` INT NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`personlId`) REFERENCES Persons (`id`),
    FOREIGN KEY (`jobTitleId`) REFERENCES JobTitles (`id`)
);

CREATE TABLE Hirings (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `employeeId` INT NOT NULL,
    `hiringTypeId` INT NOT NULL,
    `salary` FLOAT NOT NULL,
    `startDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `endDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `description` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`employeeId`) REFERENCES Employees (`id`),
    FOREIGN KEY (`hiringTypeId`) REFERENCES HiringTypes (`id`)
);

CREATE TABLE Campus (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `corporationId` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `code` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`corporationId`) REFERENCES Corporations (`id`)
);

CREATE TABLE CampusContacts (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `contactId` INT NOT NULL,
    `campusId` INT NOT NULL,
    `description` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`contactId`) REFERENCES ContactInformation (`id`),
    FOREIGN KEY (`campusId`) REFERENCES Campus (`id`)
);

CREATE TABLE InstitutionType (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `typeId` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1
);

CREATE TABLE Institutions (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `typeId` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`typeId`) REFERENCES InstitutionType (`id`)
);

CREATE TABLE Orders (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `idClient` INT NOT NULL,
    `idEmployee` INT NOT NULL,
    `orderStatusId` INT NOT NULL,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `amount` INT NOT NULL,
    `pendingAmount` INT NOT NULL,
    `discount` INT NOT NULL,
    `idPaid` INT NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`idClient`) REFERENCES Clients (`id`),
    FOREIGN KEY (`idEmployee`) REFERENCES Employees (`id`),
    FOREIGN KEY (`orderStatusId`) REFERENCES OrderStatues (`id`)
);

CREATE TABLE OrderPaids (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `orderId` INT NOT NULL,
    `paidTypeId` INT NOT NULL,
    `amount` INT NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`orderId`) REFERENCES Orders (`id`),
    FOREIGN KEY (`paidTypeId`) REFERENCES PaidTypes (`id`)
);

CREATE TABLE Commissions (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `institutionId` INT NOT NULL,
    `percentage` INT NOT NULL,
    `startDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `endDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`institutionId`) REFERENCES Institutions (`id`)
);

CREATE TABLE InstitutionsContacts (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `personId` INT NOT NULL,
    `institutionId` INT NOT NULL,
    `startDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `endDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`personId`) REFERENCES Persons (`id`),
    FOREIGN KEY (`institutionId`) REFERENCES Institutions (`id`)
);

CREATE TABLE JobTitlesPermissions (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `jobTitleId` INT NOT NULL,
    `permissionId` INT NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`jobTitleId`) REFERENCES JobTitles (`id`),
    FOREIGN KEY (`permissionId`) REFERENCES Permission (`id`)
);

CREATE TABLE Products (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `categoryId` INT NOT NULL,
    `institutionId` INT NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(50) NOT NULL,
    `image` VARCHAR(50) NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`categoryId`) REFERENCES ProductCategories (`id`),
    FOREIGN KEY (`institutionId`) REFERENCES Institutions (`id`)
);

CREATE TABLE OrderDetails (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `orderId` INT NOT NULL,
    `productId` INT NOT NULL,
    `quantity` INT NOT NULL,
    `description` VARCHAR(50) NOT NULL,
    `amount` INT NOT NULL,
    `status` INT DEFAULT 1,
    FOREIGN KEY (`orderId`) REFERENCES Orders (`id`),
    FOREIGN KEY (`productId`) REFERENCES Products (`id`)
);


