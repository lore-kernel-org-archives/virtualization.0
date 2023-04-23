Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E85EC77B7F
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 07:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DAEAC409D6;
	Sun, 23 Apr 2023 07:21:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DAEAC409D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KmxI-3bMKILQ; Sun, 23 Apr 2023 07:21:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3706F405BE;
	Sun, 23 Apr 2023 07:21:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3706F405BE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D4BCC0037;
	Sun, 23 Apr 2023 07:21:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7891C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8095041B4C
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:21:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8095041B4C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TjYm_frVV6Sz
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:21:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F195E41A42
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F195E41A42
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:21:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R701e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0Vgirrj0_1682234472; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vgirrj0_1682234472) by smtp.aliyun-inc.com;
 Sun, 23 Apr 2023 15:21:14 +0800
Message-ID: <1682233116.3679233-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] xsk: introduce xsk_dma_cbs
Date: Sun, 23 Apr 2023 14:58:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Greg KH <gregkh@linuxfoundation.org>
References: <20230423062546.96880-1-xuanzhuo@linux.alibaba.com>
 <ZETUAMqKc8iLhTk3@kroah.com>
In-Reply-To: <ZETUAMqKc8iLhTk3@kroah.com>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Christoph Hellwig <hch@infradead.org>,
 =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux-foundation.org,
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

On Sun, 23 Apr 2023 08:45:20 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Apr 23, 2023 at 02:25:45PM +0800, Xuan Zhuo wrote:
> > The purpose of this patch is to allow driver pass the own dma callbacks
> > to xsk.
> >
> > This is to cope with the scene of virtio-net. If virtio does not have
> > VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
> > xsk cannot use DMA API directly to achieve DMA address. Based on this
> > scene, we must let xsk support driver to use the driver's dma callbacks.
>
> Why does virtio need to use dma?  That seems to go against the overall
> goal of virtio's new security restrictions that are being proposed
> (where they do NOT want it to use dma as it is not secure).

Sorry, I don't know that, could you give me one link?

But now, virtio-net/virtio will use dma api, when the feature VIRTIO_F_ACCESS_PLATFORM
is got. If no VIRTIO_F_ACCESS_PLATFORM, the virtio(virtio-net) will not use DMA
API.

>
> And why is virtio special here?

The problem is that xsk always get dma by DMA APIs, but sometimes the
virtio-net can not work with DMA APIs.

> If you have access to a device, it
> should have all of the needed dma hooks already set up based on the
> bus it is on.  Or is the issue you don't have a real bus set up?  If so,
> why not fix that?

We tried, but that seams we can not.
More:
   https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/

>
> > More is here:
> >     https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/
> >     https://lore.kernel.org/all/20230421065059.1bc78133@kernel.org
>
> Am I missing the user of this new api?  Don't you need to submit that at
> the same time so we can at least see if this new api works properly?

The user will is the virtio-net with supporting to AF_XDP.

That is a huge patch set. Some is in virtio core, some is in net-dev.
An earlier version was [1] with some differences but not much.

	[1] http://lore.kernel.org/all/20230202110058.130695-1-xuanzhuo@linux.alibaba.com

I tried to split to multi patch-set.

Currently I plan to have several parts like this:

1. virtio core support premapped-dma, vq reset, expose dma device (virtio vhost branch)
2. virtio-net: refactor xdp (netdev branch)
3. virtio-net: support af-xdp (netdev branch)

But now, #1 is block by this dma question.

So, I want to complete this patch first.

