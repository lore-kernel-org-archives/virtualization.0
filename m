Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76180C64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 07:30:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D5E4361102;
	Wed,  8 Mar 2023 07:30:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5E4361102
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nN6R3qTctnz4; Wed,  8 Mar 2023 07:30:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 30C4F60D63;
	Wed,  8 Mar 2023 07:30:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30C4F60D63
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B125C0035;
	Wed,  8 Mar 2023 07:30:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF6DDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 07:30:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F3EF60FAF
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 07:30:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F3EF60FAF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G19mgVtVOdpD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 07:30:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 79C9660D63
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 79C9660D63
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 07:30:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=16; SR=0;
 TI=SMTPD_---0VdOglLx_1678260623; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdOglLx_1678260623) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 15:30:23 +0800
Message-ID: <1678259647.118581-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net,
 stable v1 3/3] virtio_net: add checking sq is full inside xdp xmit
Date: Wed, 8 Mar 2023 15:14:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Yunsheng Lin <linyunsheng@huawei.com>
References: <20230308024935.91686-1-xuanzhuo@linux.alibaba.com>
 <20230308024935.91686-4-xuanzhuo@linux.alibaba.com>
 <7eea924e-5cc3-8584-af95-04587f303f8f@huawei.com>
In-Reply-To: <7eea924e-5cc3-8584-af95-04587f303f8f@huawei.com>
Cc: Yichun Zhang <yichun@openresty.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Wed, 8 Mar 2023 14:59:36 +0800, Yunsheng Lin <linyunsheng@huawei.com> wrote:
> On 2023/3/8 10:49, Xuan Zhuo wrote:
> > If the queue of xdp xmit is not an independent queue, then when the xdp
> > xmit used all the desc, the xmit from the __dev_queue_xmit() may encounter
> > the following error.
> >
> > net ens4: Unexpected TXQ (0) queue failure: -28
> >
> > This patch adds a check whether sq is full in xdp xmit.
> >
> > Fixes: 56434a01b12e ("virtio_net: add XDP_TX support")
> > Reported-by: Yichun Zhang <yichun@openresty.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/net/virtio_net.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 46bbddaadb0d..1a309cfb4976 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -767,6 +767,9 @@ static int virtnet_xdp_xmit(struct net_device *dev,
> >  	}
> >  	ret = nxmit;
> >
> > +	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
> > +		check_sq_full_and_disable(vi, dev, sq);
> > +
>
> Sorry if I missed something obvious here.
>
> As the comment in start_xmit(), the current skb is added to the sq->vq, so
> NETDEV_TX_BUSY can not be returned.
>
> 	/* If running out of space, stop queue to avoid getting packets that we
> 	 * are then unable to transmit.
> 	 * An alternative would be to force queuing layer to requeue the skb by
> 	 * returning NETDEV_TX_BUSY. However, NETDEV_TX_BUSY should not be
> 	 * returned in a normal path of operation: it means that driver is not
> 	 * maintaining the TX queue stop/start state properly, and causes
> 	 * the stack to do a non-trivial amount of useless work.
> 	 * Since most packets only take 1 or 2 ring slots, stopping the queue
> 	 * early means 16 slots are typically wasted.
> 	 */
>
> It there any reason not to check the sq->vq->num_free at the begin of start_xmit(),
> if the space is not enough for the current skb, TX queue is stopped and NETDEV_TX_BUSY
> is return to the stack to requeue the current skb.
>
> It seems it is the pattern that most network driver follow, and it seems we can avoid
> calling check_sq_full_and_disable() in this patch and not wasting 16 slots as mentioned
> in the comment above.
>



 * netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb,
 *                               struct net_device *dev);
 *	Called when a packet needs to be transmitted.
 *	Returns NETDEV_TX_OK.  Can return NETDEV_TX_BUSY, but you should stop
 *	the queue before that can happen; it's for obsolete devices and weird
 *	corner cases, but the stack really does a non-trivial amount
 *	of useless work if you return NETDEV_TX_BUSY.
 *	Required; cannot be NULL.

It does not affect the XDP TX. It is just that there are some waste on the
path of the protocol stack.

For example, TCP will do some unnecessary work based on the return value here.

Thanks.


>
> >  	if (flags & XDP_XMIT_FLUSH) {
> >  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> >  			kicks = 1;
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
