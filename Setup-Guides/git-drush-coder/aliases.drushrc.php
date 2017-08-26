<?php

// Add drush aliases so we can do this from any directory
// drush @mysite en devel -y

$pre_aliases = array(
  'mysite' => array(
    'root' => 'C:/Projects/mysite',
    'uri' => 'http://myproject.build.localtest.me',
  ),
);

$build_folders = array('docroot', 'build');

//optionally add build folder(e.g. docroot) & process to $aliases array
$aliases = array();
foreach ($pre_aliases as $pre_alias_id => $pre_alias_val) {
  // Set drupal context outside build folder (e.g. docroot).
  foreach ($build_folders as $folder) {
    // Composer project docroot/web.
    if (file_exists("{$pre_alias_val['root']}/{$folder}/web")) {
      $pre_alias_val['root'] = "{$pre_alias_val['root']}/{$folder}/web";
      break;
    }
    elseif (file_exists("{$pre_alias_val['root']}/{$folder}")) {
      $pre_alias_val['root'] = "{$pre_alias_val['root']}/{$folder}";
      break;
    }
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
