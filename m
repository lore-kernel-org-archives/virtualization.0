From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: porting lguest to x86_64
Date: Tue, 13 Feb 2007 13:17:29 +1100
Message-ID: <1171333049.19842.78.camel@localhost.localdomain>
References: <1171301371.4290.48.camel@localhost.localdomain>
	<1171328567.19842.53.camel@localhost.localdomain>
	<20070213013411.GA8965@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <20070213013411.GA8965@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: virtualization <virtualization@lists.osdl.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-02-12 at 23:34 -0200, Glauber de Oliveira Costa wrote:
> On Tue, Feb 13, 2007 at 12:02:47PM +1100, Rusty Russell wrote:
> > Yeah, sorry about that.  My very initial intention was to have x86-64
> > and PowerPC ports, but since the code is so arch-specific I decided that
> > it didn't make much sense at this point, so hence the move.
> =

> Steven Roasted forgot to mention that simplicity was not the main reason
> why we choosed lguest to pick up with. For me at least, the puppies were =
the
> very and true reason.

8)

> Other than that, our first attempt already put it in a separate drivers/x=
86_64
> directory. As Steven pointed out, there will probably be too few overlap =

> between architectures. IMHO, the move to arch/<arch>/lguest is very
> sane.

Indeed.

> > A few general points:
> > 1) The entire point of the paravirt_ops infrastructure is to allow a
> > single kernel to adapt to different hypervisors at runtime.  This is a
> > real feature which should not be ignored, IMHO.  Also, the "modprobe and
> > go" model of host kernels is extremely attractive.  So changing
> > PAGE_OFFSET or what segments the kernel uses is not the trivial matter
> > it would otherwise be.
> Although they are not included yet in mainline (for 64-bit), we think tha=
t =

> relocatable kernel capabilities would help a lot in this. Besides, we
> don't plan to move PAGE_OFFSET for the host, but rather for the guest,
> which needs to have compiled-in provisions anyway.

If you talk to distributions, they want the guest and host kernels to be
the same.  The overhead of including lguest support is under 5k, which
is why it's always compiled in, even in the host kernel.  I currently
don't allow the guest drivers as modules, because they're only 9k, but I
could.

A universal kernel is a really, really good idea.  You can make most of
the lguest-specific code __init, too...

> > 2) I would start really simple: no guest SMP, for example.  I would also
> > look hard at stealing KVM's mmu code: lguest's is much simpler, *but*
> > that's because it's only a simple 2-level.
> =

> I would agree with you, if having guest SMPs were a hard matter. I think
> it is not. The current read-in-a-loop could be replicated in user space
> threads, each of which running a different vcpu. =


Sure, it's easy, *but* it's a good idea to get the basics done first,
and this is a very easy thing to cut.

Good luck!
Rusty.
