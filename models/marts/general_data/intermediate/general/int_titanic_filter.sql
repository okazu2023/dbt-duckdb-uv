{{ config(tags = ["sample"]) }}

select
    *
from
    {{ ref('stg_data_lake_raw__raw_titanic3') }}
where
    survived = 1
