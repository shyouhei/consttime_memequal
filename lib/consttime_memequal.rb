#! /your/favourite/path/to/ruby
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

dlsym = lambda do |symbol, lib = 'fiddle'|
  begin
    gem lib if RUBY_VERSION >= '2.3.0'
    require lib
    libc = Fiddle.dlopen nil
    ptr  = libc.sym symbol
    func = Fiddle::Function.new ptr, \
      [Fiddle::TYPE_VOIDP, Fiddle::TYPE_VOIDP, Fiddle::TYPE_SIZE_T], \
      Fiddle::TYPE_INT,
      name: symbol
  rescue Fiddle::DLError
    return nil
  rescue LoadError
    return nil
  else
    return func
  end
end

case
when func = dlsym.call('consttime_memequal') then
  define_method :consttime_memequal? do |this, that, len = this.bytesize|
    src = Fiddle::Pointer.to_ptr this
    dst = Fiddle::Pointer.to_ptr that
    ret = func.call src, dst, len
    case ret
    when 1 then return true
    when 0 then return false
    else raise RuntimeError, \
      "consttime_memequal(3) returned unknown value: #{ret.inspect}"
    end
  end

when func = dlsym.call('timingsafe_memcmp') then
  define_method :consttime_memequal? do |this, that, len = this.bytesize|
    src = Fiddle::Pointer.to_ptr this
    dst = Fiddle::Pointer.to_ptr that
    ret = func.call src, dst, len
    return ret == 0
  end

when func = dlsym.call('timingsafe_bcmp') then
  define_method :consttime_memequal? do |this, that, len = this.bytesize|
    src = Fiddle::Pointer.to_ptr this
    dst = Fiddle::Pointer.to_ptr that
    ret = func.call src, dst, len
    return ret == 0
  end

when func = dlsym.call('CRYPTO_memcmp', 'openssl') then
  define_method :consttime_memequal? do |this, that, len = this.bytesize|
    src = Fiddle::Pointer.to_ptr this
    dst = Fiddle::Pointer.to_ptr that
    ret = func.call src, dst, len
    return ret == 0
  end

else
  raise <<-"end".strip unless func
    No timing-safe memory comparison routine found.
    We don't plan to implement one for you.
    Use other secure OS.
  end
end
