Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236B6C77B7C
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 09:24:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 99B9C60BE8;
	Sun, 23 Apr 2023 09:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 99B9C60BE8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vwXF2_OOg_u8; Sun, 23 Apr 2023 09:24:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88EA060B78;
	Sun, 23 Apr 2023 09:24:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88EA060B78
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C30FC0037;
	Sun, 23 Apr 2023 09:24:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B67EC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 09:24:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E883340544
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 09:24:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E883340544
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lEztuxSjkyxJ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 09:24:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D5E304052B
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D5E304052B
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 09:24:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R241e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VgjOwM0_1682241875; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgjOwM0_1682241875) by smtp.aliyun-inc.com;
 Sun, 23 Apr 2023 17:24:36 +0800
Message-ID: <1682241212.1994312-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] xsk: introduce xsk_dma_cbs
Date: Sun, 23 Apr 2023 17:13:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Greg KH <gregkh@linuxfoundation.org>
References: <20230423062546.96880-1-xuanzhuo@linux.alibaba.com>
 <ZETUAMqKc8iLhTk3@kroah.com>
 <1682233116.3679233-3-xuanzhuo@linux.alibaba.com>
 <2023042342-triceps-alias-5084@gregkh>
In-Reply-To: <2023042342-triceps-alias-5084@gregkh>
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

On Sun, 23 Apr 2023 10:39:15 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Sun, Apr 23, 2023 at 02:58:36PM +0800, Xuan Zhuo wrote:
> > On Sun, 23 Apr 2023 08:45:20 +0200, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > On Sun, Apr 23, 2023 at 02:25:45PM +0800, Xuan Zhuo wrote:
> > > > The purpose of this patch is to allow driver pass the own dma callbacks
> > > > to xsk.
> > > >
> > > > This is to cope with the scene of virtio-net. If virtio does not have
> > > > VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
> > > > xsk cannot use DMA API directly to achieve DMA address. Based on this
> > > > scene, we must let xsk support driver to use the driver's dma callbacks.
> > >
> > > Why does virtio need to use dma?  That seems to go against the overall
> > > goal of virtio's new security restrictions that are being proposed
> > > (where they do NOT want it to use dma as it is not secure).
> >
> > Sorry, I don't know that, could you give me one link?
>
> Search for the "Confidential Computing" emails on lkml for an example of
> this mess.
>
> > But now, virtio-net/virtio will use dma api, when the feature VIRTIO_F_ACCESS_PLATFORM
> > is got. If no VIRTIO_F_ACCESS_PLATFORM, the virtio(virtio-net) will not use DMA
> > API.
> >
> > >
> > > And why is virtio special here?
> >
> > The problem is that xsk always get dma by DMA APIs, but sometimes the
> > virtio-net can not work with DMA APIs.
> >
> > > If you have access to a device, it
> > > should have all of the needed dma hooks already set up based on the
> > > bus it is on.  Or is the issue you don't have a real bus set up?  If so,
> > > why not fix that?
> >
> > We tried, but that seams we can not.
> > More:
> >    https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/
>
> So you are assuming a random virtual device with no dma backing bus is
> allowed to do dma operations?  This feels wrong and should be fixed
> somewhere so that the bus involved (you do have hardware here), is
> properly exposed.

YES.

The conclusion of the discussion with Christoph is that we have no way
to get the direct dma address from virtio-device or virtio-pci-device based on
the dma api. That's why this patch try to make xsk not use dma apis in some
cases.

>
> Please work with Christoph and others to solve this, don't try to route
> around the issue.  Your patches are assuming that you have a device
> pointer anyway, and that's on a bus, so it does have access somehow,
> right?

NO.

Sorry, this brings trouble to reviewers who don't know the context.

Here is the code inside the virtio-net using this cbs.

+static dma_addr_t virtnet_xsk_dma_map_page(struct device *dev, struct page *page,
+                                          size_t offset, size_t size,
+                                          enum dma_data_direction dir, unsigned long attrs)
+{
+       return (dma_addr_t)virt_to_phys(page_address(page) + offset);
+}
+
+static void virtnet_xsk_dma_unmap_page(struct device *dev, dma_addr_t addr,
+                                      size_t size, enum dma_data_direction dir,
+                                      unsigned long attrs)
+{
+}
+
+static int virtnet_xsk_dma_mapping_error(struct device *dev, dma_addr_t addr)
+{
+       return 0;
+}
+
+static bool virtnet_xsk_dma_need_sync(struct device *dev, dma_addr_t addr)
+{
+       return false;
+}
+
+static void virtnet_xsk_dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t addr,
+                                                     size_t offset, size_t size,
+                                                     enum dma_data_direction dir)
+{
+}
+
+static void virtnet_xsk_dma_sync_single_range_for_device(struct device *dev, dma_addr_t addr,
+                                                        size_t offset, size_t size,
+                                                        enum dma_data_direction dir)
+{
+}
+
+static struct xsk_dma_ops virtnet_xsk_dma_ops = {
+       .map_page = virtnet_xsk_dma_map_page,
+       .unmap_page = virtnet_xsk_dma_unmap_page,
+       .mapping_error = virtnet_xsk_dma_mapping_error,
+       .need_sync = virtnet_xsk_dma_need_sync,
+       .sync_single_range_for_cpu = virtnet_xsk_dma_sync_single_range_for_cpu,
+       .sync_single_range_for_device = virtnet_xsk_dma_sync_single_range_for_device,
+};
+

