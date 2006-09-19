From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Per-cpu patches on top of PDA stuff...
Date: Tue, 19 Sep 2006 01:14:51 -0700
Message-ID: <450FA6FB.9020100@goop.org>
References: <1158635617.21726.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1158635617.21726.8.camel@localhost.localdomain>
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
Cc: Andrew Morton <akpm@osdl.org>, virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> 	The first patch simply changes the GDTs to be a straight per-cpu
> variable.  I notice that you did a similar thing with your patches, but
> this is simpler and avoids wasting space in the UP case.  It's a bit
> tricky since we've never referred to per-cpu vars from asm before, but
> since we're only referring to the pre-setup versions, it's ok.
>   =


The current mechanism was specifically introduced by James Bottomley a =

while back; I guess to deal with Voyager strangeness.

As far as setting up the PDA in head.S goes, it turns out to be very =

easy without having to access any per-cpu data, since the whole CPU =

bringup stuff depends on static variables anyway.

> 	The second patch changes gs to be the per-cpu offset, and by
> implication, avoids using it altogether on UP.  This avoids a special
> "pda" structure, instead allowing all per-cpu variables to be accessed
> this way.  It avoids __thread, which I gave up after creating a horribly
> complicated patch which still didn't quite work, and was no more
> efficient if we want the kernel to run under Xen anyway.
>
> I really think this is the way to go, and I'll start work on merging
> now.

Hm, now is not really a good time.  I'm still trying to get Xen =

basically working, and the percpu PDA stuff isn't really necessary for =

that.  The PDA stuff was enough of a problem in itself...

Also, the PDA patches are in -mm, so that's probably a better base for =

your patches.

    J
