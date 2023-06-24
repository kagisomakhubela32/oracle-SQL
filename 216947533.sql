Name: kagiso
Surname: makhubela
Student number: 216947533
Group: B


I [Makhubela and K.T ( 216947533 )], hereby solemnly declare that, 
this submission is my own work. If found that I have copied someone 
else's work or someone else has done the assignment on my behalf, 
I will receive a mark of 0 (zero) for this assignment


Question 1.

SELECT SUBSTR(FName,1,1)||', '||initcap(Surname) customer, DECODE(CType, 'L', 'Loyal', 'O', 'Ordinary') "cust type",Suburb ,TO_CHAR(JoinDate,’DAY " the " FMddth Month " of " YYYY’) JOINDATE
FROM f_customer
WHERE joindate between '16-DEC-2019' AND '09-JAN-2020'
OR CType = 'L'
ORDER BY CType;

Question 2. 

SELECT ONo,OItem,R.RMItem#,ItemDesc,ItemPrice,Quantity,Quantity*ItemPrice "Total Price"
FROM f_orditem R,f_rmitem O
WHERE R.RMItem#=O.RMItem#
AND OItem IN (102,117)
ORDER BY OItem;

Question 3.

SELECT (initcap(f_customer#.fname))||', a member of '||initcap(d.fname)||', paid order# '||f_order.ono||' (delivered by '||initcap(f_deliveryman.fnames)||') using '||f_paytype.ptdesc "Memebers of OTHER Members"
FROM f_customer f_customer#,f_customer d,f_order ,f_deliveryman ,f_paytype 
WHERE d.memberof=f_customer#.memberof
AND f_customer#.cno=f_order.cno
AND f_deliveryman.dmcellno=f_order.dmcellno
AND f_paytype.ptcode=f_order.ptcode;

Question 4

SELECT INITCAP(f_customer.fname)||' '|| f_customer.surname customer, initcap(f_rmitem.itemdesc)||' @ '||TO_CHAR(f_rmitem.itemprice,'L999.99') "Items at R",TO_CHAR(f_order.odatetime,'Month"," dd yyyy') orderdate, ROUND(MONTHS_BETWEEN(sysdate,f_order.odatetime),1) months
from f_customer , f_order ,f_orditem ,f_rmitem 
WHERE f_customer.cno=f_order.cno
AND f_order.ono=f_orditem.ono
AND f_rmitem.rmitem#=f_orditem.rmitem#
AND ROUND(MONTHS_BETWEEN(sysdate,f_order.odatetime),1) > 24
ORDER BY f_customer.fname;


END OF ASSINGMENT 1.