The device is included in the interface, just to ensure the compatibility of dma
api, there is not necessarily a device at all.

>
> > > > More is here:
> > > >     https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/
> > > >     https://lore.kernel.org/all/20230421065059.1bc78133@kernel.org
> > >
> > > Am I missing the user of this new api?  Don't you need to submit that at
> > > the same time so we can at least see if this new api works properly?
> >
> > The user will is the virtio-net with supporting to AF_XDP.
> >
> > That is a huge patch set. Some is in virtio core, some is in net-dev.
> > An earlier version was [1] with some differences but not much.
> >
> > 	[1] http://lore.kernel.org/all/20230202110058.130695-1-xuanzhuo@linux.alibaba.com
> >
> > I tried to split to multi patch-set.
> >
> > Currently I plan to have several parts like this:
> >
> > 1. virtio core support premapped-dma, vq reset, expose dma device (virtio vhost branch)
> > 2. virtio-net: refactor xdp (netdev branch)
> > 3. virtio-net: support af-xdp (netdev branch)
> >
> > But now, #1 is block by this dma question.
> >
> > So, I want to complete this patch first.
>
> As you know, we can never take apis without a real user for them,
> because obviously those apis could be instantly removed from the system
> because no one is using them.  We also do not know that the api is even
> correct at all, without being able to see all of the users.

We can not merge this patch, but let's complete the discussion of this issue
first. Next version, I can change to rfc.

Thanks.

