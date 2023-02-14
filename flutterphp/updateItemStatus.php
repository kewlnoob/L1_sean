<?php

    require("connection.php");

    $itemid = $_POST['itemid'];
    $iscompleted = $_POST['iscompleted'];

    $sql = "UPDATE items SET iscompleted='$iscompleted' WHERE id='$itemid'";
    
    $query = mysqli_query($conn,$sql);
    if($query){
        echo json_encode("success");
    }else{
        echo json_encode("error");
    }
    $conn->close();
?>
