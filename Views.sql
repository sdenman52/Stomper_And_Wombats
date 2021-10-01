create view Sales_Customer_Relations as
	select Customer.Customer_ID, Customer.Last_Name, Customer.First_Name, Sales_Order.Order_Num, Invoice.Invoice_Num, 
    Sent_Products.Product_Num, Sent_Products.Quantity, Sent_Products.Price_Per
		from SW.Customer, SW.Sales_Order, SW.Invoice, SW.Sent_Products
		where Customer.Customer_ID = Sales_Order.Customer And Sales_Order.Order_Num = Invoice.Order_Num
        And Invoice.Invoice_Num = Sent_Products.Invoice_Num;
        
create view Available_Parts as
	select Location_ID, Warehouse_Num, Parts_On_Hand.Part_Num, Quantity, Reorder_Point
		from Parts_On_Hand inner join Part
		on Parts_On_Hand.Part_Num = Part.Part_Num;

create view Accounting as
	select Customer.Customer_ID, Customer.Last_Name, Customer.First_Name, Customer.Address, 
    Sales_Order.Order_Num, Invoice.Invoice_Num, Sent_Products.Product_Num, Sent_Products.Quantity, Sent_Products.Price_Per
		from SW.Customer, SW.Sales_Order, SW.Invoice, SW.Sent_Products
		where Customer.Customer_ID = Sales_Order.Customer And Sales_Order.Order_Num = Invoice.Order_Num
        And Invoice.Invoice_Num = Sent_Products.Invoice_Num;

create view Payroll_Information as
	select Employee.Employee_Num, Last_Name, First_Name, Marital_Status, Dependents, Exemptions_Claimed, 
    Extra_Withholdings, Hourly_Rate, Monthly_Pay, Commission_Percentage_Decimal, Last_Month_Sales
		from SW.Employee, SW.Hourly, SW.Salary, SW.Comission
		where Employee.Employee_Num = Hourly.Employee_Num And Employee.Employee_Num = Salary.Employee_Num And
        Employee.Employee_Num = Comission.Employee_Num;