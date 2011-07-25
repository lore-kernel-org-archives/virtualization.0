From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen/pciback: remove duplicated #include
Date: Mon, 25 Jul 2011 09:55:02 -0400
Message-ID: <20110725135502.GA23212@dumpdata.com>
References: <1311409317-1508-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1311409317-1508-1-git-send-email-weiyi.huang@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jul 23, 2011 at 04:21:57PM +0800, Huang Weiyi wrote:
> Remove duplicated #include('s) in
>   drivers/xen/xen-pciback/xenbus.c

OK, queue it up.
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  drivers/xen/xen-pciback/xenbus.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
> index 206c4ce..978d2c6 100644
> --- a/drivers/xen/xen-pciback/xenbus.c
> +++ b/drivers/xen/xen-pciback/xenbus.c
> @@ -11,7 +11,6 @@
>  #include <xen/xenbus.h>
>  #include <xen/events.h>
>  #include <asm/xen/pci.h>
> -#include <linux/workqueue.h>
>  #include "pciback.h"
>  
>  #define	DRV_NAME	"xen-pciback"
> -- 
> 1.5.6.4
