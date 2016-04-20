

-- select last day of rowing related workout


-- select sum of long od workouts



-- select sum of rowing related workouts
select count(workout.workout_id), sum(activity.row) + sum(activity.row), period.name_text
from wkt_workout workout, wkt_activity activity, wkt_day wday, wkt_week week, wkt_period period, wkt_year wyear
where workout.day_id = wday.day_id
    and activity.workout_id = workout.workout_id
    and wday.week_id = week.week_id
    and week.period_id = period.period_id
    and period.year_id = wyear.year_id
    and wyear.name in (1994, 2002, 2013, 2015, 2016)
    and period.name in (7, 8, 9, 10)
    and (activity.row > 0 or activity.erg > 0)
group by period.name_text
order by wyear.name, period.period_id;


