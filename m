From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 05/26] Xen-paravirt_ops: paravirt_ops: hooks
	to set up initial pagetable
Date: Tue, 27 Feb 2007 11:09:42 +0100
Message-ID: <20070227100942.GB10827@elte.hu>
References: <20070227081337.434798469@goop.org>
	<20070227081630.650554241@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070227081630.650554241@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>, Chris Wright <chrisw@sous-sol.org>, Andi Kleen <ak@muc.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> ===================================================================
> --- a/include/asm-i386/pgtable.h
> +++ b/include/asm-i386/pgtable.h
> @@ -15,7 +15,10 @@
>  #include <asm/processor.h>
>  #include <asm/fixmap.h>
>  #include <linux/threads.h>
> +
> +#ifdef CONFIG_PARAVIRT		/* guarded to prevent cyclic dependency */
>  #include <asm/paravirt.h>
> +#endif

avoid the cyclic dependency to begin with?

	Ingo
