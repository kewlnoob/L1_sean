<?php
    require("connection.php");
    $id = $_GET["userid"];

    $sql = "SELECT * from users WHERE id='$id'";
    
    $query = mysqli_query($conn,$sql);

    $user = mysqli_fetch_assoc($query);
    echo json_encode(array(
        'userid' => $user["id"],
        'username' => $user["username"], 
        'email' => $user["email"], 
        'password' => $user["password"],
        'image' => $user["image"]
    ));

?>