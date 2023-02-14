<?php

    require("connection.php");
    $userid = $_GET['userid'];

    $sql = "SELECT * FROM category WHERE userId = '$userid' OR userId IS NULL;";

    $results = mysqli_query($conn,$sql);
    $response = array();
    if($results->num_rows > 0){
        while($row = $results->fetch_assoc()){
            array_push($response,$row);
        }
    }
    $conn->close();
    header('Context-Type: application/json');
    echo json_encode($response);
?>