class add_user_v1 {

  user { 'user3':
    ensure     => 'present',
    managehome => true,
  }

}

