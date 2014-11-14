<?php

// app metadata from get params
$appname = $_GET["appname"];
$author = $_GET["author"];

$userpath = 'user-'.$author;
$apppath = $userpath.'/app-'.$appname;

exec("zip -r $apppath/app.zip $apppath/$appname");

header("Content-disposition: attachment; filename=$apppath/app.zip");
header('Content-type: application/zip');
readfile("$apppath/app.zip");

?>
