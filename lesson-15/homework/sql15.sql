--Homework 15
go

--Find 3 successive empty seats
create table #EmptySeats(Number int, Empty varchar(1))

insert into #EmptySeats values (1, 'Y'), (2, 'N'), (3, 'N'), (4, 'Y'), (5, 'Y'), (6, 'Y'), (7, 'N'),
(8, 'Y'), (9, 'Y'), (10, 'Y'), (11, 'N'), (12, '')

select * from #EmptySeats

--Find 3 successive empty seats

with rcte as(
select *, lead(empty) over (order by number) prv, lead(empty,2) over (order by number) nxt from #EmptySeats)
select concat(number, ' - ', number +1, ' - ', number+2)from rcte
where rcte.empty='Y' and rcte.prv='Y' and rcte.nxt='Y'



