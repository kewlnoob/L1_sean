<?php

    require("connection.php");
    
    $listid = $_GET['listid'];

    $sql = "SELECT * FROM items WHERE listid = '$listid'";

    $result = mysqli_query($conn,$sql);
    $response = array();
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            if($row['iscompleted'] == 0){
                $row['iscompleted'] = false;
            }else{
                $row['iscompleted'] = true;
            }
            
            if($row['isfavourite'] == 0){
                $row['isfavourite'] = false;
            }else{
                $row['isfavourite'] = true;
            }

            if($row['isarchive'] == 0){
                $row['isarchive'] = false;
            }else{
                $row['isarchive'] = true;
                array_push($response,$row);
            }  
        }
    }
    echo json_encode($response);

    $conn->close();
?>