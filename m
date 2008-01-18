From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Fri, 18 Jan 2008 15:45:41 -0500
Message-ID: <47910FF5.20206__25239.045211538$1200694340$gmane$org@pobox.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190725.24271.rusty@rustcorp.com.au>
	<200801190727.36567.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801190727.36567.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tejun Heo <htejun@gmail.com>, linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Just a trivial example.
> ---
>  drivers/lguest/lguest_device.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff -r 00ab7672f658 drivers/lguest/lguest_device.c
> --- a/drivers/lguest/lguest_device.c	Thu Jan 17 16:54:00 2008 +1100
> +++ b/drivers/lguest/lguest_device.c	Thu Jan 17 16:59:46 2008 +1100
> @@ -179,9 +179,8 @@ static void lg_notify(struct virtqueue *
>  	hcall(LHCALL_NOTIFY, lvq->config.pfn << PAGE_SHIFT, 0, 0);
>  }
>  
> -static irqreturn_t lguest_interrupt(int irq, void *_vq)
> +static irqreturn_t lguest_interrupt(int irq, struct virtqueue *vq)
>  {
> -	struct virtqueue *vq = _vq;
>  	struct lguest_device_desc *desc = to_lgdev(vq->vdev)->desc;

Ugh.

This will be a compatibility nightmare.  I don't see how void* is so 
evil for this, or timers.

It's not like there's a huge cost associated with a pointer alias.

	Jeff
