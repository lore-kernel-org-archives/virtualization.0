From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 03/26] Xen-paravirt_ops: use paravirt_nop to
	consistently mark no-op operations
Date: Fri, 16 Mar 2007 10:44:32 +0100
Message-ID: <20070316094432.GU23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232526.261284776@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232526.261284776@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Add a _paravirt_nop function for use as a stub for no-op operations, 
> and paravirt_nop #defined void * version to make using it easier 
> (since all its uses are as a void *).
> 
> This is useful to allow the patcher to automatically identify noop 
> operations so it can simply nop out the callsite.

Acked-by: Ingo Molnar <mingo@elte.hu>

> +void _paravirt_nop(void);
> +#define paravirt_nop	((void *)_paravirt_nop)

but only as a cleanup of the current open-coded (void *) casts. My 
problem with this is that it loses the types. Not that there is much to 
check for, but still, this adds some assumptions about how function 
calls look like.

	Ingo
