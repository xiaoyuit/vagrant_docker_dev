<?php
$host = 'mysql';
$user = 'root';
$pwd = 'root';
$db = 'mysql';

$mysqli = new mysqli($host, $user, $pwd, $db);
if ($mysqli->connect_errno) {
	echo "Errno: " . $mysqli->connect_errno . "\n";
}
$sql = 'show databases';
$databases = [];
if ($res = $mysqli->query($sql)) {
	while ($row = $res->fetch_assoc()) {
		$databases[] = $row['Database'];
	}
}

if(sizeof($databases) > 0){
	echo 'Mysql is running';
}else{
	echo 'Mysql error';
}