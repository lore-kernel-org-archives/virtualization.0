From: Andi Kleen <ak@muc.de>
Subject: Re: [patch 04/21] Xen-paravirt:
	===================================================================
Date: 16 Feb 2007 10:12:07 +0100
Message-ID: <20070216091207.GA28196@muc.de>
References: <20070216022449.739760547@goop.org>
	<20070216022530.755967483@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <xen-devel-bounces@lists.xensource.com>
Date: Fri, 16 Feb 2007 10:12:07 +0100
Content-Disposition: inline
In-Reply-To: <20070216022530.755967483@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Zachary Amsden <zach@vmware.com>, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


Subject? description?


On Thu, Feb 15, 2007 at 06:24:53PM -0800, Jeremy Fitzhardinge wrote:
> -static void vmi_set_pte_present(struct mm_struct *mm, unsigned long addr, pte_t *ptep, pte_t pte)
> +static void vmi_set_pte_present(struct mm_struct *mm, u32 addr, pte_t *ptep, pte_t pte)

And what good is that change anyways? unsigned long is the usual style
for addresses.

-Andi
