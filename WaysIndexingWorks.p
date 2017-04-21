/* 
Here we are discussing what's happening in certain scenarios and queries... basically
it's an opportunity to learn and become better at utilizing indexes.

We start with the simplest and most obvious find... an equality match returning
either 1 record or nothing...

when a search is done, using equality matches, on an unique index is unique:

you will get the exact record you've asked for... let's say we have an index:

   INDEX CustIDCtry that is PRIMARY and UNIQUE containing fields
   
       CustID   *** and  *** 
       CustCountry
*/


/* Find Customer for Input Cust Num */
FIND FIRST Customer NO-LOCK WHERE
   Customer.CustID = vInputCustID AND 
   Customer.CustCountry = "AUS" 
   NO-ERROR.
   
IF AVAIL Customer THEN
  /* Process Customer Info.... 
     ...
     */
END. 


/* 
When we have more fields the way Progress works is, it will use the index with the most 
** active equality matches. *** 

by active we are saying both these conditions are true: 

• the fields are the leading index components and successive...

• the logic in the query uses ANDs to join (not ORs or NOTs)

for example, say we have the same Customer table with
    indexes for Country, Postal Code
    
    also an index on Status, Country, Name 
    
    and one for Name 
        
****     
This selection Query will use the Country, Postcode Index Only 
*/
FOR EACH Customer NO-LOCK WHERE 
   Customer.Country     = "AUS" AND 
   Customer.Postal-Code > "3000" AND 
   Customer.Status BEGINS "S":   

/* 
This selection will find records using the Name Index which DOES NOT
have Status in it.
*/
FOR EACH Customer NO-LOCK WHERE 
   Customer.Name = "Smith" AND 
   Customer.Status BEGINS "S":
   
/*
This selection will find records using the Name Index... and nothing else.  
*/
FOR EACH Customer NO-LOCK WHERE 
   Customer.Name = "Smith" AND 
   (Customer.Country = "USA" OR Customer.Country = "UK"):
 
 
