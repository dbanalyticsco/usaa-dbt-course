{% snapshot customers_snapshot %}

{{
    config(
      target_database='analytics',
      target_schema='snapshots_prod',
      unique_key='id',

      strategy='check',
      check_cols = 'all',
    )
}}

select * from {{ source('ecomm', 'customers') }}

{% endsnapshot %}