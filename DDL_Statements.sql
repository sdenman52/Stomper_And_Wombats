Create Schema SW; -- Stomper & Wombats

Create Table SW.Customer
(   Customer_ID  char(6)        Not Null,
    Last_name    varChar(30)    Not Null,
    First_name   varChar(20)    Not Null,
    Phone_num    char(10)       Not Null,
    Address      varChar(30)    Not Null,
    Email        varChar(25)    Not Null,
    Birthday     date           Not Null,
    Region_code  char(4)        Not Null, 
    Tax_Exempt   char(1)        Default 'N',
    Unique (Email, Phone_num),
    Check (Tax_Exempt = 'N' or 'Y'),
    Primary Key (Customer_ID));
    
Create Table SW.Location
(   Location_ID    char(6)    Not Null,
    Region         char(4)    Not Null,
    Primary Key (Location_ID)); -- Is this the code of the actual region? Foriegn Key?  
    
Create Table SW.Department
(   Location_ID    char(6)        Not Null,
    Department     varChar(25)    Not Null,
    Primary Key (Location_ID),
    Foreign Key (Location_ID) References SW.Location (Location_ID) on delete cascade);
    
Create Table SW.Sales
(   Location_ID    char(6)         Not Null,
    Region         char(4)         Not Null,
    Tax_Rate       double (4,2)    Not Null,
    Primary Key (Location_ID),
    Foreign Key (Location_ID) References SW.Location (Location_ID) on delete cascade);
    
Create Table SW.Warehouse
(   Warehouse_Num    char(4)    Not Null,
    Location_ID      char(6)    Not Null,
    Primary Key (Warehouse_Num, Location_ID),
    Foreign Key (Location_ID) References SW.Location (Location_ID) on delete cascade);

Create Table SW.Employee
(   Employee_Num            char(6)        Not Null,
    Last_name               varChar(30)    Not Null,
    First_name              varChar(20)    Not Null,
    Department              varChar(25)    Not Null,
    Phone_num               char(10)       Not Null,
    Email                   varChar(25)    Not Null,
    Address                 varChar(30)    Not Null,
    Marital_Status          char(1)        Default 'S',
    Dependents              int(3)         Default 0,
    Exemptions_Claimed      int(3)         Default 0,
    Extra_Withholdings      int(7)         Default 0,
    Birthday                date           Not Null,
    EmployeeType            char(1)        Not Null,
    SupervisorID            char(6),  
    Location_ID             char(6)        Not Null,
    Unique (Email, Phone_num),
    Check (Marital_Status in ('S', 'M', 'D', 'W')), 
	Check (Department in ('Executive', 'Accounting', 'Assembly', 'Engineering', 'Information Technology',
                          'Inventory', 'Maintenence', 'Marketing', 'Payroll', 'Purchasing', 'Sales',
                          'Security', 'Strategy')), -- Add constraint to make sure department exists at location
	Check (EmployeeType in ('S', 'H', 'C')),
    Primary Key (Employee_Num),
    Foreign Key (SupervisorID) references SW.Employee (Employee_Num) on delete set null,
    Foreign Key (Location_ID) references SW.Location (Location_ID) on delete cascade); -- Date Constraint
    
Create Table SW.Hourly
(   Employee_Num         char(6)    Not Null,
    Hourly_Rate          double (5, 2)    Not Null,
    Expected_Hours       int(2)     Default 40,
    Overtime_Hours       int(2)     Default 0,
    Shift_Differential   int(2),  -- Not Sure what this is
	Check (Hourly_Rate > 0),
    Primary Key (Employee_Num),
    Foreign Key (Employee_Num) References SW.Employee (Employee_Num) on delete cascade);

Create Table SW.Salary
(   Employee_Num    char(6)        Not Null,
    Monthly_Pay     double(7,2)    Not Null,
    Check (Monthly_Pay > 0),
    Primary Key (Employee_Num),
    Foreign Key (Employee_Num) References SW.Employee (Employee_Num) on delete cascade);

Create Table SW.Comission
(   Employee_Num                     char(6)          Not Null,
    Commission_Percentage_Decimal    double(5, 4)     Not Null,
    Last_Month_Sales                 double(8, 2)     Not Null,
    Check (Commission_Percentage_Decimal > 0 And Commission_Percentage_Decimal < 1),
    Primary Key (Employee_Num),
    Foreign Key (Employee_Num) References SW.Employee (Employee_Num) on delete cascade);

Create Table SW.Complaint
(   Complaint_num    char(9)       Not Null,
    Complaint_type   varChar(5)    Not Null,
    Complaint        varChar(500)  Not Null,
    Customer         char(6)       Not Null,
    Check (Complaint_type in ('Call', 'Email')),
    Primary Key (Complaint_Num),
    Foreign Key (Customer) References SW.Customer (Customer_ID) on delete cascade);
    
Create Table SW.Discount
(   Discount_num     char(4)         Not Null,
    Rate             double(3, 2)    Not Null,
    From_Complaint   char(9)         Not Null,
    Check (Rate < 1),
    Primary Key (Discount_Num),
    Foreign Key (From_Complaint) References SW.Complaint (Complaint_Num) on delete cascade);
    
