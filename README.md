# zoomcamp_ny_taxi

## Breakdown of dbt folders

### analysis
- A place for sql files that you don twant others to see
- Use it to support data quality reports
- Not used often

### dbt_project.yml
- most important file in dbt
- setup defaults and variables
- everytime you run dbt command it looks here
- make sure profile and name matches
- can also set table or views
- For dbt core your profile must mach the one in the .dbt/profiles.yml

### macros
- to stop repetition
- behave like python functions (reusable logic)
- conversions could be an exampe (normal calendar to fiscal calendar), or tax rates
- Run the macro in the sql file
- Encapsulate logic in one place
- Can be tested

### Readme
- documentation of dbt_project
- installation/setup guides
- contact info

### seeds
- not everyone uses it
- ingest data into database, but not ready to creeate a table and just want to experiement and can upload a csv file
- Quick and dirtz approach, better to fix at source
- dont use unless needed

### snaopshots ::file
- picture of a table at a certain moment of time
- can tell it what table has at that point when you take the snaopshot
- Useful to track history of columns that overwrite themselves

### tests
- can run tests on models in sql format
- use dbt test (automatically runs in dbt build)
- can test for null values or missing data
- A place for singular tests

### models
- sql logic
- break into 3 steps:
    - staging
        - sql sources (raw table from database)
        - Staging files are 1 to 1 copy of your data with minimal cleaning steps
            - data types
            - rename columns
    - intermediate
        - not quite raw data but also not something you want to expose yet
        - complecated joins and queries
        - no guidelines just nice for heavy duty cleaning and complex logic
    - marts
        - Data that will be exposed to end user
        - Ready for consumption
        - Only expose Marts tables
        - Tables ready for dashboards
        - Properly modelled and cleaned tables (can be star scheme)