>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/net/xdp_sock_drv.h  | 20 ++++++++++-
> >  include/net/xsk_buff_pool.h | 19 ++++++++++
> >  net/xdp/xsk_buff_pool.c     | 71 +++++++++++++++++++++++++++----------
> >  3 files changed, 90 insertions(+), 20 deletions(-)
> >
> > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > index 9c0d860609ba..8b5284b272e4 100644
> > --- a/include/net/xdp_sock_drv.h
> > +++ b/include/net/xdp_sock_drv.h
> > @@ -67,7 +67,17 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
> >  {
> >  	struct xdp_umem *umem = pool->umem;
> >
> > -	return xp_dma_map(pool, dev, attrs, umem->pgs, umem->npgs);
> > +	return xp_dma_map(pool, dev, NULL, attrs, umem->pgs, umem->npgs);
> > +}
> > +
> > +static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
> > +					    struct device *dev,
> > +					    struct xsk_dma_cbs *dma_cbs,
> > +					    unsigned long attrs)
> > +{
> > +	struct xdp_umem *umem = pool->umem;
> > +
> > +	return xp_dma_map(pool, dev, dma_cbs, attrs, umem->pgs, umem->npgs);
> >  }
> >
> >  static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
> > @@ -226,6 +236,14 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
> >  	return 0;
> >  }
> >
> > +static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
> > +					    struct device *dev,
> > +					    struct xsk_dma_cbs *dma_cbs,
> > +					    unsigned long attrs)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
> >  {
> >  	return 0;
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 3e952e569418..2de88be9188b 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -43,6 +43,23 @@ struct xsk_dma_map {
> >  	bool dma_need_sync;
> >  };
> >
> > +struct xsk_dma_cbs {
> > +	dma_addr_t (*map_page)(struct device *dev, struct page *page,
>
> Why are you working on a "raw" struct device here and everywhere else?
> Are you sure that is ok?  What is it needed for?

I copy this from DMA APIs. For virtio that is not needed. But is there any
problems?


>
> > +			       size_t offset, size_t size,
> > +			       enum dma_data_direction dir, unsigned long attrs);
> > +	void (*unmap_page)(struct device *dev, dma_addr_t addr,
> > +			   size_t size, enum dma_data_direction dir,
> > +			   unsigned long attrs);
> > +	int (*mapping_error)(struct device *dev, dma_addr_t addr);
> > +	bool (*need_sync)(struct device *dev, dma_addr_t addr);
> > +	void (*sync_single_range_for_cpu)(struct device *dev, dma_addr_t addr,
> > +					  size_t offset, size_t size,
> > +					  enum dma_data_direction dir);
> > +	void (*sync_single_range_for_device)(struct device *dev, dma_addr_t addr,
> > +					     size_t offset, size_t size,
> > +					     enum dma_data_direction dir);
> > +};
>
> No documentation for any of these callbacks?  Please use kerneldoc so we
> at least have a clue as to what they should be doing.
>
> > +
> >  struct xsk_buff_pool {
> >  	/* Members only used in the control path first. */
> >  	struct device *dev;
> > @@ -85,6 +102,7 @@ struct xsk_buff_pool {
> >  	 * sockets share a single cq when the same netdev and queue id is shared.
> >  	 */
> >  	spinlock_t cq_lock;
> > +	struct xsk_dma_cbs *dma_cbs;
> >  	struct xdp_buff_xsk *free_heads[];
> >  };
> >
> > @@ -131,6 +149,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
> >  /* AF_XDP ZC drivers, via xdp_sock_buff.h */
> >  void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
> >  int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
> > +	       struct xsk_dma_cbs *dma_cbs,
> >  	       unsigned long attrs, struct page **pages, u32 nr_pages);
> >  void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
> >  struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index b2df1e0f8153..e7e6c91f6e51 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -328,7 +328,8 @@ static void xp_destroy_dma_map(struct xsk_dma_map *dma_map)
> >  	kfree(dma_map);
> >  }
> >
> > -static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
> > +static void __xp_dma_unmap(struct xsk_dma_map *dma_map,
> > +			   struct xsk_dma_cbs *dma_cbs, unsigned long attrs)
> >  {
> >  	dma_addr_t *dma;
> >  	u32 i;
> > @@ -337,8 +338,12 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
> >  		dma = &dma_map->dma_pages[i];
> >  		if (*dma) {
> >  			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
> > -			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
> > -					     DMA_BIDIRECTIONAL, attrs);
> > +			if (unlikely(dma_cbs))
>
> If you can not measure the use of likely/unlikely in a benchmark, then
> you should never use it as the compiler and CPU will work better without
> it (and will work better over time as hardware and compiler change).

Because in most cases the dma_cbs is null for xsk. So I use the 'unlikely'.

Thanks.


>
> thanks,
>
> greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
