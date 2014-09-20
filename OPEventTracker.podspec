Pod::Spec.new do |spec|
  spec.name         = 'OPEventTracker'
  spec.version      = '0.1.0'
  spec.license      = { type: 'BSD' }
  spec.homepage     = 'https://github.com/mbrandonw/OPEventTracker'
  spec.authors      = { 'Brandon Williams' => 'mbw234@gmail.com' }
  spec.summary      = ''
  spec.source       = { :git => 'https://github.com/mbrandonw/OPEventTracker.git' }
  spec.source_files = '*.{h,m}'
  spec.requires_arc = true
end
