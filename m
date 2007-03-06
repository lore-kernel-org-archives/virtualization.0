From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Xen & VMI?
Date: Tue, 06 Mar 2007 08:42:32 -0800
Message-ID: <45ED99F8.9060705@goop.org>
References: <20070305120631.GA14105@elte.hu>
	<1173101297.26165.39.camel@localhost.localdomain>
	<1173142644.4644.6.camel@localhost.localdomain>
	<45ECBDDC.8080708@vmware.com> <45ECC076.9050209@goop.org>
	<45ECC91D.1020809@vmware.com> <45ECC9B6.1060209@goop.org>
	<20070306081909.GA9331@elte.hu> <45ED2F53.2040101@goop.org>
	<20070306092636.GC26073@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070306092636.GC26073@elte.hu>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Ingo Molnar <mingo@elte.hu>
Cc: virtualization <virtualization@lists.osdl.org>, Jan Beulich <jbeulich@novell.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

Ingo Molnar wrote:
> i think you are missing my point.
>
> paravirt_ops is a Linux-internal abstraction that tries to make our life =

> easier but it has no relevance whatsoever to an external hypervisor - be =

> that Xen, VMWare/ESX or Windows/Longhorn.
>   =


Of course it has relevance.  Linux is an important guest system, and not
supporting it would be a major problem.  I already have a list of things
which need to be done to Xen to make it work better with current kernels
- none of them mandatory, but nice to have.

> My suggestion would be for Linux to make only a /single/ external ABI =

> promise: VMI. (and we can extend it with higher-level paravirt ops, =

> etc.)
>   =


"VMI" is not a promise, it's just three letters.  It doesn't even mean
the same thing now as it did 12 months ago.  Turning "VMI" from three
letters into anything remotely like a promise is a huge amount of work
which requires:

   1. someone actually sit down and fully document what all those
      entrypoints are going to do
   2. everyone to implement them
   3. someone to test that all the implementations conform to the
      document (bearing in mind that if anyone is going to go to all
      this effort, they're going to use this with non-Linux guests)
   4. and repeat all that every subsequent update

That's assuming all the parties involved are approaching the process
with goodwill.  If someone wanted to effectively stall the kernel's
development (at least in terms of useful kernels that people can keep
shipping and deploying), then all they have to do is drag their heels on
this "VMI" interface process.  All this heavyweight process is very
enterprisy, but it doesn't help Linux at all.

And given that the idea of multiple implementations of a complex ABI
like this will actually conform to a spec and/or each other is pretty
much pie-in-the-sky, the kernel will still have to deal with all the
quirks of multiple implementations anyway.

    J
