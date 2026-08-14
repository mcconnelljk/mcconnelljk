''' 
This script transforms a table of platform + measures into a slowly changing dimension (type 2).
NOTE: Modified for use within PowerBI.
'''

# 'dataset' holds the input data for this script

import pandas as pd
dataset['first_date'] = pd.to_datetime(dataset['first_date'], errors='coerce').fillna(pd.to_datetime('2021-01-01'))
dataset = dataset.sort_values(by=['platform', 'measure', 'first_date'])

# Create the last date (last day of the previous month)
last_date = pd.to_datetime('today').replace(day=1)
last_date = last_date.replace(hour=23, minute=59, second=59)

distinct_platform_measure = dataset[['platform', 'measure']].drop_duplicates()
distinct_pairs = list(distinct_platform_measure.itertuples(index=False, name=None))

result = []

for platform, measure in distinct_pairs:
    filtered_data = dataset[(dataset['platform'] == platform) & (dataset['measure'] == measure)].reset_index(drop=True)

    # Loop through the rows of filtered data to calculate the end_date
    for i, row in filtered_data.iterrows():
        target_value = row['target_value']
        first_date = row['first_date']
        # If it's not the last row, set the end_date to the first_date of the next row minus 1 day
        if i + 1 < len(filtered_data):
            next_row = filtered_data.iloc[i + 1]
            end_date = next_row['first_date'] - pd.Timedelta(days=1)
        else:
            # If it's the last row (the most recent one), set the end_date to the last day of the previous month
            end_date = last_date
        
        # Append the result (id, platform, measure, target_value, first_date, end_date)
        result.append({
            'platform': platform
            ,'measure': measure
            ,'target_value': target_value
            ,'first_date': first_date.date()
            ,'end_date': end_date.date()       
        })


final_df = pd.DataFrame(result)
