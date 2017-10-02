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
    // If --uri or -l manully passed, then drush will handle uri.
    // TL;DR; Do nothing here.
    $args = drush_get_arguments();
    if (!drush_get_option('uri') && !drush_sitealias_valid_alias_format($args[0])) {
      // Before blinding setting the alias,
      // check if we in a site specific folder first.
      $cwd = drush_cwd();
      // If (DIRECTORY_SEPARATOR is "\", and it is windows convert it),
      // required for drush_site_path().
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
        // Not in a specific site folder, can we fall back one to one alias?
        // But lets only do this if this is only actually one one site.
        // Simulating the bleow line - it's too slow - 60sec to process.
        // @codingStandardsIgnoreStart
        // $sites = _drush_find_local_sites_in_sites_folder($options['root']);
        // @codingStandardsIgnoreEnd
        $sites = array();
        $base_path = $options['root'] . '/sites';
        $files = drush_scan_directory($base_path, '/settings\.php/', array('.', '..', 'CVS', 'all'), 0, 1, 'filename', 1);
        foreach ($files as $filename => $info) {
          if ($info->basename == 'settings.php') {
            $sites[] = 'mypath#uriplaceholder';
          }
        }
        // End _drush_find_local_sites_in_sites_folder() simulation.
        if ((count($sites) === 1) && ($root_dups[$alias['root']] === TRUE)) {
          $options['uri'] = $alias['uri'];
        }
        else {
          // Nope, duplicate aliases or duplicate sites so no fallback can work.
          drush_log('WARNING! The current root has two or more aliases/sites but none specified in the paramaters or no alias used! Please Specify one, e.g. "--uri="mysite.com" or @mysite or run from [web_root]/sites/mysite/ folder. Continuing...', 'warning');
        }
      }
    }
  }
}
