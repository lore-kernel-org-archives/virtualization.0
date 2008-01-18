From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 3/3] Makes lguest's irq handler typesafe
Date: Sat, 19 Jan 2008 08:12:33 +0900
Message-ID: <47913261.5000708__30335.166763007$1200698236$gmane$org@gmail.com>
References: <200801190722.26154.rusty@rustcorp.com.au>
	<200801190725.24271.rusty@rustcorp.com.au>
	<200801190727.36567.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, Ash Willis <ashwillis@programmer.net>, Jeff Garzik <jgarzik@pobox.com>
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
>  
>  	if (unlikely(desc->config_change)) {

Type safety is good but I doubt this would be worth the complexity.  It
has some benefits but there's much larger benefit in keeping things in
straight C.  People know that functions take fixed types and are also
familiar with the convention of passing void * for callback arguments.
IMHO, staying in line with those common knowledges easily trumps having
type checking on interrupt handler.

Also, how often do we see a bug where things go wrong because interrupt
handler is given the wrong type of argument?  Even when such bug
happens, I doubt it can escape the developer's workstation if he/she is
paying any attention to testing.

Thanks.

-- 
tejun
