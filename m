From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: PARAVIRT_SAVE_FLAGS_IRQ_DISABLE composite callsite
Date: Sun, 25 Feb 2007 21:49:49 -0800
Message-ID: <45E274FD.8090502@goop.org>
References: <45E159A7.7060709@goop.org>	
	<1172441227.13541.24.camel@localhost.localdomain>
	<45E22EF6.901@goop.org>
	<1172457828.13541.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1172457828.13541.39.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Originally it was just 24 bytes vs 12 bytes, it's probably less now.
> But as I said, it's *really* popular.  I don't have the numbers on me,
> but it's almost worth making it the default and implementing cli / sti
> in terms of save & restore 8)

Do you mean statically or dynamically popular.  I did a quick look at
the static usage in a PAE kernel:

(site id -> count)

1391 patch sites:
  82 -> 126    - pmd_val
  29 -> 117    - restore_fl
  91 -> 103    - save_fl+irq_disable
  57 -> 97     - apic_write
  28 -> 90     - save_fl
  35 -> 85     - read_msr
  ...

so you're right, safe_fl+irq_disable is very common in the static
count.  Each safe_fl+irq_disable site is 18 bytes vs 10 each for save_fl
and irq_disable on their own, so not fusing them would cost about 200
bytes of kernel text.  If we set the clobber for irq_disable to none,
then there would be no need to explicitly save/restore %eax over it.

The upside for removing it would be:

    * simpler having a 1:1 relationship between pv_ops functions and
      call site types
    * better patched code for less work - separate callsites can be
      patched by the generic patcher, but the combined callsite type
      will always need special casing

Well, that's it really, simpler.  I just had a bug as a result of its
special type, and from the comments in vmi.c it doesn't seem too popular
over there either.

    J
