Insert into SW.Location Values
    ('000021', '6000');
Insert into SW.Employee Values
    ('000321', 'Smith', 'Eric', 'Sales', '5554443333', 'ericsmith@gmail.com',
    '123 Nightingale Lane', 'S', 0, 0, 0, '2000-08-01', 'S', NULL, '000021');
Insert into SW.Employee Values
    ('004321', 'Anderson', 'Tina', 'Information Technology', '1111111111',
    'tina@gmail.com', '321 Daytime Road', 'D', 0, 0, 0, '1962-06-22',
    'H', '000321', '000021');
Insert into SW.Employee Values
    ('054321', 'Chubb', 'Nick', 'Accounting', '2222222222', 'nchubb@browns.com',
    '333 Browns Drive', 'S', 0, 0, 0, '1998-02-17', 'C', '000321', '000021');
Insert into SW.Customer Values
    ('000333', 'Doe', 'John', '9998887777', '66 Example Road', 'johndoe@yahoo.com',
    '1998-02-02', '6000', 'N');
Insert into SW.Department Values
    ('000021', 'Sales');
Insert into SW.Sales Values
    ('000021', '6000', 7.25);
Insert into SW.Warehouse Values
    ('9999', '000021');
Insert into SW.Hourly Values
    ('004321', 22.50, 40, 10, 30.00);
Insert into SW.Salary Values
    ('000321', 15000);
Insert into SW.Comission Values
    ('054321', 0.2675, 70000);
Insert into SW.Complaint Values
    ('000000009', 'Call', 'Order Not Filled on Time', '000333');
Insert into SW.Discount Values
    ('0404', '0.1500', '000000009');
Insert into SW.Sales_Order Values
    ('888888', '2021-07-28', 'Y', '000321', '000333');
Insert into SW.Survey Values
    ('777777', 7, 9, 2, '054321', '000333');
Insert into SW.Invoice Values
    ('777777', '2021-07-09', 32.45, '000333', '888888');
Insert into SW.Product Values
    ('111111111', 'Baker Mayfield Jersey', 2);
Insert into SW.Steps Values
    ('111111111', 1, 60, '054321');
Insert into SW.Steps Values
    ('111111111', 2, 120, '004321');
Insert into SW.Routing_Sheet Values
    ('5555', '111111111', 180);
Insert into SW.Part Values
    ('222222222', 10);
Insert into SW.Bill_Of_Materials Values
    ('222222222', '111111111', 5);
Insert into SW.Parts_On_Hand Values
    ('9999', '000021', 25, '222222222');
Insert into SW.Manufacturer Values
    ('234432', 'John Deere', '1231234444', 'johndeere@johndeere.com');
Insert into SW.Parts_Manufactured Values
    ('234432', '222222222', 100.50);
