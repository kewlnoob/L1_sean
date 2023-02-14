<?php

    require("connection.php");
    
    $listid = $_GET['listid'];
    $hideCompleted = $_GET['hideCompleted'];

    if($hideCompleted == "show"){
        $sql = "SELECT items.id,items.name,items.iscompleted,
        items.listid,items.position,items.description,items.url,items.isfavourite,
        items.isfavourite,items.isarchive,items.priorityid,priority.name as pname FROM items 
        INNER JOIN priority on items.priorityid = priority.id 
        where listid='$listid' AND items.iscompleted = '1' order by id ";

        $results = mysqli_query($conn,$sql);
        $response = array();
        if($results->num_rows > 0){
            while($row = $results->fetch_assoc()){

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
                    array_push($response,$row);
                }else{
                    $row['isarchive'] = true;
                }       
            }
        }
        $conn->close();
        header('Context-Type: application/json');
        echo json_encode($response);
    }else{
        $sql = "SELECT items.id,items.name,items.iscompleted,
        items.listid,items.position,items.description,items.url,items.isfavourite,
        items.isfavourite,items.isarchive,items.priorityid,priority.name as pname FROM items 
        INNER JOIN priority on items.priorityid = priority.id 
        where listid='$listid' AND items.iscompleted = '0' order by id ";

        $results = mysqli_query($conn,$sql);
        $response = array();
        if($results->num_rows > 0){
            while($row = $results->fetch_assoc()){

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
                    array_push($response,$row);
                }else{
                    $row['isarchive'] = true;
                }       
            }
        }
        $conn->close();
        header('Context-Type: application/json');
        echo json_encode($response);
    }
?>