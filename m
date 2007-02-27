From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 04/26] Xen-paravirt_ops: Add pagetable
	accessors to pack and unpack pagetable entries
Date: Tue, 27 Feb 2007 11:08:50 +0100
Message-ID: <20070227100850.GA10827@elte.hu>
References: <20070227081337.434798469@goop.org>
	<20070227081630.311681690@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070227081630.311681690@goop.org>
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

> ===================================================================
> --- a/arch/i386/kernel/vmlinux.lds.S
> +++ b/arch/i386/kernel/vmlinux.lds.S
> @@ -21,6 +21,9 @@
>  #include <asm/page.h>
>  #include <asm/cache.h>
>  #include <asm/boot.h>
> +
> +#undef ENTRY
> +#undef ALIGN

hm, what's this? The reason is not documented.

> +#ifdef CONFIG_PARAVIRT
> +/* After pte_t, etc, have been defined */
> +#include <asm/paravirt.h>
> +#endif

hm - there's already a CONFIG_PARAVIRT conditional in 
asm-i386/paravirt.h.

	Ingo
