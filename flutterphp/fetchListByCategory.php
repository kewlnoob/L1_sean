<?php

    require("connection.php");
    
    $categoryid = $_GET['categoryid'];
    $userid = $_GET['userid'];
    $page = $_GET['page'];

    $sql;
    if($page == "All"){
        $sql = "SELECT * FROM userslist WHERE categoryid = '$categoryid' AND userid = '$userid'";
    }
    else if ($page == "Archived"){
        $sql = "SELECT userslist.* FROM userslist INNER JOIN items 
        ON userslist.id = items.listid
        WHERE userslist.categoryid = '$categoryid' AND userslist.userid = '$userid' AND items.isarchive='1'";
    }
    else if ($page == "Completed"){
        $sql = "SELECT userslist.* FROM userslist INNER JOIN items
        ON userslist.id = items.listid
        WHERE categoryid = '$categoryid' AND userid = '$userid' AND items.iscompleted='1'";
    }
    else if ($page == "Favourite"){
        $sql = "SELECT userslist.* FROM userslist INNER JOIN items
        ON userslist.id = items.listid
        WHERE categoryid = '$categoryid' AND userid = '$userid' AND items.isfavourite='1'";
    }

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