{{ dbt_utils.date_spine(
    datepart="day",
    start_date="to_date('01/01/2020', 'mm/dd/yyyy')",
    end_date="current_date"
   )
}}