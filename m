From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: porting lguest to x86_64
Date: Tue, 13 Feb 2007 12:02:47 +1100
Message-ID: <1171328567.19842.53.camel@localhost.localdomain>
References: <1171301371.4290.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171301371.4290.48.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: virtualization <virtualization@lists.osdl.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2007-02-12 at 12:29 -0500, Steven Rostedt wrote:
> Hi all,
> =

> Glauber and I have been looking into porting lguest over to the x86_64.
> We've spent the last couple of weeks just trying lguest out and seeing
> how far we can "force" it over to x86_64. This was more of just a
> learning experience to get our feet wet in lguest since we are still
> very green at it.  I also notice that lguest moves very fast (we were
> still working on drivers/lguest when I now see it has moved to
> arch/i386/lguest).

Yeah, sorry about that.  My very initial intention was to have x86-64
and PowerPC ports, but since the code is so arch-specific I decided that
it didn't make much sense at this point, so hence the move.

Plus, being in a single directory gives it that nice self-contained
feeling which makes upstream inclusion easier.

Now, at some point that decision might well be reversed...

> Anyway, we've decided that the work we have done so far was just a
> learning prototype and have thrown it out for some better ideas. But
> before getting too deep into coding, we want to ask the giants of lguest
> for their ideas, and their thoughts on what we want.

Well, there are many ways to write this.  Yours is very different,
that's for sure!

A few general points:
1) The entire point of the paravirt_ops infrastructure is to allow a
single kernel to adapt to different hypervisors at runtime.  This is a
real feature which should not be ignored, IMHO.  Also, the "modprobe and
go" model of host kernels is extremely attractive.  So changing
PAGE_OFFSET or what segments the kernel uses is not the trivial matter
it would otherwise be.

2) I would start really simple: no guest SMP, for example.  I would also
look hard at stealing KVM's mmu code: lguest's is much simpler, *but*
that's because it's only a simple 2-level.

3) The purpose of the high-loaded switcher code in lguest is to switch
the world back in a place where it can't be reached by the guest, due to
segment limits.  While this is not generally possible on x86-64, Andi
and Zach pointed out to me that a very similar approach is: use a
read-only page for this code, and a rw page to save & restore state.
When you go SMP for guests, you need a different page for each virtual
CPU of course, but that's later.  I haven't completely thought this
through, but it should work.

One benefit of this approach is that it *will* be v. v. similar to
32-bit lguest.  In fact, 32-bit lguest could probably be changed to use
the same technique without any real harm; indeed, it solves the problem
of 4G segments very nicely.... hm....

Cheers!
Rusty.
