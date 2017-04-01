<?php

//enable drush to run outside docroot & set uri option (good for drush uil)
//https://github.com/drush-ops/drush/issues/87#issuecomment-169266833

// grab $pre_aliases variable from aliases.drushrc.php in current dir;
$path_to_alias_file = dirname(__FILE__) . '/aliases.drushrc.php';
if(file_exists($path_to_alias_file)) {
  include $path_to_alias_file;
}

$cwd = drush_cwd();
foreach ($pre_aliases as $alias) {
  if (strpos($cwd, $alias['root']) === 0) {
    $options['uri'] = $alias['uri'];
    // Set drupal context outside docroot.
    if (file_exists($alias['root'] . '/docroot')) {
      $options['root'] = $alias['root'] . '/docroot';
    }
  }
}
