Pod::Spec.new do |s|
  s.name             = 'Core'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Core.'
  s.description      = 'Core module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version    = '5.0'
  s.source_files     = 'Core/**/*'

end
