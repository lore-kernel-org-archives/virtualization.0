Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC24C636D6
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:57:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1034781F68;
	Fri,  3 Feb 2023 08:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1034781F68
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qJB3DdRyb8fa; Fri,  3 Feb 2023 08:57:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 88DA881EA3;
	Fri,  3 Feb 2023 08:57:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88DA881EA3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6721CC0032;
	Fri,  3 Feb 2023 08:57:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D479C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:57:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47D3F81EF3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:57:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47D3F81EF3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JlFbmZ2TSxQz
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:57:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C67781EA3
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C67781EA3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:57:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0Vao5dz6_1675414632; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vao5dz6_1675414632) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 16:57:12 +0800
Message-ID: <1675414568.1205437-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 32/33] virtio_net: xsk: rx: introduce add_recvbuf_xsk()
Date: Fri, 3 Feb 2023 16:56:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-33-xuanzhuo@linux.alibaba.com>
 <Y9zJS+ugeY9qEMt9@boxer>
In-Reply-To: <Y9zJS+ugeY9qEMt9@boxer>
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

On Fri, 3 Feb 2023 09:43:55 +0100, Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> On Thu, Feb 02, 2023 at 07:00:57PM +0800, Xuan Zhuo wrote:
> > Implement the logic of filling vq with XSK buffer.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  drivers/net/virtio/main.c | 11 +++++++++++
> >  drivers/net/virtio/xsk.c  | 26 ++++++++++++++++++++++++++
> >  drivers/net/virtio/xsk.h  |  2 ++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > index 7259b27f5cba..2aff0eee35d3 100644
> > --- a/drivers/net/virtio/main.c
> > +++ b/drivers/net/virtio/main.c
> > @@ -1352,10 +1352,20 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
> >   */
> >  bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
> >  {
> > +	struct xsk_buff_pool *pool;
> >  	int err;
> >  	bool oom;
> >
> >  	do {
> > +		rcu_read_lock();
> > +		pool = rcu_dereference(rq->xsk.pool);
> > +		if (pool) {
> > +			err = add_recvbuf_xsk(vi, rq, pool, gfp);
> > +			rcu_read_unlock();
> > +			goto check;
> > +		}
> > +		rcu_read_unlock();
> > +
> >  		if (vi->mergeable_rx_bufs)
> >  			err = add_recvbuf_mergeable(vi, rq, gfp);
> >  		else if (vi->big_packets)
> > @@ -1363,6 +1373,7 @@ bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
> >  		else
> >  			err = add_recvbuf_small(vi, rq, gfp);
> >
> > +check:
> >  		oom = err == -ENOMEM;
> >  		if (err)
> >  			break;
> > diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
> > index 043b0bf2a5d7..a5e88f919c46 100644
> > --- a/drivers/net/virtio/xsk.c
> > +++ b/drivers/net/virtio/xsk.c
> > @@ -37,6 +37,32 @@ static void virtnet_xsk_check_queue(struct send_queue *sq)
> >  		netif_stop_subqueue(dev, qnum);
> >  }
> >
> > +int add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
> > +		    struct xsk_buff_pool *pool, gfp_t gfp)
> > +{
> > +	struct xdp_buff *xdp;
> > +	dma_addr_t addr;
> > +	u32 len;
> > +	int err;
> > +
> > +	xdp = xsk_buff_alloc(pool);
>
> same question as on tx side -anything stopped you from using batch API -
> xsk_buff_alloc_batch() ?

Will fix.

You should know that when I write the earliest version, there is no these APIs.  ^_^

Thanks.



>
> > +	if (!xdp)
> > +		return -ENOMEM;
> > +
> > +	/* use the part of XDP_PACKET_HEADROOM as the virtnet hdr space */
> > +	addr = xsk_buff_xdp_get_dma(xdp) - vi->hdr_len;
> > +	len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
> > +
> > +	sg_init_table(rq->sg, 1);
> > +	sg_fill_dma(rq->sg, addr, len);
> > +
> > +	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, xdp, gfp);
> > +	if (err)
> > +		xsk_buff_free(xdp);
> > +
> > +	return err;
> > +}
> > +
> >  static int virtnet_xsk_xmit_one(struct send_queue *sq,
> >  				struct xsk_buff_pool *pool,
> >  				struct xdp_desc *desc)
> > diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
> > index f90c28972d72..5549143ef118 100644
> > --- a/drivers/net/virtio/xsk.h
> > +++ b/drivers/net/virtio/xsk.h
> > @@ -24,4 +24,6 @@ int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
> >  bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
> >  		      int budget);
> >  int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag);
> > +int add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue *rq,
> > +		    struct xsk_buff_pool *pool, gfp_t gfp);
> >  #endif
> > --
> > 2.32.0.3.g01195cf9f
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
