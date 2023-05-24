<?php 
    interface Database{
      public function connect();
      public function get_connection();
      public function set_connection($username,$port, $HOST, $password,$database);
      public function performQuery($sql);

      public function  fetch_results(&$record,$sql);
      public function  fetch_data(&$record,$sql);
  }

  class PostgreDBConnector implements Database{
      private $username;
      private $HOST;
      private $password;
      private $database;
      private $connection;
      private $port;

      private $sslcert;
      public function __construct($username,$port, $HOST, $password,$database,$sslcert){
          $this->username = $username;
          $this->HOST = $HOST;
          $this->password = $password;
          $this->database = $database;
          $this->port=$port;
          $this->sslcert = $sslcert;
          $this->connect();
      }

      public function connect(){
      $conn_str = 'pgsql:host=' . $this->HOST . ';port=' . $this->port . ';dbname=' . $this->database .
      ';sslmode=verify-full;sslrootcert=' . $this->sslcert;
        $this->connection = new PDO($conn_str,
        $this->username, $this->password,
        array(PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_EMULATE_PREPARES => true,
                PDO::ATTR_PERSISTENT => true));
      }

      public function get_connection(){
          return $this->connection;
      }

      public function set_connection($username,$port, $HOST, $password,$database){
          $this->username = $username;
          $this->HOST = $HOST;
          $this->password = $password;
          $this->database = $database;
          $this->port=$port;
          $this->connect();
      }

      public function performQuery($sql){
          if(is_null($this->connection)){
              die("Connection with database failed");
          }
          $result=$this->connection->query($sql);
          return $result;
      }

      public function fetch_results(&$record,$sql){
          $result=$this->performQuery($sql);
          $record=$result->fetch(PDO::FETCH_ASSOC);
      }

      public function fetch_data(&$record,$sql){
        $record=$sql->fetch(PDO::FETCH_ASSOC);
      }

      public function prepared_statement($sql) {
          return $this->connection->prepare($sql);
      }
      
      public function setPreparedStatement($stmt, &$param_term) {
          $stmt->bindParam(1, $param_term, PDO::PARAM_STR);
      }
      
      public function executePreparedStatement($stmt) {
          $stmt->execute();
      }
      
      public function getPreparedStatementResult($stmt, &$result) {
          $stmt->execute();
          $result = $stmt->fetchAll(PDO::FETCH_ASSOC);
      }
  }
?>