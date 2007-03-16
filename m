From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 05/26] Xen-paravirt_ops: paravirt_ops: hooks
	to set up initial pagetable
Date: Fri, 16 Mar 2007 10:33:48 +0100
Message-ID: <20070316093348.GS23174@elte.hu>
References: <20070301232443.195603797@goop.org>
	<20070301232526.611972133@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Content-Disposition: inline
In-Reply-To: <20070301232526.611972133@goop.org>
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

> This patch introduces paravirt_ops hooks to control how the kernel's
> initial pagetable is set up.

looks good. Some minor nits:

> +	/* Make sure kernel address space is empty so that a pagetable
> +	   will be allocated for it. */

comment style.

> +	/* Enable PSE if available */
> +	if (cpu_has_pse) {
> +		set_in_cr4(X86_CR4_PSE);
> +	}

unnecessary braces.

	Ingo
