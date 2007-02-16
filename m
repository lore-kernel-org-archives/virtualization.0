From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [patch 14/21] Xen-paravirt: Add XEN config options
 and disable unsupported config options.
Date: Thu, 15 Feb 2007 23:25:01 -0800
Message-ID: <45D55C4D.1060807@goop.org>
References: <20070216022449.739760547@goop.org>	<20070216022531.570154735@goop.org>	<45D54BD5.8010707@vmware.com>
	<20070215230611.d89e26be.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20070215230611.d89e26be.akpm@linux-foundation.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, virtualization@lists.osdl.org, Steven Hand <steven.hand@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 22:14:45 -0800 Dan Hecht <dhecht@vmware.com> wrote:
>
>   
>>>  config PREEMPT
>>>  	bool "Preemptible Kernel (Low-Latency Desktop)"
>>> +	depends on !XEN
>>>  	help
>>>  	  This option reduces the latency of the kernel by making
>>>  	  all kernel code (that is not executing in a critical section)
>>>
>>>       
>
> Oh, so that's why it doesn't break when CONFIG_PREEMPT=y.  In which case
> that preempt_disable() I spotted is wrong-and-unneeded.
>
> Why doesn't Xen work with preemption??
>   

I've forgotten the details.  Ian?  Keir?  Steven?  Maybe it can be done.

    J
