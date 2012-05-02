Pod::Spec.new do |s|
  s.name     = 'OPEventTracker'
  s.version  = '0.1'
  s.license  = 'MIT'
  
  s.summary  = 'The simplest way to answer the question: "Are there any UI events taking place right now?"'
  s.homepage = 'https://github.com/mbrandonw/OPEventTracker'
  s.author   = { 'Brandon Williams' => 'brandon@opetopic.com' }
  s.source   = { :git => 'git@github.com:mbrandonw/OPEventTracker.git' }
  
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
