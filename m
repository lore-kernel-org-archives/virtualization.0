Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F56AC77B7E
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 13:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEA3E60634;
	Wed, 19 Apr 2023 13:43:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BEA3E60634
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MgmqIGZrpL2o; Wed, 19 Apr 2023 13:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F38E76059F;
	Wed, 19 Apr 2023 13:43:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F38E76059F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6803C0037;
	Wed, 19 Apr 2023 13:43:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F26DFC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDAF783BE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CDAF783BE9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UK5_8mlv2wqv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36A9F81FAD
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 36A9F81FAD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:43:23 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VgVBGnO_1681911795; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgVBGnO_1681911795) by smtp.aliyun-inc.com;
 Wed, 19 Apr 2023 21:43:16 +0800
Message-ID: <1681911760.8853464-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Wed, 19 Apr 2023 21:42:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <88d5a2f6-af43-c3f9-615d-701ef01d923d@intel.com>
In-Reply-To: <88d5a2f6-af43-c3f9-615d-701ef01d923d@intel.com>
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

On Wed, 19 Apr 2023 15:22:39 +0200, Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Date: Mon, 17 Apr 2023 11:27:50 +0800
>
> > The purpose of this patch is to allow driver pass the own dma_ops to
> > xsk.
> >
> > This is to cope with the scene of virtio-net. If virtio does not have
> > VIRTIO_F_ACCESS_PLATFORM, then virtio cannot use DMA API. In this case,
> > XSK cannot use DMA API directly to achieve DMA address. Based on this
> > scene, we must let XSK support driver to use the driver's dma_ops.
> >
> > On the other hand, the implementation of XSK as a highlevel code
> > should put the underlying operation of DMA to the driver layer.
> > The driver layer determines the implementation of the final DMA. XSK
> > should not make such assumptions. Everything will be simplified if DMA
> > is done at the driver level.
> >
> > More is here:
> >     https://lore.kernel.org/virtualization/1681265026.6082013-1-xuanzhuo@linux.alibaba.com/
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> [...]
>
> >  struct xsk_buff_pool {
> >  	/* Members only used in the control path first. */
> >  	struct device *dev;
> > @@ -85,6 +102,7 @@ struct xsk_buff_pool {
> >  	 * sockets share a single cq when the same netdev and queue id is shared.
> >  	 */
> >  	spinlock_t cq_lock;
> > +	struct xsk_dma_ops dma_ops;
>
> Why full struct, not a const pointer? You'll have indirect calls either
> way, copying the full struct won't reclaim you much performance.
>
> >  	struct xdp_buff_xsk *free_heads[];
> >  };
> >
>
> [...]
>
> > @@ -424,18 +426,29 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
> >  		return 0;
> >  	}
> >
> > +	if (!dma_ops) {
> > +		pool->dma_ops.map_page = dma_map_page_attrs;
> > +		pool->dma_ops.mapping_error = dma_mapping_error;
> > +		pool->dma_ops.need_sync = dma_need_sync;
> > +		pool->dma_ops.sync_single_range_for_device = dma_sync_single_range_for_device;
> > +		pool->dma_ops.sync_single_range_for_cpu = dma_sync_single_range_for_cpu;
> > +		dma_ops = &pool->dma_ops;
> > +	} else {
> > +		pool->dma_ops = *dma_ops;
> > +	}
>
> If DMA syncs are not needed on your x86_64 DMA-coherent system, it
> doesn't mean we all don't need it. Instead of filling pointers with
> "default" callbacks, you could instead avoid indirect calls at all when
> no custom DMA ops are specified. Pls see how for example Christoph did
> that for direct DMA. It would cost only one if-else for case without
> custom DMA ops here instead of an indirect call each time.
>
> (I *could* suggest using INDIRECT_CALL_WRAPPER(), but I won't, since
>  it's more expensive than direct checking and I feel like it's more
>  appropriate to check directly here)

OK, I will fix it in next version.

Thanks.




>
> > +
> >  	dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
> >  	if (!dma_map)
> >  		return -ENOMEM;
> [...]
>
> Thanks,
> Olek
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
