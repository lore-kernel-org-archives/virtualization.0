Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C61DC6379F
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 07:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A68C181E3B;
	Fri,  3 Feb 2023 07:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A68C181E3B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rtaqcw4fDXfX; Fri,  3 Feb 2023 07:01:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 08613818CA;
	Fri,  3 Feb 2023 07:01:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 08613818CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D32C7C0032;
	Fri,  3 Feb 2023 07:01:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C938C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 07:01:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 109354162C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 07:01:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 109354162C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFa72CsNCjyq
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 07:01:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 680BA410AC
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 680BA410AC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 07:01:34 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=22; SR=0;
 TI=SMTPD_---0VanhFlL_1675407687; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VanhFlL_1675407687) by smtp.aliyun-inc.com;
 Fri, 03 Feb 2023 15:01:27 +0800
Message-ID: <1675407676.377156-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 09/33] xsk: xsk_buff_pool add callback for dma_sync
Date: Fri, 3 Feb 2023 15:01:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-10-xuanzhuo@linux.alibaba.com>
 <CAJ8uoz2+4+wUFYF1GjF51DFBV8ZsBRtTEVWpu_2fBmFUEQzOLQ@mail.gmail.com>
In-Reply-To: <CAJ8uoz2+4+wUFYF1GjF51DFBV8ZsBRtTEVWpu_2fBmFUEQzOLQ@mail.gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
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

On Thu, 2 Feb 2023 13:51:20 +0100, Magnus Karlsson <magnus.karlsson@gmail.com> wrote:
> On Thu, 2 Feb 2023 at 12:05, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > Use callback to implement dma sync to simplify subsequent support for
> > virtio dma sync.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/net/xsk_buff_pool.h |  6 ++++++
> >  net/xdp/xsk_buff_pool.c     | 24 ++++++++++++++++++++----
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index 3e952e569418..53b681120354 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -75,6 +75,12 @@ struct xsk_buff_pool {
> >         u32 chunk_size;
> >         u32 chunk_shift;
> >         u32 frame_len;
> > +       void (*dma_sync_for_cpu)(struct device *dev, dma_addr_t addr,
> > +                                unsigned long offset, size_t size,
> > +                                enum dma_data_direction dir);
> > +       void (*dma_sync_for_device)(struct device *dev, dma_addr_t addr,
> > +                                   unsigned long offset, size_t size,
> > +                                   enum dma_data_direction dir);
>
> If we put these two pointers here, the number of cache lines required
> in the data path for this struct will be increased from 2 to 3 which
> will likely affect performance negatively. These sync operations are
> also not used on most systems. So how about we put them in the first
> section of this struct labeled "Members only used in the control path
> first." instead. There is a 26-byte hole at the end of it that can be
> used.


Will fix.

Thanks.


>
> >         u8 cached_need_wakeup;
> >         bool uses_need_wakeup;
> >         bool dma_need_sync;
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index ed6c71826d31..78e325e195fa 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -403,6 +403,20 @@ static int xp_init_dma_info(struct xsk_buff_pool *pool, struct xsk_dma_map *dma_
> >         return 0;
> >  }
> >
> > +static void dma_sync_for_cpu(struct device *dev, dma_addr_t addr,
> > +                            unsigned long offset, size_t size,
> > +                            enum dma_data_direction dir)
> > +{
> > +       dma_sync_single_range_for_cpu(dev, addr, offset, size, dir);
> > +}
> > +
> > +static void dma_sync_for_device(struct device *dev, dma_addr_t addr,
> > +                               unsigned long offset, size_t size,
> > +                               enum dma_data_direction dir)
> > +{
> > +       dma_sync_single_range_for_device(dev, addr, offset, size, dir);
> > +}
> > +
> >  int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
> >                unsigned long attrs, struct page **pages, u32 nr_pages)
> >  {
> > @@ -421,6 +435,9 @@ int xp_dma_map(struct xsk_buff_pool *pool, struct device *dev,
> >                 return 0;
> >         }
> >
> > +       pool->dma_sync_for_cpu = dma_sync_for_cpu;
> > +       pool->dma_sync_for_device = dma_sync_for_device;
> > +
> >         dma_map = xp_create_dma_map(dev, pool->netdev, nr_pages, pool->umem);
> >         if (!dma_map)
> >                 return -ENOMEM;
> > @@ -667,15 +684,14 @@ EXPORT_SYMBOL(xp_raw_get_dma);
> >
> >  void xp_dma_sync_for_cpu_slow(struct xdp_buff_xsk *xskb)
> >  {
> > -       dma_sync_single_range_for_cpu(xskb->pool->dev, xskb->dma, 0,
> > -                                     xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> > +       xskb->pool->dma_sync_for_cpu(xskb->pool->dev, xskb->dma, 0,
> > +                                    xskb->pool->frame_len, DMA_BIDIRECTIONAL);
> >  }
> >  EXPORT_SYMBOL(xp_dma_sync_for_cpu_slow);
> >
> >  void xp_dma_sync_for_device_slow(struct xsk_buff_pool *pool, dma_addr_t dma,
> >                                  size_t size)
> >  {
> > -       dma_sync_single_range_for_device(pool->dev, dma, 0,
> > -                                        size, DMA_BIDIRECTIONAL);
> > +       pool->dma_sync_for_device(pool->dev, dma, 0, size, DMA_BIDIRECTIONAL);
> >  }
> >  EXPORT_SYMBOL(xp_dma_sync_for_device_slow);
> > --
> > 2.32.0.3.g01195cf9f
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
