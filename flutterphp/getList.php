<?php

    require("connection.php");
    
    $userid = $_GET['userid'];

    $sql = "SELECT x.id,x.listname,y.color,z.icon,x.colorid,x.iconid,x.categoryid FROM 
            userslist as x INNER JOIN colors AS y 
            ON y.id = x.colorid INNER JOIN icons AS z 
            ON z.id = x.iconid WHERE x.userid = '$userid' order by x.id";


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