>
> So make this a larger patch set please.  What would you do if you had to
> review this without any prior information?  Make it easy for reviewers
> please.
>
> > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > ---
> > > >  include/net/xdp_sock_drv.h  | 20 ++++++++++-
> > > >  include/net/xsk_buff_pool.h | 19 ++++++++++
> > > >  net/xdp/xsk_buff_pool.c     | 71 +++++++++++++++++++++++++++----------
> > > >  3 files changed, 90 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/include/net/xdp_sock_drv.h b/include/net/xdp_sock_drv.h
> > > > index 9c0d860609ba..8b5284b272e4 100644
> > > > --- a/include/net/xdp_sock_drv.h
> > > > +++ b/include/net/xdp_sock_drv.h
> > > > @@ -67,7 +67,17 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
> > > >  {
> > > >  	struct xdp_umem *umem = pool->umem;
> > > >
> > > > -	return xp_dma_map(pool, dev, attrs, umem->pgs, umem->npgs);
> > > > +	return xp_dma_map(pool, dev, NULL, attrs, umem->pgs, umem->npgs);
> > > > +}
> > > > +
> > > > +static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
> > > > +					    struct device *dev,
> > > > +					    struct xsk_dma_cbs *dma_cbs,
> > > > +					    unsigned long attrs)
> > > > +{
> > > > +	struct xdp_umem *umem = pool->umem;
> > > > +
> > > > +	return xp_dma_map(pool, dev, dma_cbs, attrs, umem->pgs, umem->npgs);
> > > >  }
> > > >
> > > >  static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
> > > > @@ -226,6 +236,14 @@ static inline int xsk_pool_dma_map(struct xsk_buff_pool *pool,
> > > >  	return 0;
> > > >  }
> > > >
> > > > +static inline int xsk_pool_dma_map_with_cbs(struct xsk_buff_pool *pool,
> > > > +					    struct device *dev,
> > > > +					    struct xsk_dma_cbs *dma_cbs,
> > > > +					    unsigned long attrs)
> > > > +{
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static inline dma_addr_t xsk_buff_xdp_get_dma(struct xdp_buff *xdp)
> > > >  {
> > > >  	return 0;
> > > > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > > > index 3e952e569418..2de88be9188b 100644
> > > > --- a/include/net/xsk_buff_pool.h
> > > > +++ b/include/net/xsk_buff_pool.h
> > > > @@ -43,6 +43,23 @@ struct xsk_dma_map {
> > > >  	bool dma_need_sync;
> > > >  };
> > > >
> > > > +struct xsk_dma_cbs {
> > > > +	dma_addr_t (*map_page)(struct device *dev, struct page *page,
> > >
> > > Why are you working on a "raw" struct device here and everywhere else?
> > > Are you sure that is ok?  What is it needed for?
> >
> > I copy this from DMA APIs. For virtio that is not needed. But is there any
> > problems?
>
> See above, where are you getting this random device pointer from?
> Eventually it does point to something on a bus with DMA access, right?
> So why not use the right pointer for that type of device?
>
> Or are you going to have devices of different types using this api?  If
> so, where?  Again, this is hard to review without any real users.
>
> > > > +			       size_t offset, size_t size,
> > > > +			       enum dma_data_direction dir, unsigned long attrs);
> > > > +	void (*unmap_page)(struct device *dev, dma_addr_t addr,
> > > > +			   size_t size, enum dma_data_direction dir,
> > > > +			   unsigned long attrs);
> > > > +	int (*mapping_error)(struct device *dev, dma_addr_t addr);
> > > > +	bool (*need_sync)(struct device *dev, dma_addr_t addr);
> > > > +	void (*sync_single_range_for_cpu)(struct device *dev, dma_addr_t addr,
> > > > +					  size_t offset, size_t size,
> > > > +					  enum dma_data_direction dir);
> > > > +	void (*sync_single_range_for_device)(struct device *dev, dma_addr_t addr,
> > > > +					     size_t offset, size_t size,
> > > > +					     enum dma_data_direction dir);
> > > > +};
> > >
> > > No documentation for any of these callbacks?  Please use kerneldoc so we
> > > at least have a clue as to what they should be doing.
> > >
> > > > +
> > > >  struct xsk_buff_pool {
> > > >  	/* Members only used in the control path first. */
> > > >  	struct device *dev;
> > > > @@ -85,6 +102,7 @@ struct xsk_buff_pool {
> > > >  	 * sockets share a single cq when the same netdev and queue id is shared.
> > > >  	 */
> > > >  	spinlock_t cq_lock;
> > > > +	struct xsk_dma_cbs *dma_cbs;
> > > >  	struct xdp_buff_xsk *free_heads[];
> > > >  };
> > > >
> > > > @@ -131,6 +149,7 @@ static inline void xp_init_xskb_dma(struct xdp_buff_xsk *xskb, struct xsk_buff_p
> > > >  /* AF_XDP ZC drivers, via xdp_sock_buff.h */
> > > >  void xp_set_rxq_info(struct xsk_buff_pool *pool, struct xdp_rxq_info *rxq);
> > > >  int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
> > > > +	       struct xsk_dma_cbs *dma_cbs,
> > > >  	       unsigned long attrs, struct page **pages, u32 nr_pages);
> > > >  void xp_dma_unmap(struct xsk_buff_pool *pool, unsigned long attrs);
> > > >  struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool);
> > > > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > > > index b2df1e0f8153..e7e6c91f6e51 100644
> > > > --- a/net/xdp/xsk_buff_pool.c
> > > > +++ b/net/xdp/xsk_buff_pool.c
> > > > @@ -328,7 +328,8 @@ static void xp_destroy_dma_map(struct xsk_dma_map *dma_map)
> > > >  	kfree(dma_map);
> > > >  }
> > > >
> > > > -static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
> > > > +static void __xp_dma_unmap(struct xsk_dma_map *dma_map,
> > > > +			   struct xsk_dma_cbs *dma_cbs, unsigned long attrs)
> > > >  {
> > > >  	dma_addr_t *dma;
> > > >  	u32 i;
> > > > @@ -337,8 +338,12 @@ static void __xp_dma_unmap(struct xsk_dma_map *dma_map, unsigned long attrs)
> > > >  		dma = &dma_map->dma_pages[i];
> > > >  		if (*dma) {
> > > >  			*dma &= ~XSK_NEXT_PG_CONTIG_MASK;
> > > > -			dma_unmap_page_attrs(dma_map->dev, *dma, PAGE_SIZE,
> > > > -					     DMA_BIDIRECTIONAL, attrs);
> > > > +			if (unlikely(dma_cbs))
> > >
> > > If you can not measure the use of likely/unlikely in a benchmark, then
> > > you should never use it as the compiler and CPU will work better without
> > > it (and will work better over time as hardware and compiler change).
> >
> > Because in most cases the dma_cbs is null for xsk. So I use the 'unlikely'.
>
> Again, prove that this is needed, otherwise do not use it.
>
> thanks,
>
> greg k-h
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
