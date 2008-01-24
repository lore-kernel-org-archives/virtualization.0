From: Dor Laor <dor.laor@gmail.com>
Subject: Re: [PATCH 2/2] virtio reset support
Date: Thu, 24 Jan 2008 15:09:07 +0200
Message-ID: <1201180147.7100.35.camel__14559.1906075881$1201191135$gmane$org@localhost.localdomain>
References: <200801240116.26160.rusty@rustcorp.com.au>
	<200801240118.09032.rusty@rustcorp.com.au>
Reply-To: dor.laor@gmail.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200801240118.09032.rusty@rustcorp.com.au>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The patches really fix/simplify things :) 
Did you test device open->close->open? It was broken in my last test,
we cad add link indications too.

Besides that I also remembered that adding 'vq->num_free =vq->ring.num;'
after reset fixed part of the problems, I don't remember why (gonna
re-check it soon), I think it was the reset calls for (..) detach_buf 
for all buffers regardless if they were free already.
Cheers,
Dor


On Thu, 2008-01-24 at 01:18 +1100, Rusty Russell wrote:
> diff -r f9464b21ed9c drivers/net/virtio_net.c
> --- a/drivers/net/virtio_net.c  Wed Jan 23 23:52:47 2008 +1100
> +++ b/drivers/net/virtio_net.c  Thu Jan 24 00:47:05 2008 +1100
> @@ -415,12 +415,10 @@ static void virtnet_remove(struct virtio
>         struct sk_buff *skb;
>  
>         /* Free our skbs in send and recv queues, if any. */
> -       vi->rvq->vq_ops->shutdown(vi->rvq);
>         while ((skb = __skb_dequeue(&vi->recv)) != NULL) {
>                 kfree_skb(skb);
>                 vi->num--;
>         }
> -       vi->svq->vq_ops->shutdown(vi->svq);
>         while ((skb = __skb_dequeue(&vi->send)) != NULL)
>                 kfree_skb(skb);
