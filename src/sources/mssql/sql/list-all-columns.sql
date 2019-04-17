-- params: dbname
--         table-type-name
--         including
--         filter-list-to-where-clause including
--         excluding
--         filter-list-to-where-clause excluding
  select c.TABLE_SCHEMA,
         c.TABLE_NAME,
         c.COLUMN_NAME,
         c.DATA_TYPE,
         NULL,
         c.IS_NULLABLE,
         COLUMNPROPERTY(object_id(c.TABLE_NAME), c.COLUMN_NAME, 'IsIdentity'),
         c.CHARACTER_MAXIMUM_LENGTH,
         c.NUMERIC_PRECISION,
         c.NUMERIC_PRECISION_RADIX,
         c.NUMERIC_SCALE,
         c.DATETIME_PRECISION,
         c.CHARACTER_SET_NAME,
         c.COLLATION_NAME

    from INFORMATION_SCHEMA.COLUMNS c
         join INFORMATION_SCHEMA.TABLES t
              on c.TABLE_SCHEMA = t.TABLE_SCHEMA
             and c.TABLE_NAME = t.TABLE_NAME

   where     c.TABLE_CATALOG = '~a'
         and t.TABLE_TYPE = '~a'
         ~:[~*~;and (~{~a~^~&~10t or ~})~]
         ~:[~*~;and (~{~a~^~&~10t and ~})~]

order by c.table_schema, c.table_name, c.ordinal_position;