Create Table SW.Sales_Order
(   Order_Num      char(6)    Not Null,
    Review_Date    date,
	Approved       char(1)    Default 'N',
    Reviewer       char(6),
    Customer       char(6),
    Check (Approved in ('Y', 'N')),
    Primary Key (Order_Num),
    Foreign Key (Reviewer) References SW.Employee (Employee_Num) on delete set null,
    Foreign Key (Customer) References SW.Customer (Customer_ID) on delete set null);
    
Create Table SW.Survey
(   Survey_Num        char(6)    Not Null,
    Employee_Score    int(2)     Default 5,
    Quality_Score     int(2)     Default 5,
    Accuracy_Score    int(2)     Default 5,
    Employee          char(6)    Not Null,
    Customer          char(6)    Not Null,
    Check (Employee_Score <= 10 And Quality_Score <= 10 And Accuracy_Score <= 10),
    Check (Employee_Score >= 0 And Quality_Score >= 0 And Accuracy_Score >= 0),
    Primary Key (Survey_Num),
    Foreign Key (Employee) References SW.Employee (Employee_Num) on delete cascade,
    Foreign Key (Customer) References SW.Customer (Customer_ID) on delete cascade);
    
Create Table SW.Invoice
(   Invoice_Num      char(6)          Not Null,
    Sent_Date        date             Not Null,
    Shipping_Cost    double (6, 2)    Not Null,
    Customer_ID      char(6)          Not Null,
    Primary Key (Invoice_Num),
    Foreign Key (Customer_ID) References SW.Customer (Customer_ID) on delete cascade);
    
 Create Table SW.Product
(   Product_Num     char(9)        Not Null,
    Product_Name    varChar(30)    Not Null,
    Steps           int(2)         Not Null,
    Unique (Product_Name),
    Primary Key (Product_Num));   
    
Create Table SW.Sent_Products
(   Invoice_Num    char(6)         Not Null,
    Product_Num    char(9)         Not Null,
    Quantity       int(4)          Not Null,
    Price_Per      double(6, 2)    Not Null,
    Primary Key (Invoice_Num, Product_Num),
    Foreign Key (Invoice_Num) References SW.Invoice (Invoice_Num) on delete cascade,
    Foreign Key (Product_Num) References SW.Product (Product_Num) on delete cascade);
    
Create Table SW.Steps
(   Product_Num             char(9)    Not Null,
    Step_Number             int(2)     Not Null,
    Estimated_Time_Mins     int(3)     Not Null,   -- In Minutes
    Employee                char(6)    Not Null,
    Primary Key (Product_Num, Step_Number),
    Foreign Key (Product_Num) References SW.Product (Product_Num) on delete cascade,
    Foreign Key (Employee) References SW.Employee (Employee_Num) on delete cascade);
    
Create Table SW.Routing_Sheet
(   Routing_Sheet_ID        char(4)    Not Null,
    Product_Num             char(9)    Not Null,
    Estimated_Time_Mins     int(3),
    Primary Key (Routing_Sheet_ID, Product_Num),
    Foreign Key (Product_Num) References SW.Product (Product_Num) on delete cascade);
    
Create Table SW.Part
(   Part_Num         char(9)    Not Null,
    Reorder_point    int(6)     Not Null,
    Primary Key (Part_Num));
    
Create Table SW.Bill_Of_Materials
(   Part_Num           char(9)    Not Null,
    Product_Num        char(9)    Not Null,
	Quantity_Needed    int(6)     Not Null,
    Primary Key (Part_Num, Product_Num),
    Foreign Key (Part_Num) References SW.Part (Part_Num) on delete cascade,
    Foreign Key (Product_Num) References SW.Product (Product_Num) on delete cascade);
    
Create Table SW.Parts_On_Hand
(   Warehouse_Num    char(4)    Not Null,
    Location_ID      char(6)    Not Null,
    Quantity         int(6)     Not Null,
    Part_Num         char(9)    Not Null,
    Primary Key (Warehouse_Num, Location_ID, Part_Num),
    Foreign Key (Warehouse_Num, Location_ID) references SW.Warehouse (Warehouse_Num, Location_ID) on delete cascade,
    Foreign Key (Part_Num) References SW.Part (Part_Num) on delete cascade);
    
Create Table SW.Manufacturer
(   Manufacturer_ID      char(6)        Not Null,
    Manufacturer_Name    varChar(50)    Not Null,
    Phone_Num            char(10)       Not Null,
    Email                varChar(25)    Not Null,
    Primary Key (Manufacturer_ID));
    
Create Table SW.Parts_Manufactured
(   Manufacturer    char(6)          Not Null,
    Part            char(9)          Not Null,
    Price           double (8, 2)    Not Null,
    Primary Key (Manufacturer, Part),
    Foreign Key (Manufacturer) References SW.Manufacturer (Manufacturer_ID) on delete cascade,
    Foreign Key (Part) References SW.Part (Part_Num) on delete cascade);

                          
    