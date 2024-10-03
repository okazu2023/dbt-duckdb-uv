{{ config(tags = ["sample"]) }}

select
    *
from
    {{ source('data_lake_raw', 'titanic3') }}
