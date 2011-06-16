From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 09/11] xen/xenbus: use printk_ratelimited() instead of
	printk_ratelimit()
Date: Thu, 16 Jun 2011 14:00:39 -0700
Message-ID: <4DFA6EF7.9060702__46479.4650012211$1308260005$gmane$org@goop.org>
References: <cover.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
	<d2bc569719b3b1d8271d1f4b2c4080bbc7527e04.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <d2bc569719b3b1d8271d1f4b2c4080bbc7527e04.1308142053.git.manuel.f.zerpies@ww.stud.uni-erlangen.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, christian.dietrich@informatik.uni-erlangen.de, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/16/2011 05:14 AM, Manuel Zerpies wrote:
> Since printk_ratelimit() shouldn't be used anymore (see comment in
> include/linux/printk.h), replace it with printk_ratelimited()
>
Looks OK to me, but please fix the indentation of the rest of the
statement to match.

Thanks,
    J

> Signed-off-by: Manuel Zerpies <manuel.f.zerpies@ww.stud.uni-erlangen.de>
> ---
>  drivers/xen/xenbus/xenbus_xs.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 5534690..4055858 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -44,6 +44,7 @@
>  #include <linux/rwsem.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/ratelimit.h>
>  #include <xen/xenbus.h>
>  #include "xenbus_comms.h"
>  
> @@ -270,8 +271,7 @@ static void *xs_talkv(struct xenbus_transaction t,
>  	}
>  
>  	if (msg.type != type) {
> -		if (printk_ratelimit())
> -			printk(KERN_WARNING
> +		`printk_ratelimited(KERN_WARNING
>  			       "XENBUS unexpected type [%d], expected [%d]\n",
>  			       msg.type, type);
>  		kfree(ret);
