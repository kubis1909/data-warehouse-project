CREATE or ALTER PROCEDURE bronze.load_bronze as 
BEGIN
    DECLARE @start_time DATE, @end_time DATE
    BEGIN TRY
        PRINT '======================='
        PRINT 'Loading Bronze Layer'
        PRINT '======================='

        SET @start_time = GETDATE();
        PRINT '>> Truncating table: bronze.crm_cust_info'
        TRUNCATE table bronze.crm_cust_info;

        PRINT '>> Inserting Table: bronze.crm_cust_info'
        BULK INSERT bronze.crm_cust_info
        FROM '/dataset/cust_info.csv'
        WITH(
            FIRSTROW = 2, 
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        

        PRINT '>> Truncating table: bronze.crm_prd_info'
        TRUNCATE table bronze.crm_prd_info;

        PRINT '>> Inserting Table: bronze.crm_prd_info'
        BULK INSERT bronze.crm_prd_info
    
        FROM '/dataset/prd_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        PRINT '>> Truncating table: bronze.cust_az12'
        TRUNCATE table bronze.cust_az12;

        PRINT '>> Inserting Table: bronze.cust_az12'
        BULK INSERT bronze.cust_az12
        FROM '/dataset/CUST_AZ12.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating table: bronze.loc_a101'
        TRUNCATE table bronze.loc_a101;

        PRINT '>> Inserting Table: bronze.loc_a101'
        BULK INSERT bronze.loc_a101
        FROM '/dataset/LOC_A101.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating table: bronze.px_cat_G1V2'
        TRUNCATE table bronze.px_cat_G1V2;

        PRINT '>> Inserting Table: bronze.px_cat_G1V2'
        BULK INSERT bronze.px_cat_G1V2
        FROM '/dataset/PX_CAT_G1V2.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        PRINT '>> Truncating table: bronze.sales_details'
        TRUNCATE table bronze.sales_details;

        PRINT '>> Inserting Table:bronze.sales_details'
        BULK INSERT bronze.sales_details
        FROM '/dataset/sales_details.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
    
        PRINT 'Duration time: ' CAST(TIMEDIFF(second, @start_time, @end_time) AS NVARCHAR(50) + ' seconds');
    END TRY
    BEGIN CATCH
    PRINT '==========================='
    PRINT 'Error Message' + ERROR_MESSAGE();
    PRINT '==========================='
    END CATCH
END

