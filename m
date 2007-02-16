From: Keir Fraser <keir@xensource.com>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Fri, 16 Feb 2007 10:09:47 +0000
Message-ID: <C1FB336B.98D6%keir@xensource.com>
References: <45D55C4D.1060807@goop.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D55C4D.1060807@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

On 16/2/07 07:25, "Jeremy Fitzhardinge" <jeremy@goop.org> wrote:

>> Oh, so that's why it doesn't break when CONFIG_PREEMPT=y.  In which case
>> that preempt_disable() I spotted is wrong-and-unneeded.
>> 
>> Why doesn't Xen work with preemption??
> 
> I've forgotten the details.  Ian?  Keir?  Steven?  Maybe it can be done.

It breaks guest save/restore for us currently because threads can be
sleeping with machine addresses in local storage (registers, stack). There
are a few ways to achieve an acceptable solution:

 1. Put processes in the freezer when we suspend. This should avoid any
thread being in a critical section with machine addresses in its hand. We
haven't yet investigated the performance impact of freezing processes,
particularly on the downtime of live relocation.

 2. Allow CONFIG_PREEMPT to be compiled in, but disable it at runtime. We
could do this by, for example, reserving a bit in preempt_count() so that
most preemption checks do not touch any more cache lines. I guess it would
need a bit of fixing up (e.g., so that in_atomic() would not be always
asserted). Even better for us would be to allow switching between
involuntary and voluntary preemption at runtime. It looks as though the hook
points for these two techniques are not usually compiled in at the same
time, however.

 -- Keir
