<?php
    require 'connector-definition.php';
    try{
        $database=new PostgreDBConnector("admin","5433","us-west-2.5ce21198-7576-4446-a256-2054e47608f1.aws.ybdb.io","-TKzzPBle8QVhxSV5arvEqLJVPJM0U","yugabyte","../root.crt");
    }
    catch(Exception $e){
        die("Connection does not occur: ".$e->getMessage());
    }
?>