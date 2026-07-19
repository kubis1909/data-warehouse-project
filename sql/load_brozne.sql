-- Active: 1784470355426@@localhost@5433@DataWarehouse
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
BEGIN

    RAISE NOTICE '=======================';
    RAISE NOTICE 'Loading Bronze Layer';
    RAISE NOTICE '=======================';


    start_time := CURRENT_TIMESTAMP;


    RAISE NOTICE '>> Truncating table: bronze.crm_cust_info';

    TRUNCATE TABLE bronze.crm_cust_info;


    RAISE NOTICE '>> Loading table: bronze.crm_cust_info';

    COPY bronze.crm_cust_info
    FROM '/dataset/cust_info.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    RAISE NOTICE '>> Truncating table: bronze.crm_prd_info';

    TRUNCATE TABLE bronze.crm_prd_info;


    RAISE NOTICE '>> Loading table: bronze.crm_prd_info';

    COPY bronze.crm_prd_info
    FROM '/dataset/prd_info.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    RAISE NOTICE '>> Truncating table: bronze.cust_az12';

    TRUNCATE TABLE bronze.cust_az12;


    COPY bronze.cust_az12
    FROM '/dataset/CUST_AZ12.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    RAISE NOTICE '>> Truncating table: bronze.loc_a101';

    TRUNCATE TABLE bronze.loc_a101;


    COPY bronze.loc_a101
    FROM '/dataset/LOC_A101.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    RAISE NOTICE '>> Truncating table: bronze.px_cat_G1V2';

    TRUNCATE TABLE bronze.px_cat_G1V2;


    COPY bronze.px_cat_G1V2
    FROM '/dataset/PX_CAT_G1V2.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    RAISE NOTICE '>> Truncating table: bronze.sales_details';

    TRUNCATE TABLE bronze.sales_details;


    COPY bronze.sales_details
    FROM '/dataset/sales_details.csv'
    WITH (
        FORMAT CSV,
        HEADER TRUE,
        DELIMITER ','
    );


    end_time := CURRENT_TIMESTAMP;


    RAISE NOTICE 'Duration: % seconds',
        EXTRACT(EPOCH FROM (end_time - start_time));


EXCEPTION
    WHEN OTHERS THEN

        RAISE NOTICE '=======================';
        RAISE NOTICE 'Error: %', SQLERRM;
        RAISE NOTICE '=======================';

END;
$$;

SELECT * FROM bronze.crm_cust_info;