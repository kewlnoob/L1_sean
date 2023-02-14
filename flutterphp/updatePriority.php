<?php

    require("connection.php");

    $listid = $_POST['listid'];
    $id = $_POST['id'];

    $sql = "UPDATE items SET priorityid='$id' WHERE listid='$listid'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();
?>
