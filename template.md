```
create schema new_project
```
```

drop TABLE YELP_BUSINESSES

create TABLE YELP_BUSINESSES 
    (business_id varchar(100),
    name varchar(100),
    address varchar(100),
    city varchar(100),
    state varchar(100),
    postal_code varchar(100),
    latitude float,
    longitude float,
    stars float,
    review_count smallint,
    is_open smallint,
    attributes json,
    categories varchar(100),
    hours json,
    constraint pk_business_id primary key (business_id));
```
