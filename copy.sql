CREATE TABLE tmp_jobsetevals as (SELECT * FROM jobsetevals as e WHERE e.project = 'nixpkgs' AND e.jobset = 'trunk' AND date_part('epoch',now()) - e.timestamp < 3.3e7);
CREATE TABLE tmp_jobsetevalinputs as (SELECT * FROM jobsetevalinputs WHERE eval IN (SELECT DISTINCT e.id FROM jobsetevals as e WHERE e.project = 'nixpkgs' AND e.jobset = 'trunk' AND date_part('epoch',now()) - e.timestamp < 3.3e7));
CREATE TABLE tmp_jobsetevalmembers as (SELECT * FROM jobsetevalmembers WHERE eval IN (SELECT DISTINCT e.id FROM jobsetevals as e WHERE e.project = 'nixpkgs' AND e.jobset = 'trunk' AND date_part('epoch',now()) - e.timestamp < 3.3e7));
CREATE TABLE tmp_builds as (SELECT * FROM builds WHERE id IN (SELECT DISTINCT m.build FROM jobsetevalmembers as m JOIN jobsetevals as e ON e.id = m.eval WHERE e.project = 'nixpkgs' AND e.jobset = 'trunk' AND date_part('epoch',now()) - e.timestamp < 3.3e7));
