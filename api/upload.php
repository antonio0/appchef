<?php

// app metadata from get params
$appname = $_GET["appname"];
$author = $_GET["author"];

// json description of the app as post
$json = $_POST("jsonapp");

$userpath = "projects/user-$author";
if (!file_exists($userpath))
  mkdir($userpath, 0777, true);

$apppath = "$userpath/app-$appname";
if (!file_exists($apppath)) {
    mkdir($apppath, 0777, true);
}

$jsonfile = fopen("app.json","w");
echo fwrite($jsonfile, $json);
fclose($jsonfile);

echo exec("./jsonTest $jsonfile $apppath/jessies.txt");

exec("python ../xcProjGenerator/genXCproj.py")

?>
