#! /your/favourite/path/to/gem
# -*- mode: ruby; coding: utf-8; indent-tabs-mode: nil; ruby-indent-level: 2 -*-
# -*- frozen_string_literal: true -*-
# -*- warn_indent: true -*-

# Copyright (c) 2018 Urabe, Shyouhei
#
# Permission is hereby granted, free of  charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction,  including without limitation the rights
# to use,  copy, modify,  merge, publish,  distribute, sublicense,  and/or sell
# copies  of the  Software,  and to  permit  persons to  whom  the Software  is
# furnished to do so, subject to the following conditions:
#
#       The above copyright notice and this permission notice shall be
#       included in all copies or substantial portions of the Software.
#
# THE SOFTWARE  IS PROVIDED "AS IS",  WITHOUT WARRANTY OF ANY  KIND, EXPRESS OR
# IMPLIED,  INCLUDING BUT  NOT LIMITED  TO THE  WARRANTIES OF  MERCHANTABILITY,
# FITNESS FOR A  PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO  EVENT SHALL THE
# AUTHORS  OR COPYRIGHT  HOLDERS  BE LIABLE  FOR ANY  CLAIM,  DAMAGES OR  OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

Gem::Specification.new do |spec|
  spec.name          = 'consttime_memequal'
  spec.version       = 2
  spec.author        = 'Urabe, Shyouhei'
  spec.email         = 'shyouhei@ruby-lang.org'
  spec.summary       = 'provides consttime_memequal?'
  spec.description   = "Wrapper to OS-provided timing-safe memory comparison."
  spec.homepage      = 'https://github.com/shyouhei/consttime_memequal'
  spec.license       = 'MIT'
  spec.files         = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r'^(test|spec|features|samples)/')
  }
  spec.require_paths = %w'lib'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry' # used in bin/console
  spec.required_ruby_version =    '>= 2.0.0'
  spec.add_runtime_dependency     'fiddle'
end
