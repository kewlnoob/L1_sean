<?php

    require("connection.php");

    $id = $_POST['id'];
    $favourite = $_POST['favourite'];

    $sql = "UPDATE items SET isfavourite='$favourite' WHERE id='$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();
?>