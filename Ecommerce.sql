CREATE DATABASE ecommerce;
use ecommerce;

--Following tables are in Ecommerce DataBase;
-- Drop TABLE User_Table;
-- Drop TABLE Buyer;
-- Drop TABLE Seller;
-- Drop TABLE Address; 
-- Drop TABLE Product;
-- Drop TABLE Shopping_Cart;
-- Drop TABLE Wishlist;
-- Drop TABLE Reviews;
-- Drop TABLE Discount;
-- Drop TABLE Offer;

-- Drop TABLE Wishlist_Product;
-- Drop TABLE Order_Product;
-- DROP TABLE Cart_Product;

-- Drop TABLE Orders;
-- Drop TABLE Invoice;
-- Drop TABLE Shipper;
-- Drop TABLE Payment;
-- Drop TABLE Payment_Card;
-- Drop TABLE Payment_Giftcard;


CREATE TABLE User_Table(
  UserID VARCHAR(8) NOT NULL,
  User_passwored VARCHAR(20) NOT NULL,
  USER_TYPE VARCHAR(1) NOT NULL,
  DateCreated DATE NOT NULL,
  PRIMARY KEY (UserID)
  );

CREATE TABLE Buyer(
  BuyerID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  Membership VARCHAR(1) NOT NULL,
  BuyerFirstName VARCHAR(50) NOT NULL,
  BuyerLastName VARCHAR(50) NULL,
  PhoneNumber VARCHAR(15) DEFAULT 'xxx-xxx-xxxx' NOT NULL,
  PRIMARY KEY (UserID)
  );
  
CREATE TABLE Seller (
  SellerID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  CompanyName VARCHAR(50) NOT NULL,
  SellerFirstName VARCHAR(50) NOT NULL,
  SellerLastName VARCHAR(50) NOT NULL,
  PhoneNumber VARCHAR(15) DEFAULT 'xxx-xxx-xxxx' NOT NULL,
  Average_rating DECIMAL NOT NULL,
  Logo BLOB NULL,
  PRIMARY KEY (SellerID));
  

CREATE TABLE Address (
  AddressID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  Address_Type VARCHAR(20) NOT NULL,
  AddressLine1 VARCHAR(50) NULL,
  City VARCHAR(50) NULL,
  State VARCHAR(50) NULL,
  Country VARCHAR(50) NULL,
  ZipCode VARCHAR(10) NULL,
  PRIMARY KEY (AddressID));

-- CREATE INDEX UserID_idx ON Sellers (UserID ASC);

CREATE TABLE Product (
  ProductID VARCHAR(8) NOT NULL,
  CategoryID VARCHAR(10) NOT NULL,
  ProductName VARCHAR(50) NOT NULL,
  UnitPrice DECIMAL NOT NULL,
  ProductDescription VARCHAR(255) NULL,
  Color VARCHAR(15) NULL,
  UnitsInStock INT NULL,
  In_Stock BOOL NOT NULL,
  ItemPicture BLOB NULL,
  listing_date DATE,
  SellerID VARCHAR(8) NOT NULL,
  PRIMARY KEY (ProductID));
  

CREATE TABLE Category(
	CategoryID VARCHAR(10) NOT NULL,
    ParentCategoryID VARCHAR(10) NULL,
    CategoryName VARCHAR(30) NULL,
    ProductID VARCHAR(8) NULL,
    PRIMARY KEY (CategoryID));

CREATE TABLE ParentCategory(
	CategoryID VARCHAR(10),
    ParentCategoryID VARCHAR(10),
	CategoryName VARCHAR(30) NULL,
    PRIMARY KEY(CategoryID));

CREATE TABLE Shopping_Cart (
  ShoppingCartID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  PRIMARY KEY (ShoppingCartID));




CREATE TABLE Wishlist (
  WishlistID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  PRIMARY KEY (WishlistID));


CREATE TABLE Reviews (
  ReviewID VARCHAR(8) NOT NULL,
  ProductID VARCHAR(8) NOT NULL,
  UserID VARCHAR(8) NOT NULL,
  CustomerReview VARCHAR(100) NULL,
  Rating DECIMAL NOT NULL,
  PRIMARY KEY (ReviewID));
  
CREATE TABLE Offer (
  OfferID VARCHAR(8) NOT NULL,
  ProductID VARCHAR(8) NULL,
  OfferAmount VARCHAR(8) NULL,
  PRIMARY KEY (OfferID));
  

-- Relationsgip between Order and Product

-- Payments
CREATE TABLE Orders (
  OrderID VARCHAR(8) NOT NULL, 
  UserID VARCHAR(8) NOT NULL,
  ShipperID VARCHAR(8)  NULL,
  OrderDate DATE NOT NULL,
  RequiredDate DATE NOT NULL,
  Tax DECIMAL NOT NULL,
  TransactionStatus VARCHAR(50) NOT NULL,
  PaymentDate DATE NOT NULL,
  ItemQuantity INT NULL,
  Price DECIMAL NOT NULL,
  ORDER_STATUS VARCHAR(20) NOT NULL,
  PRIMARY KEY (OrderID));

CREATE TABLE Order_Product (
  OrderID VARCHAR(8) NOT NULL,
  ProductID VARCHAR(8) NOT NULL,
  Ordered_Quantity INT NOT NULL,
  PRIMARY KEY (OrderID,ProductID));
  
CREATE TABLE Category(
	CategoryID VARCHAR(8) NOT NULL,
    ProductID VARCHAR(8) NOT NULL,
    PRIMARY KEY(CategoryID,ProductID));
  
