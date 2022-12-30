-- BAI 1 - CAU 1 --
CREATE OR REPLACE procedure "DEPT_INFO" (
        dept_id IN departments.department_id%type
    )
IS
    dept_name   departments.department_name%type;
    cursor d is
        select department_name
        from departments
        where department_id = dept_id;
BEGIN
    -- Init --
    open d;

    -- Logic --
    fetch d into dept_name;
    if d%notfound then
        dbms_output.put_line('There is no department with id ' || dept_id);
    else
        dbms_output.put_line('The department with id ' || dept_id || ' is ' || dept_name);
    end if;

    -- Cleanup --
    close d;

EXCEPTION
    when others then
        if d%isopen then
            close d;
        end if;
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 2 --
CREATE OR REPLACE procedure "ADD_JOB" (
        job_id      IN jobs.job_id%type,
        job_title   IN jobs.job_title%type
    )
AS
BEGIN
    -- Logic --
    insert into jobs (job_id, job_title)
    values (job_id, job_title);

EXCEPTION
    when DUP_VAL_ON_INDEX then
        dbms_output.put_line('Job id ' || job_id || ' alreay exist');
    when others then
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 3 --
CREATE OR REPLACE procedure "UPDATE_COMM" (
        emp_id      IN employees.employee_id%type
    )
AS
BEGIN
    -- Logic --
    update employees
    set COMMISSION_PCT = COMMISSION_PCT * 1.05
    where employee_id = emp_id;

EXCEPTION
    when others then
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 4 --
CREATE OR REPLACE procedure "ADD_EMP" (
        emp_id          IN employees.employee_id%type,
        first_name      IN employees.first_name%type,
        last_name       IN employees.last_name%type,
        email           IN employees.email%type,
        phone_number    IN employees.phone_number%type,
        hire_date       IN employees.hire_date%type,
        job_id          IN employees.job_id%type,
        salary          IN employees.salary%type,
        commission_pct  IN employees.commission_pct%type,
        manager_id      IN employees.manager_id%type,
        department_id   IN employees.department_id%type
    )
AS
BEGIN
        -- Logic --
    insert into employees
    values (emp_id,
            first_name, 
            last_name,
            email,
            phone_number,
            hire_date,
            job_id,
            salary,
            commission_pct,
            manager_id,
            department_id);

EXCEPTION
    when DUP_VAL_ON_INDEX then
        dbms_output.put_line('Employee id ' || emp_id || ' alreay exist');
    when others then
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 5 --
CREATE OR REPLACE procedure "DELETE_EMP" (
        emp_id  IN employees.employee_id%type
    )
AS
BEGIN
    delete from employees 
    where employee_id = emp_id;

EXCEPTION
    when others then
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 6 --
CREATE OR REPLACE procedure "FIND_EMP"
IS
    emp_row         employees%rowtype;
    cursor emp_c is
        select employees.*
        from employees
        join jobs
        on employees.job_id = jobs.job_id
        where salary > min_salary and salary < max_salary;
BEGIN
    -- Init --
    open emp_c;
    
    -- Logic --
    loop
        fetch emp_c into emp_row;
        exit when emp_c%notfound;
        dbms_output.put_line(emp_row.employee_id || ' ' || emp_row.first_name || ' ' || emp_row.last_name);
    end loop;

    -- Cleanup --
    close emp_c;
EXCEPTION
    when others then
        if emp_c%isopen then
            close emp_c;
        end if;
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 7 --
CREATE OR REPLACE procedure "UPDATE_SALARY" 
IS
    emp_id          employees.employee_id%type;
    hire_date       employees.hire_date%type;
    cursor emp_c is
        select employee_id, hire_date
        from employees;
BEGIN
    -- Init --
    open emp_c;
    
    -- Logic --
    loop
        fetch emp_c into emp_id, hire_date;
        exit when emp_c%notfound;
        
        if (sysdate - hire_date)/ 365 >= 2 then
            update employees
            set salary = salary + 200
            where employee_id = emp_id;
        elsif (sysdate - hire_date)/ 365 > 1 then
            update employees
            set salary = salary + 100
            where employee_id = emp_id;
        elsif (sysdate - hire_date)/ 365 = 1 then
            update employees
            set salary = salary + 50
            where employee_id = emp_id;
        end if;
    end loop;

    -- Cleanup --
    close emp_c;
EXCEPTION
    when others then
        if emp_c%isopen then
            close emp_c;
        end if;
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - CAU 8 --
CREATE OR REPLACE procedure "JOB_HIS" (
        emp_id      IN employees.employee_id%type
    )
IS
    job_row         job_history%rowtype;
    cursor job_history_list_c is
        select *
        from job_history
        where employee_id = emp_id;
BEGIN
    -- Init --
    open job_history_list_c;
    
    -- Logic --
    loop
        fetch job_history_list_c into job_row;
        exit when job_history_list_c%notfound;
        dbms_output.put_line(job_row.start_date || ' - ' || job_row.end_date || ' : ' || job_row.job_id || ' at department ' || job_row.department_id);
    end loop;

    -- Cleanup --
    close job_history_list_c;
EXCEPTION
    when others then
        if job_history_list_c%isopen then
            close job_history_list_c;
        end if;
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
END;


-- BAI 1 - DEMO EXECUTE --
exec dept_info(100);
exec add_job(21, 'nhan''s job'); 
exec update_comm(101);
exec add_emp(500, 'nhan', 'nhan', 'nhan@email.com', '0123456789', add_months(sysdate, 1), 'SA_REP', 12000, 0, 145, 80);
exec delete_emp(500);
exec find_emp();
exec update_salary();
exec job_his(102);


