Pod::Spec.new do |s|
  s.name         = 'AYGenericCollectionNodeController'
  s.version      = '1.0.0'
  s.license  = { :type => 'MIT'}
  s.summary      = 'iOS component to configure TableViews.'
  s.homepage = 'https://github.com/ay8s/AYGenericTableNodeController'
  s.author = {
    'arconsis IT-Solutions GmbH' => 'jonas.stubenrauch@arconsis.com'
  }
  s.source = {
    :git => 'https://github.com/ay8s/AYGenericTableNodeController.git',
    :tag => '1.0.2'
  }
  s.platform = :ios,'5.0'
  s.source_files = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true
end
