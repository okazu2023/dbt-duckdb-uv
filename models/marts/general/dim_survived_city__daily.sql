{{ config(tags = ["sample"]) }}

select
    count(*) as num,
    embarked
from
    {{ ref('int_titanic_filter') }}
group by
    embarked