-- BAI 2 - CAU 1 --
CREATE OR REPLACE function SUM_SALARY(
        dept_id     IN employees.department_id%type
    )
return employees.salary%type
IS
    sum_salary      employees.salary%type;
    cursor sum_c is
        select sum(salary)
        from employees
        where department_id = dept_id;
BEGIN
    -- Init --
    open sum_c;
    sum_salary := 0;
    
    -- Logic --
    fetch sum_c into sum_salary;
    
    -- Cleanup --
    close sum_c;
    
    return sum_salary;
EXCEPTION
    when others then
        if sum_c%isopen then
            close sum_c;
        end if;
        raise;
END;


-- BAI 2 - CAU 2 --
CREATE OR REPLACE function NAME_CON(
        coun_id     IN countries.country_id%type
    )
return countries.country_name%type
IS
    country_name    countries.country_name%type;
    cursor country_c is
        select country_name
        from countries
        where country_id = coun_id;
BEGIN
    -- Init --
    open country_c;
    country_name := '';
    
    -- Logic --
    fetch country_c into country_name;
    
    -- Cleanup --
    close country_c;
    
    return country_name;
EXCEPTION
    when others then
        if country_c%isopen then
            close country_c;
        end if;
        raise;
END;


-- BAI 2 - CAU 3 --
CREATE OR REPLACE function ANNUAL_COMP(
        salary      IN employees.salary%type,
        commission  IN employees.commission_pct%type
    )
return employees.salary%type
AS
BEGIN

    return salary * 12 * (1 + commission);
EXCEPTION
    when others then
        raise;
END;


-- BAI 2 - CAU 4 --
CREATE OR REPLACE function AVG_SALARY(
        dept_id     IN employees.department_id%type
    )
return employees.salary%type
IS
    avg_salary      employees.salary%type;
    cursor avg_c is
        select avg(salary)
        from employees
        where department_id = dept_id;
BEGIN
    -- Init --
    open avg_c;
    avg_salary := 0;
    
    -- Logic --
    fetch avg_c into avg_salary;
    
    -- Cleanup --
    close avg_c;
    
    return avg_salary;
EXCEPTION
    when others then
        if avg_c%isopen then
            close avg_c;
        end if;
        raise;
END;


-- BAI 2 - CAU 5 --
CREATE OR REPLACE function TIME_WORK(
        emp_id      IN employees.employee_id%type
    )
return number
IS
    work_month      number;
    cursor work_month_c is
        select (sysdate - hire_date)/ 30
        from employees
        where employee_id = emp_id;
BEGIN
    -- Init --
    open work_month_c;
    work_month := 0;
    
    -- Logic --
    fetch work_month_c into work_month;
    
    -- Cleanup --
    close work_month_c;
    
    return work_month;
EXCEPTION
    when others then
        if work_month_c%isopen then
            close work_month_c;
        end if;
        raise;
END;


-- BAI 2 - DEMO EXECUTE --
declare
    q21     employees.salary%type;
    q22     countries.country_name%type;
    q23     employees.salary%type;
    q24     employees.salary%type;
    q25     number;
begin
    q21 := sum_salary(100);
    dbms_output.put_line(q21);
    
    q22 := name_con('DK');
    dbms_output.put_line(q22);

    q23 := annual_comp(1000, 10);
    dbms_output.put_line(q23);
    
    q24 := avg_salary(100);
    dbms_output.put_line(q24);
    
    q25 := time_work(100);
    dbms_output.put_line(q25);
EXCEPTION
    when others then
        dbms_output.put_line('UNEXPECTED ERROR');
        dbms_output.put_line('SQLCODE: ' || sqlcode);
        dbms_output.put_line('Message: ' || sqlerrm);
end;


-- BAI 3 - CAU 1 --
CREATE OR REPLACE trigger HIREDATE_BEFORE_CURRDATE
BEFORE INSERT OR UPDATE
    ON employees
    FOR EACH ROW
DECLARE
BEGIN
    -- Logic --
    if :new.hire_date > sysdate then
        raise_application_error(-20001, 'Hire date must be smaller than or equal to current date');
    end if;
    
EXCEPTION
    when others then
        raise;
END;


-- BAI 3 - CAU 2 --
CREATE OR REPLACE trigger MINSALARY_SMALLER_MAXSALARY
BEFORE INSERT OR UPDATE
    ON jobs
    FOR EACH ROW
DECLARE
BEGIN
    -- Logic --    
    if :new.min_salary >= :new.max_salary then
        raise_application_error(-20001, 'Min salary must be smaller than max salary');
    end if;
    
EXCEPTION
    when others then
        raise;
END;


-- BAI 3 - CAU 3 --
CREATE OR REPLACE trigger STARTDATE_SMALLER_ENDDATE
BEFORE INSERT OR UPDATE
    ON job_history
    FOR EACH ROW
DECLARE
BEGIN
    -- Logic --
    if :new.start_date > :new.end_date then
        raise_application_error(-20001, 'Start date must be before end date');
    end if;
    
EXCEPTION
    when others then
        raise;
END;


-- BAI 3 - CAU 4 --
CREATE OR REPLACE trigger SALARY_COMMISSION_ALWAYS_INCREASE
BEFORE UPDATE
    ON employees
    FOR EACH ROW
DECLARE
BEGIN
    -- Logic --
    if :new.salary < :old.salary or :new.commission_pct < :old.commission_pct then
        raise_application_error(-20001, 'Salary and commision percentage can not decrease');
    end if;
    
EXCEPTION
    when others then
        raise;
END;