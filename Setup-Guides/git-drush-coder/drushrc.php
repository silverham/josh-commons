<?php

//enable drush to run outside docroot & set uri option (good for drush uil)
//https://github.com/drush-ops/drush/issues/87#issuecomment-169266833

// grab $pre_aliases & $build_folders variables from aliases.drushrc.php in current dir;
$path_to_alias_file = dirname(__FILE__) . '/aliases.drushrc.php';
if(file_exists($path_to_alias_file)) {
  include $path_to_alias_file;
}

// Get the directory drush was launched from
// i.e the current directory in your terminal.
$cwd = drush_cwd();

// Compute list of root folder locations to
// check if we are running in multi site and no uri passed
$roots = array();
foreach ($pre_aliases as $alias) {
  $roots[] = $alias['root'];
}

$root_dups = array();
$root_counts = array_count_values($roots);
foreach ($root_counts as $root_count_root => $root_count) {
  // False - not useable - multi site detected.
  $root_dups[$root_count_root] = $root_count > 1 ? FALSE : TRUE;
}

// $pre_aliases - The list of aliases.
foreach ($pre_aliases as $alias) {
  // If root was found in $cwd and
  // the match starts form the first character in the current directory.
  // TL;DR; Are in in alais folder?
  if (strpos($cwd, $alias['root']) === 0) {
    // Set drupal context outside build folder (e.g. docroot).
    foreach ($build_folders as $folder) {
      // Composer project docroot/web.
      if (file_exists("{$alias['root']}/{$folder}/web")) {
        $options['root'] = "{$alias['root']}/{$folder}/web";
      }
      elseif (file_exists("{$alias['root']}/{$folder}")) {
        $options['root'] = "{$alias['root']}/{$folder}";
      }
    }
    // Then set the drush uri to the uri in the alias.
    // if it's usable "single" site.
    if ($root_dups[$alias['root']] === TRUE) {
      $options['uri'] = $alias['uri'];
    } else {
      var_dump("DUP");
    }
  }
}

