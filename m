Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDFAC77B72
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 06:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F5F782213;
	Mon, 17 Apr 2023 06:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F5F782213
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H75y5msMRkq9; Mon, 17 Apr 2023 06:50:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEDAB81F22;
	Mon, 17 Apr 2023 06:50:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEDAB81F22
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0920C0037;
	Mon, 17 Apr 2023 06:50:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF871C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:50:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBC2141854
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:50:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBC2141854
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LXNWccA3KwDA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:50:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7AB764182F
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7AB764182F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 06:50:42 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=20; SR=0;
 TI=SMTPD_---0VgE.UCn_1681714234; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgE.UCn_1681714234) by smtp.aliyun-inc.com;
 Mon, 17 Apr 2023 14:50:35 +0800
Message-ID: <1681714108.3197143-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Mon, 17 Apr 2023 14:48:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <20230417024216-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230417024216-mutt-send-email-mst@kernel.org>
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
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

On Mon, 17 Apr 2023 02:43:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Apr 17, 2023 at 11:27:50AM +0800, Xuan Zhuo wrote:
> > @@ -532,9 +545,9 @@ struct xdp_buff *xp_alloc(struct xsk_buff_pool *pool)
> >  	xskb->xdp.data_meta = xskb->xdp.data;
> >
> >  	if (pool->dma_need_sync) {
> > -		dma_sync_single_range_for_device(pool->dev, xskb->dma, 0,
> > -						 pool->frame_len,
> > -						 DMA_BIDIRECTIONAL);
> > +		pool->dma_ops.sync_single_range_for_device(pool->dev, xskb->dma, 0,
> > +							   pool->frame_len,
> > +							   DMA_BIDIRECTIONAL);
> >  	}
> >  	return &xskb->xdp;
> >  }
> > @@ -670,15 +683,15 @@ EXPORT_SYMBOL(xp_raw_get_dma);
> >
> >  void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
> >  {
> > -	dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> > -				      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> > +	xskb->pool->dma_ops.sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> > +						      xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> >  }
> >  EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
> >
> >  void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
> >  				 size_t size)
> >  {
> > -	dma_sync_single_range_for_device(pool->dev, dma, 0,
> > -					 size, DMA_BIDIRECTIONAL);
> > +	pool->dma_ops.sync_single_range_for_device(pool->dev, dma, 0,
> > +						   size, DMA_BIDIRECTIONAL);
> >  }
> >  EXPORT_SYMBOL(xp_dma_sync_for_device_slow);
>
> So you add an indirect function call on data path? Won't this be costly?


Yes, this may introduce some cost. The good news is that in some case,
sync is not necessary. dma_need_sync should be false.

Thanks.


>
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