CREATE TABLE Cart_Product (
  ShoppingCartID VARCHAR(8) NOT NULL,
  ProductID VARCHAR(8) NOT NULL,
  Quantity VARCHAR(8),
  Delivery_Status VARCHAR(20) NOT NULL,
  PRIMARY KEY (ShoppingCartID,ProductID));
  
CREATE TABLE WishList_Product (
  WishlistID VARCHAR(8) NOT NULL,
  ProductID VARCHAR(8) NOT NULL,
  PRIMARY KEY (WishlistID,ProductID));

CREATE TABLE Invoice (
  OrderID VARCHAR(8) NOT NULL, 
  InvoiceID VARCHAR(8) NOT NULL,
  Invoice_Type VARCHAR(10) NOT NULL,
  InvoiceAmount DECIMAL NOT NULL,
  PRIMARY KEY (InvoiceID));
  



CREATE TABLE Shipper (
  ShipperID VARCHAR(8) NOT NULL,
  ShipperCompanyName VARCHAR(50) NULL,
  ContactName VARCHAR(50) NULL,
  Phone VARCHAR(15) NULL,
  PRIMARY KEY (ShipperID));

-- Payments . Ecommerce site allows you to pay using multiple options only when one of them is giftcard option.

CREATE TABLE Payment (
  PaymentID VARCHAR(8) NOT NULL,
  OrderID VARCHAR(8) NOT NULL,
  Payment_Type VARCHAR(10) NOT NULL,
  PRIMARY KEY (PaymentID));

CREATE TABLE Payment_Card (
  CardID VARCHAR(8) NOT NULL,
  PaymentID VARCHAR(8) NOT NULL,
  CardNumber VARCHAR(20) NOT NULL,
  CardExpMonth INT NOT NULL,
  CardExpYear INT NOT NULL,
  PRIMARY KEY (PaymentID));


CREATE TABLE Payment_Giftcard (
  GiftcardID VARCHAR(8) NOT NULL,
  PaymentID VARCHAR(8) NOT NULL,
  GiftCardAmount VARCHAR(8) NOT NULL,
  GiftCardNumber VARCHAR(16) NOT NULL,
  GiftcardExpMonth VARCHAR(2) NOT NULL,
  GiftcardExpYear VARCHAR(4) NOT NULL,
  PRIMARY KEY (PaymentID));

ALTER TABLE Buyer ADD CONSTRAINT fk_uid_buyer FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Seller ADD CONSTRAINT fk_uid_seller FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Address ADD CONSTRAINT fk_uid_user_add FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Shopping_Cart ADD CONSTRAINT fk_cart_User FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE WishList ADD CONSTRAINT fk_wishlist_User FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Reviews ADD CONSTRAINT fk_productId FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Orders ADD CONSTRAINT fk_order_UserdID FOREIGN KEY(UserID) REFERENCES User_Table(UserID) on delete cascade;
ALTER TABLE Category ADD CONSTRAINT fk_category_Productid foreign key(ProductID) REFERENCES Product(ProductID) ON DELETE CASCADE;


ALTER TABLE Cart_Product ADD CONSTRAINT fk_cartProduct FOREIGN KEY(ShoppingCartID) REFERENCES Shopping_Cart(ShoppingCartID) on delete cascade;
ALTER TABLE WishList_Product ADD CONSTRAINT fk_wishlistProduct FOREIGN KEY(WishlistID) REFERENCES Wishlist(WishlistID) on delete cascade;

ALTER TABLE Reviews ADD CONSTRAINT fk_reviews_productId FOREIGN KEY(ProductID) REFERENCES Product(ProductID) on delete cascade;
ALTER TABLE Shopping_Cart ADD CONSTRAINT fk_cartProduct1 FOREIGN KEY(ProductID) REFERENCES Product(ProductID) on delete cascade;
ALTER TABLE Order_Product ADD CONSTRAINT fk_Order_Product FOREIGN KEY(ProductID) REFERENCES Product(ProductID) on delete cascade;
ALTER TABLE Offer ADD CONSTRAINT fk_OfferProductID FOREIGN KEY(ProductID) REFERENCES Product(ProductID) on delete cascade;
ALTER TABLE Cart_Product ADD CONSTRAINT fk_cartProduct1 FOREIGN KEY(ProductID) REFERENCES Product(ProductID) on delete cascade;

ALTER TABLE Order_Product ADD CONSTRAINT fk_Order_Product1 FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) on delete cascade;
ALTER TABLE Invoice ADD CONSTRAINT fk_invoice_order FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) on delete cascade;
ALTER TABLE Payment ADD CONSTRAINT fk_invoice__order FOREIGN KEY(OrderID) REFERENCES Orders(OrderID) on delete cascade;

ALTER TABLE Orders ADD CONSTRAINT fk_order_ship FOREIGN KEY(ShipperID) REFERENCES Shipper(ShipperID) on delete cascade;

ALTER TABLE Payment_Card ADD CONSTRAINT fk_card_payment FOREIGN KEY(PaymentID) REFERENCES Payment(PaymentID) on delete cascade;
ALTER TABLE Payment_Giftcard ADD CONSTRAINT fk_giftcard_payment FOREIGN KEY(PaymentID) REFERENCES Payment(PaymentID) on delete cascade;

ALTER TABLE Product ADD CONSTRAINT fk_product_seller FOREIGN KEY(SellerID) references Seller(SellerID) on delete cascade;

ALTER TABLE Category ADD CONSTRAINT fk_parent_category FOREIGN KEY(CategoryID) REFERENCES ParentCategory(CategoryID) on delete cascade;
select * from ParentCategory;
