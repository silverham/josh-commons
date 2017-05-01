<?php

// Add drush aliases so we can do this from any directory
// drush @mysite en devel -y

$pre_aliases = array(
  'mysite' => array(
    'root' => 'C:/Projects/mysite',
    'uri' => 'http://myproject.build.localtest.me',
  ),
);

//optionally add docroot & process to $aliases array
$aliases = array();
foreach ($pre_aliases as $pre_alias_id => $pre_alias_val) {
  if (file_exists($pre_alias_val['root'] . '/docroot')) {
    $pre_alias_val['root'] = $pre_alias_val['root'] . '/docroot';
  }
  $aliases[$pre_alias_id] = array(
    'root' => $pre_alias_val['root'],
    'uri' => $pre_alias_val['uri'],
  );
}

// processed example
/*
$aliases = array(
  'site1' => array(
    'root' => 'C:/Projects/myproject/docroot',
    'uri' => 'http://myproject.build.localtest.me',
  ),
);*/
