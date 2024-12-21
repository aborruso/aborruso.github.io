                                                                           Table "tenant.ou_s4_04_statistical_dataset"
          Column           |          Type          | Collation | Nullable |                            Default                             | Storage  | Compression | Stats target | Description 
---------------------------+------------------------+-----------+----------+----------------------------------------------------------------+----------+-------------+--------------+-------------
 id                        | integer                |           | not null | nextval('tenant.ou_s404_statistical_dataset_id_seq'::regclass) | plain    |             |              | 
 level_iii_eunis_class     | character varying(100) |           |          |                                                                | extended |             |              | 
 area_of_forest_habitat    | numeric                |           |          |                                                                | main     |             |              | 
 area_in_lazio_region      | numeric                |           |          |                                                                | main     |             |              | 
 level_ii_eunis_class      | character varying(100) |           |          |                                                                | extended |             |              | 
 area_of_coastal_habitat   | numeric                |           |          |                                                                | main     |             |              | 
 area_of_shrubland_habitat | numeric                |           |          |                                                                | main     |             |              | 
 area_of_grassland_habitat | numeric                |           |          |                                                                | main     |             |              | 
Indexes:
    "ou_s404_statistical_dataset_pkey" PRIMARY KEY, btree (id)
Access method: heap

