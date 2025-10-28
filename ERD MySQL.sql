CREATE TABLE `dim_companies` (
  `company_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_areas` (
  `area_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_positions` (
  `position_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_departments` (
  `department_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_divisions` (
  `division_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_directorates` (
  `directorate_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_grades` (
  `grade_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_education` (
  `education_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_majors` (
  `major_id` serial PRIMARY KEY,
  `name` text UNIQUE NOT NULL
);

CREATE TABLE `dim_competency_pillars` (
  `pillar_code` varchar(3) PRIMARY KEY,
  `pillar_label` text NOT NULL
);

CREATE TABLE `employees` (
  `employee_id` text PRIMARY KEY,
  `fullname` text,
  `nip` text,
  `company_id` int,
  `area_id` int,
  `position_id` int,
  `department_id` int,
  `division_id` int,
  `directorate_id` int,
  `grade_id` int,
  `education_id` int,
  `major_id` int,
  `years_of_service_months` int
);

CREATE TABLE `profiles_psych` (
  `employee_id` text PRIMARY KEY,
  `pauli` numeric,
  `faxtor` numeric,
  `disc` text,
  `disc_word` text,
  `mbti` text,
  `iq` numeric,
  `gtq` int,
  `tiki` int
);

CREATE TABLE `papi_scores` (
  `employee_id` text,
  `scale_code` text,
  `score` int
);

CREATE TABLE `strengths` (
  `employee_id` text,
  `rank` int,
  `theme` text
);

CREATE TABLE `performance_yearly` (
  `employee_id` text,
  `year` int,
  `rating` int
);

CREATE TABLE `competencies_yearly` (
  `employee_id` text,
  `pillar_code` varchar(3),
  `year` int,
  `score` int
);

CREATE UNIQUE INDEX `papi_scores_index_0` ON `papi_scores` (`employee_id`, `scale_code`);

CREATE UNIQUE INDEX `strengths_index_1` ON `strengths` (`employee_id`, `rank`);

CREATE UNIQUE INDEX `performance_yearly_index_2` ON `performance_yearly` (`employee_id`, `year`);

CREATE INDEX `performance_yearly_index_3` ON `performance_yearly` (`year`);

CREATE UNIQUE INDEX `competencies_yearly_index_4` ON `competencies_yearly` (`employee_id`, `pillar_code`, `year`);

CREATE INDEX `competencies_yearly_index_5` ON `competencies_yearly` (`pillar_code`, `year`);

ALTER TABLE `dim_competency_pillars` COMMENT = 'Codes: GDR, CEX, IDS, QDD, STO, SEA, VCU, LIE, FTC, CSI';

ALTER TABLE `strengths` COMMENT = 'CliftonStrengths rank 1..14';

ALTER TABLE `employees` ADD FOREIGN KEY (`company_id`) REFERENCES `dim_companies` (`company_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`area_id`) REFERENCES `dim_areas` (`area_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`position_id`) REFERENCES `dim_positions` (`position_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`department_id`) REFERENCES `dim_departments` (`department_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`division_id`) REFERENCES `dim_divisions` (`division_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`directorate_id`) REFERENCES `dim_directorates` (`directorate_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`grade_id`) REFERENCES `dim_grades` (`grade_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`education_id`) REFERENCES `dim_education` (`education_id`);

ALTER TABLE `employees` ADD FOREIGN KEY (`major_id`) REFERENCES `dim_majors` (`major_id`);

ALTER TABLE `profiles_psych` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `papi_scores` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `strengths` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `performance_yearly` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `competencies_yearly` ADD FOREIGN KEY (`employee_id`) REFERENCES `employees` (`employee_id`);

ALTER TABLE `competencies_yearly` ADD FOREIGN KEY (`pillar_code`) REFERENCES `dim_competency_pillars` (`pillar_code`);
