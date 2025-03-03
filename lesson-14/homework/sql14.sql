go
use W3Resource
go


--Homework for recursive cte. Find the hierarchial level of people

create table PostDef(postid int, definition varchar(25))
insert into PostDef values (0, 'Director'), (1, 'Deputy Director'), (2, 'Executive Director'), (3, 'Department head'), 
              (4, 'Manager'), (5, 'Senior officer'), (6, 'Junior Officer'), (7, 'Intern')

			  create table Hierarchy(id int, name varchar(100), manager_id int, manager varchar(100))

insert into Hierarchy values 
(150, 'John Ryden', 111, 'Jack Tarkowski'),
(165, 'Sara Miller', 111, 'Jack Tarkowski'), 
(180, 'Rebecca Carson', 211, 'Thomas Kim'), 
(107, 'Sean Sullivan', 180, 'Rebecca Carson'), 
(142, 'Floyd Kan', 122, 'Alex Pereira'), 
(122, 'Alex Pereira', 107, 'Sean Sullivan'), 
(111, 'Jack Tarkowski', 107, 'Sean Sullivan'), 
(211, 'Thomas Kim', 191, 'Nicolas Jackson'), 
(177, 'Michael Rim', Null, Null), 
(191, 'Nicolas Jackson', 177, 'Michael Rim')



select * from postdef
;
with cte as(
select *, 0 as strt from Hierarchy where manager_id is null
union all
select h.*, strt+1 from Hierarchy h join cte on h.manager_id = cte.id)
select id, name, definition from cte join postdef on cte.strt = postdef.postid


--1
select * from Movies.Actor
where act_id =(select act_id from  Movies.Movie_cast
where mov_id=(select mov_id from Movies.Movie where mov_title='Annie Hall'))

--2

select  dir_fname, dir_lname from Movies.Director
where dir_id  in (select  dir_id from Movies.Movie_Direction
where mov_id in (
select mov_id from Movies.Movie_cast
where mov_id in (
select mov_id from Movies.Movie
where mov_title='Eyes Wide Shut'
  )
 )
);

--3
select mov_title, mov_year, mov_time, mov_dt_rel,mov_rel_country  from Movies.Movie
where mov_id  not in (select mov_id from Movies.Movie
where mov_rel_country='UK' )

--4

select m.mov_title, m.Mov_year, m.mov_dt_rel, d.dir_fname, d.dir_lname,a.act_fname,a.act_lname
from Movies.Movie m,Movies.Actor a,Movies.Director d,Movies.Movie_Direction md,Movies.Movie_cast  mc,  Movies.Reviewer rv,
Movies.Rating rt
where m.mov_id=md.mov_id 
and  md.dir_id=d.dir_id
and m.mov_id=mc.mov_id
and mc.act_id=a.act_id
and mc.mov_id=rt.mov_id
and rt.rev_id=rv.rev_id

and rv.rev_name is null;

--5
select  mov_title from Movies.Movie
where mov_id  in (select mov_id from Movies.Movie_Direction
where dir_id in (
select  dir_id from Movies.Director
where  dir_fname='Woody' and dir_lname='Allen'
 )
);
	
--6
select  distinct mov_year from Movies.Movie
where mov_id in(select mov_id from Movies.Rating
where rev_stars >=3)
order by mov_year asc;
--7
select mov_title from Movies.Movie m
left join Movies.Rating r on m.mov_id=r.mov_id
where r.mov_id is null;

--8
select  rev_name from Movies.Reviewer
where rev_id in (select rev_id from Movies.Rating
where rev_stars is null
);
--9
 select  re.rev_name,m.mov_title, rt.rev_stars from Movies.Reviewer re 
inner  join Movies.Rating   rt 
 on re.rev_id=rt.rev_id
 inner join Movies.Movie    m
 on rt.mov_id=m.mov_id
 where rt.rev_stars is not null and re.rev_name is not null
 order by re.rev_name,m.mov_title, rt.rev_stars  
 

--10
select  re.rev_name ,m.mov_title from Movies.Reviewer re,Movies.Rating rt, Movies.Movie m ,Movies.Rating rt2
where re.rev_id=rt.rev_id and
 rt.mov_id=m.mov_id
 and rt.rev_id=rt2.rev_id
and rt.num_o_ratings is not null
and re.rev_name is not null
group by re.rev_name, m.mov_title
having count (*)>1;

--11
select m.mov_title,r.rev_stars from Movies.Movie m, Movies.Rating r
where m.mov_id=r.mov_id
and r.rev_stars is not null
order by m.mov_title
--12
select re.rev_name from Movies.Reviewer re,Movies.Rating rt,Movies.Movie  m
where  re.rev_id=rt.rev_id and
 rt.mov_id=m.mov_id
 and m.mov_title='American Beauty'
 --13
 select m.mov_title from Movies.Reviewer re,Movies.Rating rt,Movies.Movie  m
where  re.rev_id=rt.rev_id and
 rt.mov_id=m.mov_id
 and  re.rev_name <>'Paul Monks'
 order by  m.mov_title asc
 --
 select mov_title from Movies.Movie
 where mov_id in (select mov_id from Movies.Rating
 where rev_id  not in (
 select rev_id from Movies.Reviewer
 where rev_name='Paul Monks')
 )
 --14
 select  re.rev_name, m.mov_title, rt.rev_stars  from Movies.Reviewer re,Movies.Rating rt,Movies.Movie  m
 where
 rt.rev_stars=(select min (rev_stars) from Movies.Rating)
  and re.rev_id=rt.rev_id
  and rt.mov_id=m.mov_id
  
  --15
  select mov_title from Movies.Movie
  where mov_id in (select mov_id from Movies.Movie_Direction
  where dir_id in (
  select dir_id from Movies.Director
  where dir_fname='James' and dir_lname= 'Cameron')
  );
  --16

  select mov_title from Movies.Movie 
  where mov_id in (select mov_id from Movies.Movie_cast
  where act_id in (select act_id from Movies.Movie_cast
  group by act_id 
  having count (*)>1
   )
  );
  
  
 



 