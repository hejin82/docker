# master

```
mysql > show binlog events;
```

| Log_name          | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
|-------------------|-----|----------------|-----------|-------------|---------------------------------------|
| master-bin.000001 |   4 | Format_desc    |         1 |         123 | Server ver: 5.7.24-log, Binlog ver: 4 |
| master-bin.000001 | 123 | Previous_gtids |         1 |         154 |                                       |
| master-bin.000001 | 154 | Rotate         |         1 |         202 | master-bin.000002;pos=4               |

```
mysql > create database test;
```

```
mysql> show master status;
```

| File              | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set |
|-------------------|----------|--------------|------------------|-------------------|
| master-bin.000002 |      313 |              |                  |                   |

```
mysql> show binlog events in 'master-bin.000002';
```

| Log_name          | Pos | Event_type     | Server_id | End_log_pos | Info                                  |
|-------------------|-----|----------------|-----------|-------------|---------------------------------------|
| master-bin.000002 |   4 | Format_desc    |         1 |         123 | Server ver: 5.7.24-log, Binlog ver: 4 |
| master-bin.000002 | 123 | Previous_gtids |         1 |         154 |                                       |
| master-bin.000002 | 154 | Anonymous_Gtid |         1 |         219 | SET @@SESSION.GTID_NEXT= 'ANONYMOUS'  |
| master-bin.000002 | 219 | Query          |         1 |         313 | create database test                  |


# slave

```
mysql> show slave status;
```

| Slave_IO_State                   | Master_Host  | Master_User | Master_Port | Connect_Retry | Master_Log_File   | Read_Master_Log_Pos | Relay_Log_File         | Relay_Log_Pos | Relay_Master_Log_File | Slave_IO_Running | Slave_SQL_Running | Replicate_Do_DB | Replicate_Ignore_DB | Replicate_Do_Table | Replicate_Ignore_Table | Replicate_Wild_Do_Table | Replicate_Wild_Ignore_Table | Last_Errno | Last_Error | Skip_Counter | Exec_Master_Log_Pos | Relay_Log_Space | Until_Condition | Until_Log_File | Until_Log_Pos | Master_SSL_Allowed | Master_SSL_CA_File | Master_SSL_CA_Path | Master_SSL_Cert | Master_SSL_Cipher | Master_SSL_Key | Seconds_Behind_Master | Master_SSL_Verify_Server_Cert | Last_IO_Errno | Last_IO_Error | Last_SQL_Errno | Last_SQL_Error | Replicate_Ignore_Server_Ids | Master_Server_Id | Master_UUID                          | Master_Info_File           | SQL_Delay | SQL_Remaining_Delay | Slave_SQL_Running_State                                | Master_Retry_Count | Master_Bind | Last_IO_Error_Timestamp | Last_SQL_Error_Timestamp | Master_SSL_Crl | Master_SSL_Crlpath | Retrieved_Gtid_Set | Executed_Gtid_Set | Auto_Position | Replicate_Rewrite_DB | Channel_Name | Master_TLS_Version |
|----------------------------------|--------------|-------------|-------------|---------------|-------------------|---------------------|------------------------|---------------|-----------------------|------------------|-------------------|-----------------|---------------------|--------------------|------------------------|-------------------------|-----------------------------|------------|------------|--------------|---------------------|-----------------|-----------------|----------------|---------------|--------------------|--------------------|--------------------|-----------------|-------------------|----------------|-----------------------|-------------------------------|---------------|---------------|----------------|----------------|-----------------------------|------------------|--------------------------------------|----------------------------|-----------|---------------------|--------------------------------------------------------|--------------------|-------------|-------------------------|--------------------------|----------------|--------------------|--------------------|-------------------|---------------|----------------------|--------------|--------------------|
| Waiting for master to send event | mysql-master | root        |        3306 |            60 | master-bin.000002 |                 313 | slave-relay-bin.000004 |           480 | master-bin.000002     | Yes              | Yes               |                 |                     |                    |                        |                         |                             |          0 |            |            0 |                 313 |             687 | None            |                |             0 | No                 |                    |                    |                 |                   |                |                     0 | No                            |             0 |               |              0 |                |                             |                1 | 41b36a28-c5d0-11eb-92d1-0242ac160002 | /var/lib/mysql/master.info |         0 |                NULL | Slave has read all relay log; waiting for more updates |              86400 |             |                         |                          |                |                    |                    |                   |             0 |                      |              |                    |



