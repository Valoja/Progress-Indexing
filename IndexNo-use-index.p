/* The Progress database has been designed to find the best way to find records using as 
many or as few indexes as it needs... whilst this sounds very clever you still have to 
put much effort to designing of the tables and ensure the code is written in an effective 
manner to find the records as quick as possible.

There is now no need specify the use-index clause as the Progress system will find 
the most effective way to find the records... 

*** providing the code you have written is effective too ***

** The best way to check indexes being used is to
COMPILE using XREF and look at the
XREF output: Progress shows here which index (or indexes) it is using.


*/



