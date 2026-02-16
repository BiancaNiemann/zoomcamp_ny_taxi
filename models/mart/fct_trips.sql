{{
    config(
        materialized = 'incremental',
        unique_key = 'trip_id',
        on_schema_change = 'fail'
    )
}}

-- Fact table containing all taxi trips enriched with zone information
-- This is a classic star schema design: fact table (trips) joined to dimension table (zones)
-- Materialized incrementally to handle large datasets efficiently

select
    -- Tip Identifiers
    t.trip_id,
    t.vendor_id,
    t.service_type,
    t.rate_code_id,

    -- Location details
    t.pickup_location_id,
    pickup_zone.borough as pickup_borough,
    pickup_zone.zone as pickup_zone,
    t.dropoff_location_id,
    dropoff_zone.borough as dropoff_borough,
    dropoff_zone.zone as dropoff_zone,

    -- Trip timing
    t.passenger_count,
    t.trip_distance,
    t.trip_type,
    {{ get_trip_duration_minutes('t.pickup_datetime', 't.dropoff_datetime')}} as trip_duration_minutes,

    -- Payment breakdown
    t.fare_amount,
    t.extra,
    t.mta_tax,
    t.tip_amount,
    t.tolls_amount,
    t.ehail_fee,
    t.improvement_surcharge,
    t.total_amount,
    t.payment_type,
    t.payment_type_description

from {{ ref('int_trips')}} as t
