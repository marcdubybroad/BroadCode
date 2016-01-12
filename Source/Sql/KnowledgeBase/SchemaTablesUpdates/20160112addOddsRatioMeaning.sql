
-- add odds_ration meaning to OR properties; avoid OR_TRUST property
update PROP set meaning = 'ODDS_RATIO' where lower(PROP) like 'or%' and PROP != 'OR_TRUST';

-- add beta to BETA property
update PROP set meaning = 'BETA' where lower(PROP) like 'be%';

