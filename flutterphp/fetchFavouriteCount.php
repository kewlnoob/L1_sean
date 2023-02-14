<?php

    require("connection.php");
    
    $userid = $_GET['userid'];

    $sql = "SELECT COUNT(*) AS count from users INNER JOIN 
    userslist on users.id = userslist.userid INNER JOIN 
    items on userslist.id = items.listid WHERE users.id = '$userid' AND items.isfavourite = '1'";
    $result = mysqli_query($conn,$sql);
    $row = mysqli_fetch_assoc($result);
    echo json_encode(array('count' => $row['count']));
    $conn->close();
    
?>