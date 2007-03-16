From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 23/26] Xen-paravirt_ops: Add Xen grant table
	support
Date: Fri, 16 Mar 2007 09:51:07 +0100
Message-ID: <20070316085107.GC23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232529.139074125@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232529.139074125@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>, Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add Xen 'grant table' driver which allows granting of access to 
> selected local memory pages by other virtual machines and, 
> symmetrically, the mapping of remote memory pages which other virtual 
> machines have granted access to.
> 
> This driver is a prerequisite for many of the Xen virtual device 
> drivers, which grant the 'device driver domain' restricted and 
> temporary access to only those memory pages that are currently 
> involved in I/O operations.

> +
> +#ifndef __ia64__
> +	{

introduce a proper arch method instead.

> +	unsigned long flags;
> +	int ref;
> +	grant_ref_t head;
> +	spin_lock_irqsave(&gnttab_list_lock, flags);

> +	unsigned long flags;
> +	spin_lock_irqsave(&gnttab_list_lock, flags);

> +	unsigned long flags;
> +	int count = 1;
> +	if (head == GNTTAB_LIST_END)

> +	grant_ref_t g = *private_head;
> +	if (unlikely(g == GNTTAB_LIST_END))

coding style problems.

	Ingo
