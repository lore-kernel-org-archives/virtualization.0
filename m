From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH RFC] virtio-pci: new config layout: using memory BAR
Date: Wed, 29 May 2013 12:07:41 +0200
Message-ID: <51A5D36D.4010204@redhat.com>
References: <20130528160342.GA29915@redhat.com> <87bo7vvxej.fsf@codemonkey.ws>
	<20130528173257.GC30296@redhat.com>
	<51A4ECDE.1020207@redhat.com> <87mwremmm8.fsf@rustcorp.com.au>
	<51A5ADC6.3090002@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <51A5ADC6.3090002@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Anthony Liguori <aliguori@us.ibm.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux-foundation.org, Stefan Hajnoczi <stefanha@redhat.com>, KONRAD Frederic <fred.konrad@greensocs.com>
List-Id: virtualization@lists.linuxfoundation.org

On 05/29/13 09:27, Paolo Bonzini wrote:
> Il 29/05/2013 06:33, Rusty Russell ha scritto:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>> Il 28/05/2013 19:32, Michael S. Tsirkin ha scritto:
>>>>>>>> +
>>>>>>>> +    switch (addr) {
>>>>>>>> +    case offsetof(struct virtio_pci_common_cfg, device_feature_select):
>>>>>>>> +        return proxy->device_feature_select;
>>>>>>
>>>>>> Oh dear no...  Please use defines like the rest of QEMU.
>>>> Any good reason not to use offsetof?
>>>
>>> I'm not sure it's portable to use it in case labels.  IIRC, the
>>> definition ((int)&(((T *)0)->field)) is not a valid C integer constant
>>> expression.  Laszlo?
>>
>> It's defined to yield an integer constant expression in the ISO standard
>> (and I think ANSI too, though that's not at hand):
> 
> It's not in C89.

It is, see 7.1.6 Common definitions <stddef.h>.


> The oldest compiler QEMU cares about is GCC 4.2.  I
> don't know if it has a builtin offsetof, probably it does.

Talking about nothing else but the ISO C standard(s), it doesn't matter
how the C implementation deals with offsetof() internally. "C
implementation" in this sense includes both compiler and standard library.

If the standard library header (<stddef.h> or something internal
included by it) expands the offsetof() macro to replacement text that
does pointer black magic, magic that would be otherwise nonportable or
undefined, it is alright as long as the accompanying compiler guarantees
that the replacement text will work.

That is, offsetof() gives the C implementor leeway to implement it in
wherever "distribution" between compiler and standard library; the main
thing is that the C program use the one offsetof() provided by the C
implementation.

Of course in the FLOSS world OS distros might mix and match gcc and
glibc statistically randomly; normally some documentation should enable
the user to put his/her system into ISO C or even SUSv[1234] mode.

(

An interesting example for, say, "non-unified implementation" is
"getconf" vs. "c99". I'll pick SUSv3 for this example.

http://pubs.opengroup.org/onlinepubs/000095399/utilities/getconf.html
http://pubs.opengroup.org/onlinepubs/000095399/utilities/c99.html

In a nutshell one can interrogate getconf for CFLAGS, LDFLAGS and LIBS
so that c99 builds a program in ILP32_OFF32 / ILP32_OFFBIG / LP64_OFF64
/ LPBIG_OFFBIG mode ("programming environment").

On my x86_64 RHEL-6.4 laptop, "getconf" is part of glibc
(glibc-common-2.12-1.107.el6.x86_64), while c99 is part of gcc
(gcc-4.4.7-3.el6.x86_64).

Supposing I'd like to build a 32-bit program with 64-bit off_t:

  getconf _POSIX_V6_ILP32_OFFBIG
  1

  getconf -v POSIX_V6_ILP32_OFFBIG POSIX_V6_ILP32_OFFBIG_CFLAGS
  -m32 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64

  getconf -v POSIX_V6_ILP32_OFFBIG POSIX_V6_ILP32_OFFBIG_LDFLAGS
  -m32

  getconf -v POSIX_V6_ILP32_OFFBIG POSIX_V6_ILP32_OFFBIG_LIBS
  [empty string]

However if I try to actually build a program using these flags:

  #define _XOPEN_SOURCE 600
  int main(void) { return 0; }

  c99 \
      -m32 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 \
      -o mytest \
      -m32 \
      mytest.c

I get

  /usr/bin/ld: crt1.o: No such file: No such file or directory
  collect2: ld returned 1 exit status

unless I install "glibc-devel.i686".

This problem is rooted in "getconf" (a glibc utility) being unaware of
RHEL packaging choices: if the system can't guarantee the final c99
invocation to succeed, then the very first "getconf" invocation should
write "-1\n" or "undefined\n" to stdout.

(I'm aware that RHEL-6 is not certified UNIX 03; this is just an example
for problems caused by various parts of a standard's
(quasi-)implementation coming from separate projects. In that sense,
caring about the offsetof() internals may have merit.)

)

Laszlo
