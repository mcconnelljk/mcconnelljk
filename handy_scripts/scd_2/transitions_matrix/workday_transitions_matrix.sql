-- noqa: disable=all

CREATE OR REPLACE TEMP VIEW workday_transitions_matrix AS (
with workday_sectors as (
    select
        distinct meta_source_date as snapshot_date 
        ,employee_id
        ,account_group
        ,group_name
        ,domain
    from bah_uad.etl_workday.clean_workday_users
    where 1=1
        and employee_status_code = 'A'
        and account_group is not null
        and extract(day from meta_source_date) = 1 -- we don't want aggregates of all users within the month in case alignment changes occur in the middle of the month
), date_range as (
    select * 
    from (
        select 
            distinct snapshot_date as date_current
            ,lead(snapshot_date) over (order by snapshot_date desc) AS date_previous
        from workday_sectors
        group by snapshot_date
    ) t
    where date_previous is not null
),prev_snapshot as (
    select *
    from workday_sectors
    where snapshot_date in (select date_previous from date_range)
),cur_prev_user_map as (
    select
        d.date_current
        ,d.date_previous
        ,cur.employee_id
        ,cur.account_group as account_current
        ,cur.group_name as group_current
        ,cur.domain as domain_current
        ,prev.account_group as account_previous
        ,prev.group_name as group_previous
        ,prev.domain as domain_previous
    from date_range d
    join workday_sectors cur 
        on cur.snapshot_date = d.date_current
    join prev_snapshot prev
        on prev.snapshot_date = d.date_previous
        and prev.employee_id = cur.employee_id
), total_user_counts as (
    select
        date_current
        ,COUNT(DISTINCT employee_id) as user_count
        ,account_current
        ,group_current
        ,domain_current
    from cur_prev_user_map
    group by date_current
        ,account_current
        ,group_current
        ,domain_current
), new_account_start as (
    select
        distinct account_current
        ,group_current
        ,domain_current
        ,min(date_current) as date_first
    from cur_prev_user_map
    group by account_current
        ,group_current
        ,domain_current
), cur_prev_user_counts as (
    select
        c.date_current
        ,c.date_previous
        ,COUNT(DISTINCT c.employee_id) as user_count
        ,max(t.user_count) as total_count
        ,COUNT(DISTINCT c.employee_id)/max(t.user_count) as user_ratio
        ,c.account_current
        ,c.group_current
        ,c.domain_current
        ,c.account_previous
        ,c.group_previous
        ,c.domain_previous
    from cur_prev_user_map c
    join total_user_counts t
    on c.date_previous = t.date_current
        and c.account_previous = t.account_current
        and c.group_previous = t.group_current
        and c.domain_previous = t.domain_current
    group by c.date_current
        ,c.date_previous
        ,c.account_current
        ,c.group_current
        ,c.domain_current
        ,c.account_previous
        ,c.group_previous
        ,c.domain_previous
), ranked as (
    SELECT
    *
    ,row_number() over( partition by date_current, account_current, group_current, domain_current order by user_count desc) as rn
    from cur_prev_user_counts
), final_map as (
    select 
        c.date_current
        ,c.user_ratio
        ,c.account_current
        ,c.group_current
        ,c.domain_current
        ,c.date_previous
        ,c.account_previous
        ,c.group_previous
        ,c.domain_previous
        ,row_number() over( partition by c.date_current, c.account_previous, c.group_previous, c.domain_previous order by c.user_ratio desc) as rn
    from cur_prev_user_counts c
    left join ranked r on r.date_current = c.date_current
        and r.account_current = c.account_current
    where 1=1 
        and r.rn = 1
        and c.user_ratio > 0.1
    order by c.date_current desc
)
select * 
from final_map
where 1=1
    --and date_current = '2025-04-01'
order by date_current desc, user_ratio desc, account_previous
);