/* 
Here we are discussing what's happening in certain scenarios and queries... basically
it's an opportunity to learn and become better at utilizing indexes.

We start with the simplest and most obvious find... an equality match returning
either 1 record or nothing...

when a search is done, using equality matches, on an unique index is unique:

you will get the exact record you've asked for... eg:

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
     
     
     
 
 
