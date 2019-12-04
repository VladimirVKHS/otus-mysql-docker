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
    
## Результаты Sysbench

### 2 потока

    [ 2s ] thds: 2 tps: 68.38 qps: 1386.56 (r/w/o: 971.29/86.85/328.42) lat (ms,95%): 38.25 err/s: 0.00 reconn/s: 0.00
    [ 4s ] thds: 2 tps: 70.04 qps: 1393.74 (r/w/o: 975.52/121.06/297.16) lat (ms,95%): 35.59 err/s: 0.00 reconn/s: 0.00
    [ 6s ] thds: 2 tps: 68.48 qps: 1372.16 (r/w/o: 961.26/144.96/265.93) lat (ms,95%): 35.59 err/s: 0.00 reconn/s: 0.00
    [ 8s ] thds: 2 tps: 66.53 qps: 1335.14 (r/w/o: 933.95/160.08/241.12) lat (ms,95%): 36.89 err/s: 0.00 reconn/s: 0.00
    [ 10s ] thds: 2 tps: 65.99 qps: 1319.79 (r/w/o: 923.85/172.97/222.96) lat (ms,95%): 36.24 err/s: 0.00 reconn/s: 0.00
    SQL statistics:
        queries performed:
            read:                            9534
            write:                           1372
            other:                           2714
            total:                           13620
        transactions:                        681    (67.99 per sec.)
        queries:                             13620  (1359.84 per sec.)
        ignored errors:                      0      (0.00 per sec.)
        reconnects:                          0      (0.00 per sec.)
    
    General statistics:
        total time:                          10.0143s
        total number of events:              681
    
    Latency (ms):
             min:                                   20.92
             avg:                                   29.38
             max:                                   49.90
             95th percentile:                       36.89
             sum:                                20008.81
    
    Threads fairness:
        events (avg/stddev):           340.5000/0.50
        execution time (avg/stddev):   10.0044/0.00



### 10 потоков

    [ 2s ] thds: 10 tps: 132.61 qps: 2738.52 (r/w/o: 1926.89/372.42/439.22) lat (ms,95%): 116.80 err/s: 0.50 reconn/s: 0.00
    [ 4s ] thds: 10 tps: 131.12 qps: 2603.44 (r/w/o: 1817.20/386.86/399.37) lat (ms,95%): 118.92 err/s: 0.00 reconn/s: 0.00
    [ 6s ] thds: 10 tps: 141.53 qps: 2855.66 (r/w/o: 1999.46/458.61/397.59) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
    [ 8s ] thds: 10 tps: 144.10 qps: 2892.46 (r/w/o: 2024.37/466.82/401.27) lat (ms,95%): 101.13 err/s: 0.00 reconn/s: 0.00
    [ 10s ] thds: 10 tps: 135.83 qps: 2695.06 (r/w/o: 1887.59/442.94/364.54) lat (ms,95%): 108.68 err/s: 0.00 reconn/s: 0.00
    SQL statistics:
        queries performed:
            read:                            19348
            write:                           4269
            other:                           4019
            total:                           27636
        transactions:                        1381   (137.26 per sec.)
        queries:                             27636  (2746.88 per sec.)
        ignored errors:                      1      (0.10 per sec.)
        reconnects:                          0      (0.00 per sec.)
    
    General statistics:
        total time:                          10.0590s
        total number of events:              1381
    
    Latency (ms):
             min:                                   23.38
             avg:                                   72.65
             max:                                  208.27
             95th percentile:                      112.67
             sum:                               100332.96
    
    Threads fairness:
        events (avg/stddev):           138.1000/2.51
        execution time (avg/stddev):   10.0333/0.01
