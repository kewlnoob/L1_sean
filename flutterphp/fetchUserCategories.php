<?php

    require("connection.php");
    
    $userid = $_GET['userid'];

    $sql = "SELECT DISTINCT category.* FROM userslist INNER JOIN 
    category ON userslist.categoryid = category.categoryId WHERE userslist.userid = '$userid'";

    $result = mysqli_query($conn,$sql);
    $response = array();
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            array_push($response,$row);
        }
    }
    echo json_encode($response);

    $conn->close();
?>