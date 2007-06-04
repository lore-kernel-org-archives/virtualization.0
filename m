From: Andi Kleen <ak@suse.de>
Subject: Re: Re: [PATCH] xen: use iret directly where possible
Date: Mon, 4 Jun 2007 23:05:04 +0200
Message-ID: <200706042305.05340.ak@suse.de>
References: <46646662.9020707@goop.org> <200706042145.30339.ak@suse.de>
	<4664772A.20602@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <4664772A.20602@goop.org>
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
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Andrew Morton <akpm@linux-foundation.org>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Monday 04 June 2007 22:33, Jeremy Fitzhardinge wrote:

> Hm, yes, I guess so.  I'd assumed that softirq was in the WORK_NEEDED
> path of entry.S without checking; but anything which can set one of the
> WORK_NEEDED flags is an issue.

For interrupts it can be only signals or rescheduling.

> >>  - If the interrupt causes a signal to be delivered to the current
> >> process, the signal will be marked pending on the process, but it will
> >> not get delivered because we're past the point where pending signals are
> >> detected.  Again, it could be an unbounded amount of time before the
> >> signal gets delivered.
> >
> > It's still not clear to me why you can't do cli ; check again ;
> > iret-equivalent to handle this.
>
> Well, we use the real iret instruction to actually transition into
> userspace; obviously we can't do anything after that, and there's always
> going to be an open window before it because we can't do anything
> instruction-level atomic.

If you stay cli you don't need that. Why is it that it has to enable 
interrupts?

> In your sequence, the event may become pending after "check again", even
> though it won't be delivered. 

sti only takes affect one instruction after it. So if you can make 
it that small it would also work. But that might not help you.

-Andi
