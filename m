Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33724C636CC
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:55:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BA59B80B49;
	Fri,  3 Feb 2023 08:55:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA59B80B49
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id z6fX9O7QOBuK; Fri,  3 Feb 2023 08:55:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4C69580B5E;
	Fri,  3 Feb 2023 08:55:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C69580B5E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12A34C0032;
	Fri,  3 Feb 2023 08:55:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F1F0C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EB669405B5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EB669405B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a3p2ymOMqKgI
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 78753401D5
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78753401D5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:55:52 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaoDSAa_1675414545; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaoDSAa_1675414545) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 16:55:46 +0800
Message-ID: <1675414526.084923-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 29/33] virtio_net: xsk: tx: support tx
Date: Fri, 3 Feb 2023 16:55:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-30-xuanzhuo@linux.alibaba.com>
 <Y9zIPdKmTvXqyuYS@boxer>
In-Reply-To: <Y9zIPdKmTvXqyuYS@boxer>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Fri, 3 Feb 2023 09:39:25 +0100, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:54PM +0800, Xuan Zhuo wrote:
> > The driver's tx napi is very important for XSK. It is responsible for
> > obtaining data from the XSK queue and sending it out.
> >
> > At the beginning, we need to trigger tx napi.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c |  12 +++-
> >  drivers/net/virtio/xsk.c  | 146 ++++++++++++++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h  |   2 +
> >  3 files changed, 159 insertions(+), 1 deletion(-)
> >
>
> (...)
>
> > +static int virtnet_xsk_xmit_batch(struct send_queue *sq,
> > +				  struct xsk_buff_pool *pool,
> > +				  unsigned int budget,
> > +				  struct virtnet_sq_stats *stats)
> > +{
> > +	int ret = XSK_XMIT_NO_BUDGET;
> > +	struct xdp_desc desc;
> > +	int err, packet = 0;
> > +
> > +	while (budget-- > 0) {
> > +		if (sq->vq->num_free < 2) {
> > +			__free_old_xmit(sq, true, stats);
> > +			if (sq->vq->num_free < 2) {
> > +				ret = XSK_XMIT_DEV_BUSY;
> > +				break;
> > +			}
> > +		}
> > +
> > +		if (!xsk_tx_peek_desc(pool, &desc)) {
>
> anything that stopped from using xsk_tx_peek_release_desc_batch() ?


Great!

Will fix.

Thanks.


>
> > +			ret = XSK_XMIT_DONE;
> > +			break;
> > +		}
> > +
> > +		err = virtnet_xsk_xmit_one(sq, pool, &desc);
> > +		if (unlikely(err)) {
> > +			ret = XSK_XMIT_DEV_BUSY;
> > +			break;
> > +		}
> > +
> > +		++packet;
> > +
> > +		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> > +			++stats->kicks;
> > +	}
> > +
> > +	if (packet) {
> > +		stats->xdp_tx += packet;
> > +
> > +		xsk_tx_release(pool);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > +		      int budget)
> > +{
> > +	struct virtnet_sq_stats stats = {};
> > +	bool busy;
> > +	int ret;
> > +
> > +	__free_old_xmit(sq, true, &stats);
> > +
> > +	if (xsk_uses_need_wakeup(pool))
> > +		xsk_set_tx_need_wakeup(pool);
> > +
> > +	ret = virtnet_xsk_xmit_batch(sq, pool, budget, &stats);
> > +	switch (ret) {
> > +	case XSK_XMIT_DONE:
> > +		/* xsk tx qeueu has been consumed done. should complete napi. */
> > +		busy = false;
> > +		break;
> > +
> > +	case XSK_XMIT_NO_BUDGET:
> > +		/* reach the budget limit. should let napi run again. */
> > +		busy = true;
> > +		break;
> > +
> > +	case XSK_XMIT_DEV_BUSY:
> > +		/* sq vring is full, should complete napi. wait for tx napi been
> > +		 * triggered by interrupt.
> > +		 */
> > +		busy = false;
> > +		break;
> > +	}
> > +
> > +	virtnet_xsk_check_queue(sq);
> > +
> > +	u64_stats_update_begin(&sq->stats.syncp);
> > +	sq->stats.packets += stats.packets;
> > +	sq->stats.bytes += stats.bytes;
> > +	sq->stats.kicks += stats.kicks;
> > +	sq->stats.xdp_tx += stats.xdp_tx;
> > +	u64_stats_update_end(&sq->stats.syncp);
> > +
> > +	return busy;
> > +}
> > +
> >  static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
> >  				    struct xsk_buff_pool *pool, struct net_device *dev)
> >  {
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index ad684c812091..15f1540a5803 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -20,4 +20,6 @@ static inline u32 ptr_to_xsk(void *ptr)
> >  }
> >
> >  int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> > +bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> > +		      int budget);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
