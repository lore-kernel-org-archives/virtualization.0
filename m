From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config
	options and disable unsupported config options.
Date: Sat, 17 Feb 2007 15:04:35 +1100
Message-ID: <1171685075.18876.21.camel@localhost.localdomain>
References: <C1FB336B.98D6%keir@xensource.com> <45D58531.4010808@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D58531.4010808@vmware.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Zachary Amsden <zach@vmware.com>
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, Andrew Morton <akpm@linux-foundation.org>, Keir Fraser <keir@xensource.com>, Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-16 at 02:19 -0800, Zachary Amsden wrote:
> Doesn't stop_machine_run already take care of getting you out of all 
> kernel threads?  So you can only be sleeping, not preempted, in which 
> case, this might not be an issue?

No, stop_machine only protects against preempt-disabled regions.

I thought about making that particularly hammer bigger, but noone had
needed it yet.  It would simply require a runtime way of disabling
further preemption and flushing preempted threads (AFAICT there can be
no deadlock issues with this).

Rusty.
