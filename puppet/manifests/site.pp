#update package list before doing anything with Packages
exec { 'apt-update':
    command => '/usr/bin/apt-get update'
}
Exec['apt-update'] -> Package <| |>

#import node specific stuff
import 'nodes.pp'