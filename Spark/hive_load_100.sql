insert into customer select * from customer_100_ext ;
insert into lineitem select * from lineitem_100_ext ;
insert into nation   select * from nation_100_ext   ;
insert into orders   select * from orders_100_ext   ;
insert into part     select * from part_100_ext     ;
insert into partsupp select * from partsupp_100_ext ;
insert into region   select * from region_100_ext   ;
insert into supplier select * from supplier_100_ext ;

analyze table customer COMPUTE STATISTICS;
analyze table lineitem COMPUTE STATISTICS;
analyze table nation   COMPUTE STATISTICS;
analyze table orders   COMPUTE STATISTICS;
analyze table part     COMPUTE STATISTICS;
analyze table partsupp COMPUTE STATISTICS;
analyze table region   COMPUTE STATISTICS;
analyze table supplier COMPUTE STATISTICS;
