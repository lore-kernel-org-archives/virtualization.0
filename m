From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] xen-blkfront: use bitmap_set() and bitmap_clear()
Date: Fri, 20 Jan 2012 10:28:19 -0500
Message-ID: <20120120152819.GA3959@phenom.dumpdata.com>
References: <1327072528-8479-1-git-send-email-akinobu.mita@gmail.com>
	<1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: xen-devel@lists.xensource.com, akpm@linux-foundation.org, Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, Jan 21, 2012 at 12:15:26AM +0900, Akinobu Mita wrote:
> Use bitmap_set and bitmap_clear rather than modifying individual bits
> in a memory region.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: xen-devel@lists.xensource.com
> Cc: virtualization@lists.linux-foundation.org
> ---
>  drivers/block/xen-blkfront.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 2f22874..619868d 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -43,6 +43,7 @@
>  #include <linux/slab.h>
>  #include <linux/mutex.h>
>  #include <linux/scatterlist.h>
> +#include <linux/bitmap.h>
>  
>  #include <xen/xen.h>
>  #include <xen/xenbus.h>
> @@ -177,8 +178,7 @@ static int xlbd_reserve_minors(unsigned int minor, unsigned int nr)
>  
>  	spin_lock(&minor_lock);
>  	if (find_next_bit(minors, end, minor) >= end) {
> -		for (; minor < end; ++minor)
> -			__set_bit(minor, minors);
> +		bitmap_set(minors, minor, nr);

Hm, I would have thought the last argument should have been 'end'?

Did you test this patch with a large amount of minors?

>  		rc = 0;
>  	} else
>  		rc = -EBUSY;
> @@ -193,8 +193,7 @@ static void xlbd_release_minors(unsigned int minor, unsigned int nr)
>  
>  	BUG_ON(end > nr_minors);
>  	spin_lock(&minor_lock);
> -	for (; minor < end; ++minor)
> -		__clear_bit(minor, minors);
> +	bitmap_clear(minors,  minor, nr);

Ditto.
>  	spin_unlock(&minor_lock);
>  }
>  
> -- 
> 1.7.4.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
