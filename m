From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: Re: porting lguest to x86_64
Date: Mon, 12 Feb 2007 23:34:11 -0200
Message-ID: <20070213013411.GA8965@redhat.com>
References: <1171301371.4290.48.camel@localhost.localdomain>
	<1171328567.19842.53.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1171328567.19842.53.camel@localhost.localdomain>
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
Cc: virtualization <virtualization@lists.osdl.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 13, 2007 at 12:02:47PM +1100, Rusty Russell wrote:
> On Mon, 2007-02-12 at 12:29 -0500, Steven Rostedt wrote:
> > Hi all,
> > =

> > Glauber and I have been looking into porting lguest over to the x86_64.
> > We've spent the last couple of weeks just trying lguest out and seeing
> > how far we can "force" it over to x86_64. This was more of just a
> > learning experience to get our feet wet in lguest since we are still
> > very green at it.  I also notice that lguest moves very fast (we were
> > still working on drivers/lguest when I now see it has moved to
> > arch/i386/lguest).
> =

> Yeah, sorry about that.  My very initial intention was to have x86-64
> and PowerPC ports, but since the code is so arch-specific I decided that
> it didn't make much sense at this point, so hence the move.
> =

> Plus, being in a single directory gives it that nice self-contained
> feeling which makes upstream inclusion easier.
> =

> Now, at some point that decision might well be reversed...

Steven Roasted forgot to mention that simplicity was not the main reason
why we choosed lguest to pick up with. For me at least, the puppies were the
very and true reason.

Other than that, our first attempt already put it in a separate drivers/x86=
_64
directory. As Steven pointed out, there will probably be too few overlap =

between architectures. IMHO, the move to arch/<arch>/lguest is very
sane.

> A few general points:
> 1) The entire point of the paravirt_ops infrastructure is to allow a
> single kernel to adapt to different hypervisors at runtime.  This is a
> real feature which should not be ignored, IMHO.  Also, the "modprobe and
> go" model of host kernels is extremely attractive.  So changing
> PAGE_OFFSET or what segments the kernel uses is not the trivial matter
> it would otherwise be.
Although they are not included yet in mainline (for 64-bit), we think that =

relocatable kernel capabilities would help a lot in this. Besides, we
don't plan to move PAGE_OFFSET for the host, but rather for the guest,
which needs to have compiled-in provisions anyway.

> =

> 2) I would start really simple: no guest SMP, for example.  I would also
> look hard at stealing KVM's mmu code: lguest's is much simpler, *but*
> that's because it's only a simple 2-level.

I would agree with you, if having guest SMPs were a hard matter. I think
it is not. The current read-in-a-loop could be replicated in user space
threads, each of which running a different vcpu. =

For example, ee could start up the first, and get interrupted when it is
time to initialize other vcpus at kernel initialization. It also
simplifies user space management a lot. We gain, for example,
vcpu-pinning for free from the sched_setaffinity() syscalls.

Regarding the 4-level pagetable, it is definitely much more complicated.
Tip is appreciated, thanks!
 =


-- =

Glauber de Oliveira Costa
Red Hat Inc.
"Free as in Freedom"
