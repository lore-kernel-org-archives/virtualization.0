From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 14/33] xen: xen time implementation
Date: Wed, 6 Jun 2007 12:26:10 +0200
Message-ID: <200706061226.11326.ak@suse.de>
References: <20070522140941.802382212@goop.org>
	<46668EC6.76E4.0078.0@novell.com> <466686E2.4040004@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <466686E2.4040004@goop.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jiri Bohac <jbohac@suse.cz>, Xen-devel <xen-devel@lists.xensource.com>, lkml <linux-kernel@vger.kernel.org>, Jan Beulich <jbeulich@novell.com>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 06 June 2007 12:05:22 Jeremy Fitzhardinge wrote:
> Jan Beulich wrote:
> > Xen itself knows to deal with this (by using an error correction factor to
> > slow down the local [TSC-based] clock), but for the kernel such a situation
> > may be fatal: If clocksource->cycle_last was most recently set on a CPU
> > with shadow->tsc_to_nsec_mul sufficiently different from that where
> > getnstimeofday() is being used, timekeeping.c's __get_nsec_offset() will
> > calculate a huge nanosecond value (due to cyc2ns() doing unsigned
> > operations), worth abut 4000s. This value may then be used to set a
> > timeout that was intended to be a few milliseconds, effectively yielding
> > a hung app (and perhaps system).
> >   
> 
> Hm.  I had a similar situation in the stolen time code, and I ended up
> using signed values so I could clamp at zero.  Though that might have
> been another bug; either way, the clamp is still there.
> 
> I wonder if cyc2ns might not be better using signed operations?  Or
> perhaps better, the time code should endevour to do things on a
> completely per-cpu basis (haven't really given this any thought).

This is being worked on.


> > Unfortunately so far I haven't been able to think of a reasonable solution
> > to this - a simplistic approach like making xen_clocksource_read() check
> > the value it is about to return against the last value it returned doesn't
> > seem to be a good idea (time might appear to have stopped over some
> > period of time otherwise), nor does attempting to adjust the shadowed
> > tsc_to_nsec_mul values (because the kernel can't know whether it should
> > boost the lagging CPU or throttle the rushing one).
> 
> I once had some code in there to do that, implemented in very boneheaded
> way with a spinlock to protect the "last time returned" variable.  I
> expect there's a better way to implement it.

But any per CPU setup likely needs this to avoid non monotonicity 

-Andi
