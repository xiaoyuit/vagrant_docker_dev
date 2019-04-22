<?php
$host = 'redis';
$port = 6379;
$pwd = 'root';

$redis = new Redis();
$redis->connect($host, $port);
$redis->auth($pwd);
$redis ->set( "hello" , "Redis is running");
echo $redis ->get( "hello");