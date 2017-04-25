/* 
/*
An important feature of the Progress database is Bracketing...

not only is it important to know how it works for design and development purposes.

Any selection that you write in your code... Progress's system will work to create
bracketing... which is - 
*** get the smallest possible index subset ***

so that we get the smallest possible number of records. Bracketing happens 
naturally but good design of selection query will help the brackets work properly. 

There are some simple rules for making it work: 

* Bracket on active equality matches
* Bracket an active range match, but no further brackets are possible for that index.

The following table provides some bracketing examples:

*/

WHERE Contact = "DLC" 
 AND (Sales-Rep BEGINS "S"
   OR Sales-Rep BEGINS "B")
/* Just uses the Cust-Num Index */


WHERE Postal-Code >= "01000" 
 AND City = "Boston"
/* Uses the Cust-Num Index */

WHERE Name = "Harrison" 
 AND Sales-Rep BEGINS "S" 
/* Uses the Name Index */

WHERE Contact = "DLC" 
 AND Sales-Rep BEGINS "S" 
/* Sales-Rep
Sales-Rep 

WHERE Country BEGINS "EC"
 AND Sales-Rep BEGINS "S"
 BY Country 
Country-Post
Country-Post

WHERE Comments CONTAINS "big"   AND Country = "USA" 
 AND Postal-Code = "01730"  
Comments Country-Post
Country Postal-Code

/*

The following recommendations are intended to help you maximize query performance. 
They are only recommendations, and you can choose to ignore one or more of them 
in specific circumstances:
*Avoid joining range matches with AND.
*Avoid ORs if any expression on either side of the OR does not use an index 
(or all its components). Be aware that the AVM must scan all records using the 
primary index.
*With word indexes, avoid using AND with two wild card strings, either in the same 
word index (WHERE comments CONTAINS “fast* & grow*”) or in separate word indexes 
(WHERE comments CONTAINS “fast*” AND report CONTAINS “ris*”).
*Avoid WHERE clauses that OR a word index reference and a non-indexed criterion 
(WHERE comments CONTAINS “computer” OR address2 = “Bedford”).
*/
