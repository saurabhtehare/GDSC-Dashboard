use gdsc;

# How much unique drug we have ---> 276
select count(distinct Drug_id) from gdsc_cleaned;

# Average Drug Sensitivity from all ---> 2.69
select avg(ln_ic50) from gdsc_cleaned;

# Unique Cancer cell line ---> 969
select count(distinct cell_line_name) from gdsc_cleaned;

# Most effective Drug ---> Dactinommycin
select Drug_name from gdsc_cleaned where ln_ic50 = (select min(ln_ic50) from gdsc_cleaned);

# Most Responsive Cancer Type
With CancerAvgic50 as(
	select tcga_desc, avg(ln_ic50) as avg_ic50
    from gdsc_cleaned
    group by tcga_desc
)
select tcga_desc as min_ic50_cancertype
from CancerAvgic50
where avg_ic50 = (select min(avg_ic50) from CancerAvgIc50);

# evaluating drug efficacy by key metrics ln_ic50 and auc
select drug_name, min(ln_ic50) as min_ln_ic50, max(auc) as max_auc
from gdsc_cleaned
group by drug_name
order by min_ln_ic50 asc;

# top drugs
select Drug_name, min(ln_ic50) as min_ln_ic50
from gdsc_cleaned
group by Drug_id, Drug_name
order by min_ln_ic50 asc
Limit 10;
