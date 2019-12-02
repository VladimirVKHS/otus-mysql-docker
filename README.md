# Homework 4

Поднять сервис db_va можно командой:

`docker-compose up otusdb`

Для подключения к БД используйте команду:

`docker-compose exec otusdb mysql -u root -p12345 otus`

Для использования в клиентских приложениях можно использовать команду:

`mysql -u root -p12345 --port=3309 --protocol=tcp otus`

Sysbench

https://github.com/ashraf-s9s/sysbench-docker/blob/master/README.md


    docker run --network host --rm=true --name=sb-prepare severalnines/sysbench sysbench --db-driver=mysql --oltp-table-size=5 --oltp-tables-count=5 --threads=1 --mysql-host=0.0.0.0 --mysql-port=3309 --mysql-user=sbtest --mysql-password=password /usr/share/sysbench/tests/include/oltp_legacy/parallel_prepare.lua run
    
    docker run --network host --name=sb-run severalnines/sysbench sysbench --db-driver=mysql --report-interval=2 --mysql-table-engine=innodb --oltp-table-size=10000 --oltp-tables-count=5 --threads=2 --time=10 --mysql-host=0.0.0.
    0 --mysql-port=3309 --mysql-user=sbtest --mysql-password=password /usr/share/sysbench/tests/include/oltp_legacy/oltp.lua run