<?php

/**
 * @file
 * Drush Runtime config.
 *
 * Enable drush to run outside docroot & set uri option (good for drush uli).
 * @see https://github.com/drush-ops/drush/issues/87#issuecomment-169266833
 */

// Grab $pre_aliases & $build_folders variables from aliases.drushrc.php in
// current dir.
$path_to_alias_file = dirname(__FILE__) . '/aliases.drushrc.php';
if (file_exists($path_to_alias_file)) {
  include $path_to_alias_file;
}

// Get the directory drush was launched from
// i.e the current directory in your terminal.
$cwd = drush_cwd();

// Compute list of root folder locations to
// check if we are running in multi site and no uri passed.
$roots = array();
foreach ($pre_aliases as $alias) {
  $roots[] = $alias['root'];
}

$root_dups = array();
// Returns an array using the values of array as keys and their
// frequency in array as values.
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
      if (drush_valid_root("{$alias['root']}/{$folder}/web")) {
        $options['root'] = "{$alias['root']}/{$folder}/web";
      }
      elseif (drush_valid_root("{$alias['root']}/{$folder}")) {
        $options['root'] = "{$alias['root']}/{$folder}";
      }
    }
    // Then set the drush uri to the uri in the alias.
    // if it's usable "single" site.
    if ($root_dups[$alias['root']] === TRUE) {
      $options['uri'] = $alias['uri'];
    }
    else {
      // Duplicate alias!
      // If --uri or -l manully passed, then drush will handle uri.
      // TL;DR; Do nothing here.
      $args = drush_get_arguments();
      if (!drush_get_option('uri') && !drush_sitealias_valid_alias_format($args[0])) {
        $cwd = drush_cwd();
        // If not, are inside the site specific folder?
        // if (DIRECTORY_SEPARATOR is "\", and it is windows convert it.)
        if (drush_is_windows() && strpos(DIRECTORY_SEPARATOR, '\\') !== FALSE) {
          $cwd = str_replace('/', '\\', $cwd);
        }
        // Site is a string of the site path, false if not valid.
        if ($site = drush_site_path($cwd)) {
          // Yes - use that uri.
          $uri = drush_sitealias_site_dir_from_filename($site . '/settings.php');
          $options['uri'] = $uri;
        }
        else {
          drush_log('WARNING! The current root has two or more aliases but none specified in the paramaters or no alias used! Pleaee Specify one, e.g. "--uri="mysite.com" or @mysite or run from [web_root]/sites/mysite/ folder. Continuing...', 'warning');
        }
      }
    }
  }
}
