### App Trader

You have been hired by a new company called App Trader to help them explore and gain insights from apps that are made available through the Apple App Store and Android Play Store. App Trader will serve as a broker buying apps from developers then deploying and marketing them. 

#### Loading the data
- Launch PgAdmin and create a new database called app_trader
- Right-click on the app_trader database and choose `Restore...`
- Use the default values under the `Restore Options` tab
- In the `Filename` section, browse to the backup file `app_store_backup.backup` in the data folder of this repository
- Click `Restore` to load the database 
- Verify that you have two tables:
    - `app_store_apps` with 7197 rows
    - `play_store_apps` with 10840 rows


#### Assumptions
Based on research done before launching App Trader as a company, you can assume the following:
- App Trader will purchase apps for 10,000 times the price of the app
- Apps earn $5000 per month on average from in-app advertising and in-app purchases _regardless_ of the price of the app
- App Trader will spend an average of $1000 per month to market an app _regardless_ of the price of the app
- For every half point that an app gains in rating, its projected lifespan increases by one year, in other words, an app with a rating of 0 can be expected to be in use for 1 year, an app with a rating of 1.0 can be expected to last 3 years, and an app with a rating of 4.0 can be expected to last 9 years. Ratings should be rounded to the nearest 0.5 to evaluated its likely longevity.
- App Trader would prefer to work with apps that are available in both the App Store and the Play Store. 

#### Deliverables
- Develop some general recommendations as to price range, genre, content_rating for apps that the company should target.
- Develop a Top 10 List of the apps that App Trader should buy next week for its **Black Friday** debut.
- Prepare a 5-10 minute presentation for the leadership team of App Trader.



### All analysis work must be done in PostgreSQL