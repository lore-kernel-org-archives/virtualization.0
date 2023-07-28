Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDECC0015E
	for <virtualization@archiver.kernel.org>; Fri, 28 Jul 2023 06:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C3BD84034;
	Fri, 28 Jul 2023 06:05:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0C3BD84034
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TYP6Avfc65t9; Fri, 28 Jul 2023 06:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9FAF983BFE;
	Fri, 28 Jul 2023 06:05:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FAF983BFE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66AE1C0072;
	Fri, 28 Jul 2023 06:05:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A3B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 06:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6514C60DC2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 06:05:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6514C60DC2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f1fZ0Tn2RInL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 06:05:13 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E980F60D95
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jul 2023 06:05:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E980F60D95
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VoOz.dW_1690524303; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VoOz.dW_1690524303) by smtp.aliyun-inc.com;
 Fri, 28 Jul 2023 14:05:04 +0800
Message-ID: <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
Date: Fri, 28 Jul 2023 14:02:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
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
In-Reply-To: <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
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

On Tue, 25 Jul 2023 19:07:23 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Tue, 25 Jul 2023 03:34:34 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Tue, Jul 25, 2023 at 10:13:48AM +0800, Xuan Zhuo wrote:
> > > On Mon, 24 Jul 2023 09:43:42 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> > > > On Thu, Jul 20, 2023 at 01:21:07PM -0400, Michael S. Tsirkin wrote:
> > > > > Well I think we can add wrappers like virtio_dma_sync and so on.
> > > > > There are NOP for non-dma so passing the dma device is harmless.
> > > >
> > > > Yes, please.
> > >
> > >
> > > I am not sure I got this fully.
> > >
> > > Are you mean this:
> > > https://lore.kernel.org/all/20230214072704.126660-8-xuanzhuo@linux.alibaba.com/
> > > https://lore.kernel.org/all/20230214072704.126660-9-xuanzhuo@linux.alibaba.com/
> > >
> > > Then the driver must do dma operation(map and sync) by these virtio_dma_* APIs.
> > > No care the device is non-dma device or dma device.
> >
> > yes
> >
> > > Then the AF_XDP must use these virtio_dma_* APIs for virtio device.
> >
> > We'll worry about AF_XDP when the patch is posted.
>
> YES.
>
> We discussed it. They voted 'no'.
>
> http://lore.kernel.org/all/20230424082856.15c1e593@kernel.org


Hi guys, this topic is stuck again. How should I proceed with this work?

Let me briefly summarize:
1. The problem with adding virtio_dma_{map, sync} api is that, for AF_XDP and
the driver layer, we need to support these APIs. The current conclusion of
AF_XDP is no.

2. Set dma_set_mask_and_coherent, then we can use DMA API uniformly inside
driver. This idea seems to be inconsistent with the framework design of DMA. The
conclusion is no.

3. We noticed that if the virtio device supports VIRTIO_F_ACCESS_PLATFORM, it
uses DMA API. And this type of device is the future direction, so we only
support DMA premapped for this type of virtio device. The problem with this
solution is that virtqueue_dma_dev() only returns dev in some cases, because
VIRTIO_F_ACCESS_PLATFORM is supported in such cases. Otherwise NULL is returned.
This option is currently NO.

So I'm wondering what should I do, from a DMA point of view, is there any
solution in case of using DMA API?

Thank you



>
> Thanks.
>
>
> >
> > --
> > MST
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
