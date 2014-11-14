<?php
#!/usr/bin/php
ini_set("display_errors", 1);
ini_set("track_errors", 1);
ini_set("html_errors", 1);
error_reporting(E_ALL);

// app metadata from get params
$appname = $_GET["appname"];
$author = $_GET["author"];

// json description of the app as post
$json = $_POST["json"];

$userpath = "/Applications/XAMPP/htdocs/projects/user-$author";
if (!file_exists($userpath)) {
  $old = umask(0);
  mkdir($userpath,0777,true);
  umask($old);


}


$apppath = "$userpath/app-$appname";
if (!file_exists($apppath)) {
   $old = umask(0);
   mkdir($apppath, 0777, true);
   umask($old);
}

$jsonfile = fopen("$apppath/app.json","w");
fwrite($jsonfile, $json);
fclose($jsonfile);
chmod("$apppath/app.json", 0777);

passthru("/Applications/XAMPP/htdocs/api/a.sh $apppath/app.json $apppath/jessies.txt");

passthru("cp -pr /Applications/XAMPP/htdocs/GeneratedApp $apppath");

//passthru("python /Applications/XAMPP/htdocs/xcProjGenerator/genXCproj.py $author $appname");
