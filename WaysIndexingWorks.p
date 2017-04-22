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
 
/*
Now let's look at more complex selections... 

When you have selection on a WHERE clause when there is a 

      ( search expression )  AND ( search expression )
      
the Progress OpenEdge ABL builds a logic tree and then evaluates the index usage on 
either side of the AND... but here is the important thing...

*** for a FOR EACH statement, if you have both sides of the AND selection... 
where there is equality matches on all components of non-unique indexes then
both indexes are used.

When a selection uses a FIND, with an AND statement...
If both sides of the AND are equality matches on indexed fields, 
*** ONLY a single index is used. ***

*** Note: a word index expression with a simple string is an equality match; 
a wild card string constitutes a range match, so a:
*/

WHERE Customer.Name = "John" AND 
      Customer.Sales-Rep = "Smith"
/* the indexes used would be BOTH Name Sales-Rep */

WHERE Comments CONTAINS "Area" 
  AND Country = "AUS" 
  AND Postal-Code = "3000" 

/* When Progress uses multiple indexes from a selection the returned records 
order is unpredictable. 
You can use the USE-INDEX or BY options to guarantee record return order.

In the following example, the BY clause guarantees records are sorted by Cust-Num:
*/

WHERE Customer.Country = "AUS" 
 AND Customer.Sales-Rep = "Smith"
 BY Cust-Num
/*
This search uses the Sales-Rep Index
*/
