Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60069C00528
	for <virtualization@archiver.kernel.org>; Mon,  7 Aug 2023 06:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D63CA410B2;
	Mon,  7 Aug 2023 06:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D63CA410B2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RF2d-X_a-QmQ; Mon,  7 Aug 2023 06:15:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 05F4D4098C;
	Mon,  7 Aug 2023 06:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 05F4D4098C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CE992C0072;
	Mon,  7 Aug 2023 06:15:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A52D1C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 06:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 798A68121F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 06:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 798A68121F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eCP8mVpkgM9m
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 06:15:08 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0EB41809DD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Aug 2023 06:15:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EB41809DD
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vp9Kq12_1691388895; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vp9Kq12_1691388895) by smtp.aliyun-inc.com;
 Mon, 07 Aug 2023 14:14:56 +0800
Message-ID: <1691388845.9121156-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Mon, 7 Aug 2023 14:14:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Christoph Hellwig <hch@infradead.org>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230801121543-mutt-send-email-mst@kernel.org>
 <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1690940971.9409487-2-xuanzhuo@linux.alibaba.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
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

On Wed, 2 Aug 2023 09:49:31 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Tue, 1 Aug 2023 12:17:47 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Jul 28, 2023 at 02:02:33PM +0800, Xuan Zhuo wrote:
> > > On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > > > On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > > > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > > > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > > > > > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > > > > > > There are NOP for non-dma so passing the dma device is harmless.
> > > > > > >
> > > > > > > Yes, please.
> > > > > >
> > > > > >
> > > > > > I am not sure I got this fully.
> > > > > >
> > > > > > Are you mean this:
> > > > > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> > > > > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> > > > > >
> > > > > > Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> > > > > > No care the device is non-dma device or dma device.
> > > > >
> > > > > yes
> > > > >
> > > > > > Then the AF_XDP must use these virtio_dma_* APIs for virtio device.
> > > > >
> > > > > We'll worry about AF_XDP when the patch is posted.
> > > >
> > > > YES.
> > > >
> > > > We discussed it. They voted 'no'.
> > > >
> > > > http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org
> > >
> > >
> > > Hi guys, this topic is stuck again. How should I proceed with this work?
> > >
> > > Let me briefly summarize:
> > > 1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
> > > the driver layer, we need to support these APIs. The current conclusion of
> > > AF_XDP is no.
> > >
> > > 2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
> > > driver. This idea seems to be inconsistent with the framework design of DMA. The
> > > conclusion is no.
> > >
> > > 3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
> > > uses DMA API. And this type of device is the future direction, so we only
> > > support DMA premapped for this type of virtio device. The problem with this
> > > solution is that virtqueue_dma_dev() only returns dev in some cases, because
> > > VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
> > > This option is currently NO.
> > >
> > > So I'm wondering what should I do, from a DMA point of view, is there any
> > > solution in case of using DMA API?
> > >
> > > Thank you
> >
> >
> > I think it's ok at this point, Christoph just asked you
> > to add wrappers for map/unmap for use in virtio code.
> > Seems like a cosmetic change, shouldn't be hard.
>
> Yes, that is not hard, I has this code.
>
> But, you mean that the wrappers is just used for the virtio driver code?
> And we also offer the  API virtqueue_dma_dev() at the same time?
> Then the driver will has two chooses to do DMA.
>
> Is that so?

Ping.

Thanks

>
>
> > Otherwise I haven't seen significant comments.
> >
> >
> > Christoph do I summarize what you are saying correctly?
> > --
> > MST
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
