<?php

    require("connection.php");

    $name = $_POST['name'];
    $id = $_POST['id'];

    $sql = "UPDATE items SET name='$name' WHERE id='$id'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();
?>
