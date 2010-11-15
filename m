From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH -next] xen: fix header export to userspace
Date: Mon, 15 Nov 2010 10:15:43 -0800
Message-ID: <4CE178CF.3020308@goop.org>
References: <20101112130547.c2a3c2c1.sfr@canb.auug.org.au>
	<20101113084439.d21bd0f0.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20101113084439.d21bd0f0.randy.dunlap@oracle.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tony Finch <dot@dotat.at>, LKML <linux-kernel@vger.kernel.org>, "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>, "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, akpm <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On 11/13/2010 08:44 AM, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>
> scripts/headers_install.pl prevents "__user" from being exported
> to userspace headers, so just use compiler.h to make sure that
> __user is defined and avoid the error.
>
> unifdef: linux-next-20101112/xx64/usr/include/xen/privcmd.h.tmp: 79: Premature EOF (#if line 33 depth 1)

Ah, OK, thanks.  I was wondering what the proper fix for this was.  I'll
stick this in my tree.

Thanks,
    J

> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> Cc:	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> Cc:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc:	xen-devel@lists.xensource.com (moderated for non-subscribers)
> Cc:	virtualization@lists.osdl.org
> Cc:	Tony Finch <dot@dotat.at>
> ---
>  include/xen/privcmd.h |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> --- linux-next-20101112.orig/include/xen/privcmd.h
> +++ linux-next-20101112/include/xen/privcmd.h
> @@ -34,13 +34,10 @@
>  #define __LINUX_PUBLIC_PRIVCMD_H__
>  
>  #include <linux/types.h>
> +#include <linux/compiler.h>
>  
>  typedef unsigned long xen_pfn_t;
>  
> -#ifndef __user
> -#define __user
> -#endif
> -
>  struct privcmd_hypercall {
>  	__u64 op;
>  	__u64 arg[5];
