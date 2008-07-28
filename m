From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: drivers/xen/balloon.c: Removed duplicated include
Date: Mon, 28 Jul 2008 10:48:19 -0700
Message-ID: <488E0663.3070802@goop.org>
References: <20080726115509.F23D.WEIYI.HUANG@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20080726115509.F23D.WEIYI.HUANG@gmail.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: chrisw@sous-sol.org, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, xen-devel@lists.xensource.com, jeremy@xensource.com
List-Id: virtualization@lists.linuxfoundation.org

Huang Weiyi wrote:
> Removed duplicated include file <linux/highmem.h> in 
> drivers/xen/balloon.c.
>
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
>   

Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index d4427cb..afdeac5 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -41,7 +41,6 @@
>  #include <linux/pagemap.h>
>  #include <linux/highmem.h>
>  #include <linux/mutex.h>
> -#include <linux/highmem.h>
>  #include <linux/list.h>
>  #include <linux/sysdev.h>
>
>
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>   
