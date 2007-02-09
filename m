From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 4 of 7]  lguest: Config and headers
Date: Sat, 10 Feb 2007 10:41:55 +1100
Message-ID: <1171064515.15356.10.camel@localhost.localdomain>
References: <1171033146.2718.157.camel@localhost.localdomain>
	 <1171033383.2718.163.camel@localhost.localdomain>
	 <1171033436.2718.165.camel@localhost.localdomain>
	 <1171033484.2718.167.camel@localhost.localdomain>
	 <1171033741.2718.172.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0702091304090.9927@d.namei>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752558AbXBIXmm@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0702091304090.9927@d.namei>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, virtualization <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-02-09 at 13:15 -0500, James Morris wrote:
> On Sat, 10 Feb 2007, Rusty Russell wrote:
> 
> > +/* 64k ought to be enough for anybody! */
> > +#define HYPERVISOR_MAP_ORDER 16
> > +#define HYPERVISOR_PAGES ((1 << HYPERVISOR_MAP_ORDER)/PAGE_SIZE)
> 
> I think it'd be better to go back to defining HYPERVISOR_SIZE then derive 
> the map order from that via get_order(), as it should be 4 instead of 16; 
> and this code is now both implying PAGE_SIZE while also using it for 
> calculations. 

Well it was the use of get_order() which triggered Andi's alarm bells,
so I went back to deriving it.  This code is correct, however.

get_order() is one of those classic functions only a kernel coder could
love.  Look how lovingly it has been optimized:

#define get_order(n)							\
(									\
	__builtin_constant_p(n) ?					\
	((n < (1UL << PAGE_SHIFT)) ? 0 : ilog2(n) - PAGE_SHIFT) :	\
	__get_order(n, PAGE_SHIFT)					\
 )

All that time spent, yet no consideration that it should be called
"get_page_order()" or some name which hints that the divide by page size
is happening.  It's even documented in the comment above, so someone
thought it needed explaining.  Too bad they chose to explain it instead
of actually clarifying it. 8(

Cheers,
Rusty.
