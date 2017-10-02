<?php

// Add drush aliases so we can do this from any directory
// drush @mysite en devel -y

// If a multi site is used (thus two aliases to same folder)
// only the root will be set.
// to use a default site place a "sites/default/drushrc.php" file
// and set $options['uri'] = 'http://example.com';
// see https://github.com/drush-ops/drush/issues/87#issuecomment-169266833

$pre_aliases = array(
  'mybigsite' => array(
    'root' => 'C:/Projects/mysite',
    'uri' => 'http://myproject.build.localtest.me',
  ),
  'mysmallsite' => array(
    'root' => 'C:/Projects/mysite',
    'uri' => 'http://myproject.build.localtest.me',
  ),
  'myothersite' => array(
    'root' => 'C:/Projects/myothersite',
    'uri' => 'http://myproject.build.localtest.me',
  ),
);

$build_folders = array('docroot', 'build');

// Optionally add build folder(e.g. docroot) & process to $aliases array.
$aliases = array();
foreach ($pre_aliases as $pre_alias_id => $pre_alias_val) {
  // Set drupal context outside build folder (e.g. docroot).
  foreach ($build_folders as $folder) {
    // Composer project docroot/web.
    if (drush_valid_root("{$pre_alias_val['root']}/{$folder}/web")) {
      $pre_alias_val['root'] = "{$pre_alias_val['root']}/{$folder}/web";
      break;
    }
    elseif (drush_valid_root("{$pre_alias_val['root']}/{$folder}")) {
      $pre_alias_val['root'] = "{$pre_alias_val['root']}/{$folder}";
      break;
    }
  }
  $aliases[$pre_alias_id] = array(
    'root' => $pre_alias_val['root'],
    'uri' => $pre_alias_val['uri'],
  );
}

// Processed example.
// @codingStandardsIgnoreStart
/*
$aliases = array(
  'site1' => array(
    'root' => 'C:/Projects/myproject/docroot',
    'uri' => 'http://myproject.build.localtest.me',
  ),
);
*/
// @codingStandardsIgnoreEnd
