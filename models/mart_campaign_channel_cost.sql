{{ config(
    materialized='table'
) }}

SELECT
      CHANNEL

    , SUM(
        (DATEDIFF(day, START_DATE, END_DATE) + 1)
        * COALESCE(
            CASE CHANNEL
                WHEN 'Paid Search' THEN 500
                WHEN 'Display'     THEN 300
                WHEN 'Social'      THEN 400
                WHEN 'Email'       THEN 50
                WHEN 'Influencer'  THEN 800
                WHEN 'Video'       THEN 600
                WHEN 'Mobile'      THEN 350
            END
        , 250)
      ) AS TOTAL_COST

FROM {{ source('marketing','P_CAMPAIGNS') }}

GROUP BY CHANNEL
ORDER BY TOTAL_COST DESC
