<?php

    require("connection.php");

    $id = $_POST['id'];

    $sql = "UPDATE items SET isarchive='1' WHERE id='$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();
?>