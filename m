From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 33/44] includecheck fix: drivers/xen,
	evtchn.c
Date: Wed, 08 Jul 2009 09:50:42 -0700
Message-ID: <4A54CE62.8040704@goop.org>
References: <1247063308.4382.12.camel@ht.satnam>
	<1247067749.4382.90.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <1247067749.4382.90.camel@ht.satnam>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Cc: xen-devel@lists.xensource.com, jeremy@xensource.com, LKML <linux-kernel@vger.kernel.org>, chrisw@sous-sol.org, virtualization@lists.osdl.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: virtualization@lists.linuxfoundation.org

On 07/08/09 08:42, Jaswinder Singh Rajput wrote:
> fix the following 'make includecheck' warning:
>
>   drivers/xen/evtchn.c: linux/errno.h is included more than once.
>
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>
>   
Acked-by: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

Thanks,
    J

> ---
>  drivers/xen/evtchn.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
> index af03195..79bedba 100644
> --- a/drivers/xen/evtchn.c
> +++ b/drivers/xen/evtchn.c
> @@ -38,7 +38,6 @@
>  #include <linux/string.h>
>  #include <linux/errno.h>
>  #include <linux/fs.h>
> -#include <linux/errno.h>
>  #include <linux/miscdevice.h>
>  #include <linux/major.h>
>  #include <linux/proc_fs.h>
>   
