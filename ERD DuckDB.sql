-- Dimension Tables
CREATE TABLE dim_companies (
  company_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_areas (
  area_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_positions (
  position_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_departments (
  department_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_divisions (
  division_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_directorates (
  directorate_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_grades (
  grade_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_education (
  education_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_majors (
  major_id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL
);

CREATE TABLE dim_competency_pillars (
  pillar_code VARCHAR(3) PRIMARY KEY,
  pillar_label TEXT NOT NULL
);

-- Fact & Profile Tables
CREATE TABLE employees (
  employee_id TEXT PRIMARY KEY,
  fullname TEXT,
  nip TEXT,
  company_id INT REFERENCES dim_companies(company_id),
  area_id INT REFERENCES dim_areas(area_id),
  position_id INT REFERENCES dim_positions(position_id),
  department_id INT REFERENCES dim_departments(department_id),
  division_id INT REFERENCES dim_divisions(division_id),
  directorate_id INT REFERENCES dim_directorates(directorate_id),
  grade_id INT REFERENCES dim_grades(grade_id),
  education_id INT REFERENCES dim_education(education_id),
  major_id INT REFERENCES dim_majors(major_id),
  years_of_service_months INT
);

CREATE TABLE profiles_psych (
  employee_id TEXT PRIMARY KEY REFERENCES employees(employee_id),
  pauli NUMERIC,
  faxtor NUMERIC,
  disc TEXT,
  disc_word TEXT,
  mbti TEXT,
  iq NUMERIC,
  gtq INT,
  tiki INT
);

CREATE TABLE papi_scores (
  employee_id TEXT REFERENCES employees(employee_id),
  scale_code TEXT,
  score INT,
  PRIMARY KEY (employee_id, scale_code)
);

CREATE TABLE strengths (
  employee_id TEXT REFERENCES employees(employee_id),
  rank INT,
  theme TEXT,
  PRIMARY KEY (employee_id, rank)
);

CREATE TABLE performance_yearly (
  employee_id TEXT REFERENCES employees(employee_id),
  year INT,
  rating INT,
  PRIMARY KEY (employee_id, year)
);

CREATE TABLE competencies_yearly (
  employee_id TEXT REFERENCES employees(employee_id),
  pillar_code VARCHAR(3) REFERENCES dim_competency_pillars(pillar_code),
  year INT,
  score INT,
  PRIMARY KEY (employee_id, pillar_code, year)
);

-- Indexes (Non-Primary Key)
CREATE INDEX performance_yearly_index_3 ON performance_yearly (year);
CREATE INDEX competencies_yearly_index_5 ON competencies_yearly (pillar_code, year);

-- Comments
COMMENT ON TABLE dim_competency_pillars IS 'Codes: GDR, CEX, IDS, QDD, STO, SEA, VCU, LIE, FTC, CSI';
COMMENT ON TABLE strengths IS 'CliftonStrengths rank 1..14';