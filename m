From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] xen: use iret directly where possible
Date: Mon, 4 Jun 2007 21:45:29 +0200
Message-ID: <200706042145.30339.ak@suse.de>
References: <46646662.9020707@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761144AbXFDTps@vger.kernel.org>
In-Reply-To: <46646662.9020707@goop.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Xen-devel <xen-devel@lists.xensource.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org



Not sure what a recursive exception is. You mean the interrupt?

It looks ...very... ug^w^wcomplicated.

>  - If the interrupt causes a softirq to be queued, we will return to
>    userspace without processing it, since its already after the point at
>    which we look for queued softirqs.  This means it could be an
>    unbounded amount of time before it gets processed on next kernel
>    entry.

That doesn't make sense. softirqs get processed after interrupts,
not on return to user space. So the nested interrupt should handle
its own softirqs because the softirq counters are already decreased.

>  - If the interrupt causes a signal to be delivered to the current process,
>    the signal will be marked pending on the process, but it will not
>    get delivered because we're past the point where pending signals
>    are detected.  Again, it could be an unbounded amount of time
>    before the signal gets delivered.

It's still not clear to me why you can't do cli ; check again ; iret-equivalent
to handle this.
 
>  - The recursion is, in theory, unbounded.  There's a small chance that
>    a series of unfortunate events will cause the exception frames to
>    build up and overrun the stack.  But that's very unlikely.

Doesn't seem to be different to me than a normal interrupt anywhere
else. If you're worried about overflow use interrupt stacks.

-Andi
