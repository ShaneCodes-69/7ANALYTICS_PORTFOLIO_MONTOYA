use project;



create table  calls(
	ID char(50),
    cust_name char(50),
    sentiment char(20),
    csat_score int,
    call_timestamp char(10),
    reason char(20),
    city char(20),
    state char(20),
    channel char(20),
    response_time char(20),
    call_duration_minutes int,
    call_center char(20)
);

select * from calls LIMIT 10;

set SQL_SAFE_UPDATES = 0;

UPDATE calls
SET call_timestamp = str_to_date(call_timestamp, "%m/%d/%y");

ALTER TABLE calls
MODIFY call_timestamp DATE;

set SQL_SAFE_UPDATES = 1;

select * from calls LIMIT 10;





set SQL_SAFE_UPDATES = 0;

UPDATE calls SET csat_score = NULL where csat_score = 0;

set SQL_SAFE_UPDATES = 1;

select * from calls LIMIT 10;




SELECT count(*) as row_num FROM calls;
select count(*) as cols_num FROM information_schema.columns where table_name = 'calls';


select distinct sentiment from calls;
select distinct reason from calls;
select distinct channel from calls;
select distinct call_center from calls;


select sentiment, count(*), round((count(*) / (select count(*) from calls)) * 100,1) as pct from calls group by 1 order by 3 desc;
select reason, count(*), round((count(*) / (select count(*) from calls)) * 100,1) as pct from calls group by 1 order by 3 desc;
select channel, count(*), round((count(*) / (select count(*) from calls)) * 100,1) as pct from calls group by 1 order by 3 desc;
select response_time, count(*), round((count(*) / (select count(*) from calls)) * 100,1) as pct from calls group by 1 order by 3 desc;
select call_center, count(*), round((count(*) / (select count(*) from calls)) * 100,1) as pct from calls group by 1 order by 3 desc;
select state , count(*) from calls group by 1 order by 2 desc;


select dayname(call_timestamp) as day_of_call, count(*) num_of_calls from calls group by 1 order by 2 desc;



select min(csat_score) as min_score, max(csat_score) as max_score, round(AVG(csat_score),1) as avg_score from calls where csat_score !=0; 

select min(call_timestamp) as earliest_date, max(call_timestamp) as most_recent from calls;

select min(call_duration_minutes) as min_call_duration, max(call_duration_minutes) as max_call_duration, avg(call_duration_minutes) as avg_call_duration from calls;

select call_center, response_time,  count(*) as count from calls group by 1,2 order by 1,3 desc;

select call_center, avg(call_duration_minutes) from calls group by 1 order by 2 desc;

select channel, avg(call_duration_minutes) from calls group by 1 order by 2 desc;

select state, count(*) from calls group by 1 order by 2 desc;

select state, reason, count(*) from calls group by 1,2 order by 1,2,3 desc;

select state, sentiment, count(*) from calls group by 1,2 order by 1,3 desc;

select state, AVG(csat_score) as avg_score from calls where csat_score !=0 group by 1 order by 2 desc;

select sentiment, AVG(call_duration_minutes) from calls group by 1 order by 2 desc;





select call_center, response_time, count(*) as count from calls group by 1,2 order by 1,3 desc;



select call_timestamp, max(call_duration_minutes) over(partition by call_timestamp) as max_call_duration from calls group by 1 order by 2 desc;