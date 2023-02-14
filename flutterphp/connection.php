<?php

    $conn = mysqli_connect('localhost:3307','root','','seanmad');

    if(!$conn){
        echo "Database fail to connect";
    }
    
?>