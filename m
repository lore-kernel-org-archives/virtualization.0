From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Wed, 20 Sep 2006 10:07:02 +1000
Message-ID: <1158710822.2480.14.camel@localhost.localdomain>
References: <1158635617.21726.8.camel@localhost.localdomain>
	<450FA6FB.9020100@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <450FA6FB.9020100@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, James.Bottomley@steeleye.com, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2006-09-19 at 01:14 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > 	The first patch simply changes the GDTs to be a straight per-cpu
> > variable.  I notice that you did a similar thing with your patches, but
> > this is simpler and avoids wasting space in the UP case.  It's a bit
> > tricky since we've never referred to per-cpu vars from asm before, but
> > since we're only referring to the pre-setup versions, it's ok.
> >   =

> =

> The current mechanism was specifically introduced by James Bottomley a =

> while back; I guess to deal with Voyager strangeness.

(James CC'd).  I dislike the gratuitous copy: we have three gdts, the
boot GDT, the master GDT (cpu_gdt_table), then the per-cpu GDT.  Using
the per-cpu mechanisms already in place makes it simple, avoids manual
allocation, and the extra master GDT.  The extra GDT is particularly
embarrassing on UP, which doesn't want a per-cpu GDT anyway...

Seems that we can't assume boot CPU =3D=3D 0.  I think I've removed the two
places where I assumed that, but will need testing.

> Hm, now is not really a good time.  I'm still trying to get Xen =

> basically working, and the percpu PDA stuff isn't really necessary for =

> that.  The PDA stuff was enough of a problem in itself...
> =

> Also, the PDA patches are in -mm, so that's probably a better base for =

> your patches.

Yes, it turned out to be easier to go straight to -mm anyway.  I'll redo
them as Andi requested....

Rusty.
-- =

Help! Save Australia from the worst of the DMCA: http://linux.org.au/law
