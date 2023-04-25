Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41333C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 02:13:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B209D81E75;
	Tue, 25 Apr 2023 02:13:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B209D81E75
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZHy3JnrBTSl7; Tue, 25 Apr 2023 02:13:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 34A2981E27;
	Tue, 25 Apr 2023 02:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34A2981E27
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F229C0037;
	Tue, 25 Apr 2023 02:12:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7E38C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 02:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 992C081E75
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 02:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 992C081E75
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8fQRhTC1BQzU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 02:12:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7887181E27
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7887181E27
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 02:12:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R371e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=24; SR=0;
 TI=SMTPD_---0VgxqdjV_1682388766; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgxqdjV_1682388766) by smtp.aliyun-inc.com;
 Tue, 25 Apr 2023 10:12:47 +0800
Message-ID: <1682388702.2032197-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Tue, 25 Apr 2023 10:11:42 +0800
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
 <20230419094506.2658b73f@kernel.org>
 <ZEDZaitjcX+egzvf@infradead.org>
 <20230420071349.5e441027@kernel.org>
 <1682062264.418752-2-xuanzhuo@linux.alibaba.com>
 <20230421065059.1bc78133@kernel.org>
 <5ec6f5e4-7b6a-17b3-492c-44364644f155@intel.com>
In-Reply-To: <5ec6f5e4-7b6a-17b3-492c-44364644f155@intel.com>
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

On Mon, 24 Apr 2023 17:28:01 +0200, Alexander Lobakin <aleksander.lobakin@intel.com> wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Fri, 21 Apr 2023 06:50:59 -0700
>
> > On Fri, 21 Apr 2023 15:31:04 +0800 Xuan Zhuo wrote:
> >> I am not particularly familiar with dma-bufs. I want to know if this mechanism
> >> can solve the problem of virtio-net.
> >>
> >> I saw this framework, allowing the driver do something inside the ops of
> >> dma-bufs.
> >>
> >> If so, is it possible to propose a new patch based on dma-bufs?
> >
> > I haven't looked in detail, maybe Olek has? AFAIU you'd need to rework
>
> Oh no, not me. I suck at dma-bufs, tried to understand them several
> times with no progress :D My knowledge is limited to "ok, if it's
> DMA + userspace, then it's likely dma-buf" :smile_with_tear:
>
> > uAPI of XSK to allow user to pass in a dma-buf region rather than just
> > a user VA. So it may be a larger effort but architecturally it may be
> > the right solution.
> >
>
> I'm curious whether this could be done without tons of work. Switching
> Page Pool to dma_alloc_noncoherent() is simpler :D But, as I wrote
> above, we need to extend DMA API first to provide bulk allocations and
> NUMA-aware allocations.
> Can't we provide a shim for back-compat, i.e. if a program passes just a
> user VA, create a dma-buf in the kernel already?


Yes

I think so too. If this is the case, will the workload be much smaller? Let me
try it.

Thanks.


>
> Thanks,
> Olek
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
