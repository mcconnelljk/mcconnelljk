-- noqa: disable=all

CREATE OR REPLACE TEMP VIEW workday_map AS (
with monthly_map as (
    select distinct * from workday_transitions_matrix
), accounts_grouped as (
    select
        distinct account_previous as account_this
        ,group_previous as group_this
        ,domain_previous as domain_this
        ,min(date_previous) as date_start
        ,max(date_current) as date_end
    from monthly_map
    where rn = 1
    group by account_previous, group_previous, domain_previous
), final_map as (
    select a.*
        ,case when (a.account_this = m.account_current and a.group_this = m.group_current and a.domain_this = m.domain_current) then null else m.account_current end as account_next
        ,case when (a.account_this = m.account_current and a.group_this = m.group_current and a.domain_this = m.domain_current) then null else m.group_current end as group_next
        ,case when(a.account_this = m.account_current and a.group_this = m.group_current and a.domain_this = m.domain_current) then null else m.domain_current end as domain_next
        ,case when (a.account_this = m.account_current and a.group_this = m.group_current and a.domain_this = m.domain_current) then true else false end as is_current
    from accounts_grouped a
    left join monthly_map m
        on a.date_end = m.date_current
        and a.account_this = m.account_previous
        and a.group_this = m.group_previous
        and a.domain_this = m.domain_previous
)
select * from final_map
where 1=1
order by date_start desc
);