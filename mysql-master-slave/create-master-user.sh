mysql -u root -e "create uer repl_user;";
mysql -u root -e "grant replication slave on *.* to repl_user identified by 'repl_user_pass";
