-- creating temp table for capacity projects for sca_cp_capacity_projects
DROP TABLE IF EXISTS sca_cp_cap_joined_cur;
CREATE TABLE sca_cp_cap_joined_cur AS (
		SELECT a.existingsiteidentified, 
			a.proposedleasedfacility, 
			a.forecastcapacity, 
			a.district, 
			a.school, 
			a.projectnum, 
			'capacity projects'::text AS description, 
			b.location, 
			b.latitude, 
			b.longitude,
			a.actualestcompl, 
			(CASE
    			WHEN (substring(a.actualestcompl, 1, strpos (a.actualestcompl,'-')-1) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') ) THEN substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl))::integer+2001
    			ELSE substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl))::integer+2000
   			END) AS fy,
			a.designstart, 
			a.constrstart, 
			a.totalestcost, 
			a.previousappropriations, 
			a.fundingreqd, 
			a.neededtocomplete,
			'sca_cp_cap_schools_FY2020-24'::text AS source
	FROM sca_cp_cap_schools a
	LEFT JOIN sca_cp_cap_location b
	ON a.school = b.school
	);
-- creating temp table for capacity projects for sca_cp_capacity_projects_prev
DROP TABLE IF EXISTS sca_cp_cap_joined_prev;
CREATE TABLE sca_cp_cap_joined_prev AS (
SELECT a.existingsiteidentified, 
			a.proposedleasedfacility, 
			a.forecastcapacity, 
			a.district, 
			a.school, 
			a.projectnum, 
			'capacity projects'::text AS description, 
			b.location, 
			b.latitude, 
			b.longitude,
			a.actualestcompl, 
			(CASE
    			WHEN (substring(a.actualestcompl, 1, strpos (a.actualestcompl,'-')-1) IN ('Jul','Aug', 'Sep', 'Oct', 'Nov', 'Dec') ) THEN substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl))::integer+2001
    			ELSE substring(a.actualestcompl, strpos(a.actualestcompl,'-')+1, length(a.actualestcompl))::integer+2000
   			END) AS fy,
			a.designstart, 
			a.constrstart, 
			a.totalestcost, 
			a.previousappropriations, 
			a.fundingreqd, 
			NULL::text as neededtocomplete,
			'sca_cp_cap_schools_FY2015-19'::text AS source
	FROM sca_cp_cap_schools_prev a
	LEFT JOIN sca_cp_cap_location_prev b
	ON a.school = b.school);
-- join two tables where prev is not in curr
DROP TABLE IF EXISTS sca_cp_cap_joined;
CREATE TABLE sca_cp_cap_joined AS (
SELECT a.* FROM sca_cp_cap_joined_cur a
UNION 
SELECT b.* FROM sca_cp_cap_joined_prev b
WHERE b.projectnum NOT IN (SELECT a.projectnum FROM sca_cp_cap_joined_cur a));

ALTER TABLE sca_cp_cap_joined
ADD COLUMN inprev text;
UPDATE sca_cp_cap_joined
SET inprev = 'Y'
WHERE projectnum IN (SELECT a.projectnum FROM sca_cp_cap_joined_prev a);

DROP TABLE IF EXISTS sca_cp_cap_joined_cur;
DROP TABLE IF EXISTS sca_cp_cap_joined_prev;