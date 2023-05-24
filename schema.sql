DROP TABLE REVIEWER;
DROP TABLE ORDER_STATUS;
DROP TABLE Wash;
DROP TABLE DryWash;
DROP TABLE WashAndIron;
DROP TABLE Iron;
DROP TABLE ClothClassification;
DROP TABLE SERVICE;
DROP TABLE ORDER_DETAILS;
DROP TABLE ORDERS;
DROP TABLE LAUNDRY_MANAGER;
DROP TABLE LAUNDRY_USER;
DROP TABLE Notification;
DROP TABLE USERS;
DROP TABLE LAUNDRY;

CREATE TABLE USERS(
  username varchar(100),
  email varchar(100),
  password varchar(250),
  CONSTRAINT pk_USERS PRIMARY KEY (email)
);

CREATE TABLE LAUNDRY(
  laundryID varchar(50),
  laundryName varchar(100),
  laundryAddress varchar(100),
  CONSTRAINT pk_LAUNDRY PRIMARY KEY (laundryID)
);

CREATE TABLE LAUNDRY_MANAGER(
  email varchar(100),
  laundryID varchar(50) NULL,
  CONSTRAINT pk_LaundryManager PRIMARY KEY (email),
  CONSTRAINT fk_LaundryManagerUSER FOREIGN KEY(email) REFERENCES USERS(email) ON DELETE CASCADE,
  CONSTRAINT fk_LaundryManagerLaundry FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE
);

CREATE TABLE LAUNDRY_USER(
  email varchar(100),
  CONSTRAINT pk_LaundryUser PRIMARY KEY (email),
  CONSTRAINT fk_LaundryUser FOREIGN KEY(email) REFERENCES USERS(email) ON DELETE CASCADE
);

CREATE TABLE REVIEWER(
  laundryID varchar(50),
  email varchar(100),
  ReviewStars NUMERIC,
  Review varchar(512),
  CONSTRAINT pk_LaundryReview PRIMARY KEY (laundryID,email),
  CONSTRAINT revStarLimit CHECK(ReviewStars<=10),
  CONSTRAINT fk_REVIEW_USERS FOREIGN KEY(email) REFERENCES LAUNDRY_USER(email) ON DELETE CASCADE,
  CONSTRAINT fk_REVIEW_LAUNDRY FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE
);


CREATE TABLE ORDERS(
  orderID varchar(100),
  email varchar(100),
  laundryID varchar(50),
  CONSTRAINT pk_Order PRIMARY KEY(orderID),
  CONSTRAINT uniq_order UNIQUE(email,orderID),
  CONSTRAINT fk_Order FOREIGN KEY(email) REFERENCES LAUNDRY_USER(email) ON DELETE CASCADE
);

CREATE TABLE SERVICE( --reference table
  operationID varchar(50),
  clothType varchar(100),
  laundryID varchar(50),
  constraint pk_Service PRIMARY KEY(operationID),
  constraint uniq_Service UNIQUE(clothType,laundryID),
  constraint fk_Service FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE
);

CREATE TABLE DryWash(
  operationID varchar(50),
  laundryID varchar(50),
  price numeric,
  constraint pk_DryWash PRIMARY KEY(operationID),
  constraint uniq_DryWash UNIQUE(laundryID),
  constraint fk_DryWash FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE,
  constraint fk_DryWashService FOREIGN KEY(operationID) REFERENCES SERVICE(operationID) ON DELETE CASCADE
);

CREATE TABLE Wash(
  operationID varchar(50),
  laundryID varchar(50),
  price numeric,
  constraint pk_Wash PRIMARY KEY(operationID),
  constraint uniq_Wash UNIQUE(laundryID),
  constraint fk_Wash FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE,
  constraint fk_WashService FOREIGN KEY(operationID) REFERENCES SERVICE(operationID) ON DELETE CASCADE
);

CREATE TABLE WashAndIron(
  operationID varchar(50),
  laundryID varchar(50),
  price numeric,
  constraint pk_WashAndIron PRIMARY KEY(operationID),
  constraint uniq_WashAndIron UNIQUE(laundryID),
  constraint fk_WashAndIron FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE,
  constraint fk_WashAndIronService FOREIGN KEY(operationID) REFERENCES SERVICE(operationID) ON DELETE CASCADE
);

CREATE TABLE Iron(
  operationID varchar(50),
  laundryID varchar(50),
  price numeric,
  constraint pk_Iron PRIMARY KEY(operationID),
  constraint uniq_Iron UNIQUE(laundryID),
  constraint fk_Iron FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID) ON DELETE CASCADE,
  constraint fk_IronService FOREIGN KEY(operationID) REFERENCES SERVICE(operationID) ON DELETE CASCADE
);


CREATE TABLE ORDER_DETAILS(
  orderID varchar(100),
  clothID varchar(100),
  CONSTRAINT pk_OrderDetails PRIMARY KEY(clothID),
  CONSTRAINT fk_OrderDetails FOREIGN KEY(orderID) REFERENCES ORDERS(orderID) ON DELETE CASCADE
);

CREATE TABLE ClothClassification(
  clothID varchar(100),
  clothType varchar(100),
  laundryID varchar(50),
  CONSTRAINT pk_ClothClassification PRIMARY KEY(clothID),
  CONSTRAINT fk_ClothClassification FOREIGN KEY(clothID) REFERENCES ORDER_DETAILS(clothID),
  CONSTRAINT fk_ClothClassificationService FOREIGN KEY(clothType,laundryID) REFERENCES SERVICE(clothType,laundryID) ON DELETE CASCADE
);

CREATE TABLE ORDER_STATUS(
  orderID varchar(100),
  paidAmount NUMERIC,
  delivered BOOLEAN,
  CONSTRAINT pk_OrderStatus PRIMARY KEY(orderID),
  CONSTRAINT fk_OrderStatus FOREIGN KEY(orderID) REFERENCES ORDERS(orderID) ON DELETE CASCADE
);

CREATE TABLE Notification(
  NotificationID varchar(100),
  NotificationMessage varchar(255),
  laundryID varchar(50),
  email varchar(100),
  CONSTRAINT pk_Notification PRIMARY KEY(NotificationID),
  CONSTRAINT fk_NotificationUSERS FOREIGN KEY (email) REFERENCES USERS(email),
  CONSTRAINT fk_NotificationLaundry FOREIGN KEY(laundryID) REFERENCES LAUNDRY(laundryID)
);






