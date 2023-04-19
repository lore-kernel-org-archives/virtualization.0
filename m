Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F6BC6FD18
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 13:42:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0BC62605BA;
	Wed, 19 Apr 2023 13:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0BC62605BA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dYChdTTBfwc3; Wed, 19 Apr 2023 13:42:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D938605D8;
	Wed, 19 Apr 2023 13:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D938605D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7585AC0037;
	Wed, 19 Apr 2023 13:42:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01FB0C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:42:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DDBDB40439
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:41:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DDBDB40439
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2H2FyfQy302i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:41:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 644F5400F1
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 644F5400F1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 13:41:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=24; SR=0;
 TI=SMTPD_---0VgVGQZB_1681911709; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgVGQZB_1681911709) by smtp.aliyun-inc.com;
 Wed, 19 Apr 2023 21:41:50 +0800
Message-ID: <1681911643.4417202-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Wed, 19 Apr 2023 21:40:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
References: <20230417032750.7086-1-xuanzhuo@linux.alibaba.com>
 <ZDzKAD2SNe1q/XA6@infradead.org>
 <1681711081.378984-2-xuanzhuo@linux.alibaba.com>
 <20230417115610.7763a87c@kernel.org>
 <20230417115753.7fb64b68@kernel.org>
 <CACGkMEtPNPXFThHt4aNm4g-fC1DqTLcDnB_iBWb9-cAOHMYV_A@mail.gmail.com>
 <20230417181950.5db68526@kernel.org>
 <1681784379.909136-2-xuanzhuo@linux.alibaba.com>
 <20230417195400.482cfe75@kernel.org>
 <ZD4kMOym15pFcjq+@infradead.org>
 <20230417231947.3972f1a8@kernel.org>
 <ZD95RY9PjVRi7qz3@infradead.org>
 <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
In-Reply-To: <d18eea7a-a71c-8de0-bde3-7ab000a77539@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>, Jens Axboe <axboe@kernel.dk>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, bpf@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>
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

On Wed, 19 Apr 2023 15:14:48 +0200, Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> From: Christoph Hellwig <hch@infradead.org>
> Date: Tue, 18 Apr 2023 22:16:53 -0700
>
> > On Mon, Apr 17, 2023 at 11:19:47PM -0700, Jakub Kicinski wrote:
> >>> You can't just do dma mapping outside the driver, because there are
> >>> drivers that do not require DMA mapping at all.  virtio is an example,
> >>> but all the classic s390 drivers and some other odd virtualization
> >>> ones are others.
> >>
> >> What bus are the classic s390 on (in terms of the device model)?
> >
> > I think most of them are based on struct ccw_device, but I'll let the
> > s390 maintainers fill in.
> >
> > Another interesting case that isn't really relevant for your networking
> > guys, but that caused as problems is RDMA.  For hardware RDMA devices
> > it wants the ULPs to DMA map, but it turns out we have various software
> > drivers that map to network drivers that do their own DMA mapping
> > at a much lower layer and after potentially splitting packets or
> > even mangling them.
> >
> >>
> >>>> I don't think it's reasonable to be bubbling up custom per-subsystem
> >>>> DMA ops into all of them for the sake of virtio.
> >>>
> >>> dma addresses and thus dma mappings are completely driver specific.
> >>> Upper layers have no business looking at them.
>
> Here it's not an "upper layer". XSk core doesn't look at them or pass
> them between several drivers. It maps DMA solely via the struct device
> passed from the driver and then just gets-sets addresses for this driver
> only. Just like Page Pool does for regular Rx buffers. This got moved to
> the XSk core to not repeat the same code pattern in each driver.
>
> >>
> >> Damn, that's unfortunate. Thinking aloud -- that means that if we want
> >> to continue to pull memory management out of networking drivers to
> >> improve it for all, cross-optimize with the rest of the stack and
> >> allow various upcoming forms of zero copy -- then we need to add an
> >> equivalent of dma_ops and DMA API locally in networking?
>
> Managing DMA addresses is totally fine as long as you don't try to pass
> mapped addresses between different drivers :D Page Pool already does
> that and I don't see a problem in that in general.
>
> >
> > Can you explain what the actual use case is?
> >
> >>From the original patchset I suspect it is dma mapping something very
> > long term and then maybe doing syncs on it as needed?
>
> As I mentioned, XSk provides some handy wrappers to map DMA for drivers.
> Previously, XSk was supported by real hardware drivers only, but here
> the developer tries to add support to virtio-net. I suspect he needs to
> use DMA mapping functions different from which the regular driver use.
> So this is far from dma_map_ops, the author picked wrong name :D


Yes, dma_ops caused some misunderstandings, which is indeed a wrong name.

Thanks.


> And correct, for XSk we map one big piece of memory only once and then
> reuse it for buffers, no inflight map/unmap on hotpath (only syncs when
> needed). So this mapping is longterm and is stored in XSk core structure
> assigned to the driver which this mapping was done for.
> I think Jakub thinks of something similar, but for the "regular" Rx/Tx,
> not only XDP sockets :)
>
> Thanks,
> Olek
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
