<?php

    require("connection.php");
    
    $userid = $_GET['userid'];

    $sql = "SELECT userslist.listname,COUNT(items.listid) as totalItems, 
    SUM(CASE WHEN items.iscompleted = 1 THEN 1 ELSE 0 END) as completed from userslist 
    LEFT JOIN items ON userslist.id = items.listid 
    WHERE userslist.userid='$userid' group by items.listid";

    $results = mysqli_query($conn,$sql);
    $response = array();
    if($results->num_rows > 0){
        while($row = $results->fetch_assoc()){
            array_push($response,$row);
        }
    }
    header('Context-Type: application/json');
    echo json_encode($response);
    $conn->close();
    
?>