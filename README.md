# zoomcamp_ny_taxi
---

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

### snaopshots 
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
---

## tests

### singular tests
- create a simple sql query (if more then one row returned equals error)
- Test to show all 24 hours accounted for

### source freshness tests
- added to the source file
- freshness: null (will not run freshness)
- run it using dbt source freshness

### generic tests
- goes in the schema under tests
- unique 
- not null
- accepted values: values ['placed', 'shipped']
- relationships: to: ref('customers') field:

### Custom generic tests
- create own tests
- save in tests/generic folders

### Unit tests

### Model contracts
- goes in schema.yml file

- some dbt packages have tests already ready to use
---

## packages
- look in dbt package hub or more in github
- dbt_utils most common
- dbt project evaluator will give project a score
- dbt codegen helps with yaml file
- dbt expectations has pre built tests
- add it to your packages.yml
- run dbt deps

---

## dbt packages
- dbt init
- dbt debug (checks yml file)
- dbt seed (ingests all csv in seeds folder)
- dbt snapshot
- dbt source freshness
- dbt docs generate
- dbt docs serve (browse website in local environ only in core)
- dbt clean (will look in tagets in dbt_project file)
- dbt deps
- dbt compile (takes all models and creates target directory in folder compiled and shows what the actual code looks like without jinja)

### Most used commands
- dbt run (runs all tables)
- dbt run --select file_name
- dbt tests (checks all tests ok)
- dbt build (run, seed, snapshot, UDFs and tests together)
- dbt retry (runs from where it failed)

### Flags (optional)
- dbt --help (or -h)
- dbt --version (or -v)
- dbt run --full-refresh (restarts incremental model)
- dbt run --fail-fast
- dbt run --target (or -t)
- dbt run -- select +int_trips_unioned (or plus at end runs all incl file and afterwards)
- dbt run --select state:new (or modified) --state ./put the file dir here
