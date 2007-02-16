From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Thu, 15 Feb 2007 23:04:36 -0800
Message-ID: <45D55784.1020000@goop.org>
References: <20070216022449.739760547@goop.org>
	<20070216022531.570154735@goop.org> <45D54BD5.8010707@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D54BD5.8010707@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Dan Hecht <dhecht@vmware.com>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dan Hecht wrote:
> 1) Complete the xen paravirt-ops backend so it can handle these
> "incompatible" options.  I realize this is just a matter of time (at
> least for most of them, what is your plan for PREEMPT?).

Hope it will go away?  There's some relatively deep reason to do with
migration which makes preempt very difficult to support, but I've
forgotten the details.  I've been wondering if there's some way to make
it runtime selectable without massive performance cost.

> 2) Disable the option at runtime only if the kernel is booted on Xen.
> When the kernel is booted on native, lhype, paravirt kvm, vmware, etc
> it should be not be inhibited.  This may not be feasible for all of
> these options, but as Zach pointed out, is easy enough for
> DOUBLEFAULT.  Maybe it can be done for KEXEC?  And HZ is easy to allow
> too, even though Xen will still give interrupts at 100hz -- we do this
> when you boot on VMI.  PREEMPT is probably the only real compile time
> incompatible options with Xen.  You just simply have to change the
> loop decrementors in your timer interrupt.
>
> You basically chose #2 for SMP: while your backend doesn't support it
> yet, it's not harmful to have the config option enabled; you just
> don't allow a second vcpu to startup when running on Xen.

Yes, this has been my preferred approach.  So for each of the restrictions:
PREEMPT - hard, will try to do something at runtime
HZ - I'm assuming dynticks will appear in the short term, and this will
become moot
KEXEC - there's been some work on making KEXEC and Xen play nicely
together; I was waiting to see if that matures, and/or make it runtime
switchable in the meantime
DOUBLEFAULT - not really an issue; guests won't get them under Xen (I
think) and we can ignore setting the gate pretty easily

    J
