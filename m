Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFC0C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:37:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1624B401ED;
	Fri, 21 Apr 2023 07:37:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1624B401ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V6xgCTIhwnp4; Fri, 21 Apr 2023 07:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A1B6840148;
	Fri, 21 Apr 2023 07:37:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A1B6840148
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76D71C007A;
	Fri, 21 Apr 2023 07:37:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7414DC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4844D401ED
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:37:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4844D401ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eMYRolb6Uhad
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:37:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 800AA40148
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 800AA40148
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:37:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=23; SR=0;
 TI=SMTPD_---0VgbyT-R_1682062623; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgbyT-R_1682062623) by smtp.aliyun-inc.com;
 Fri, 21 Apr 2023 15:37:03 +0800
Message-ID: <1682062264.418752-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] xsk: introduce xsk_dma_ops
Date: Fri, 21 Apr 2023 15:31:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jakub Kicinski <kuba@kernel.org>
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
In-Reply-To: <20230420071349.5e441027@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, Paolo Abeni <pabeni@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>,
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

On Thu, 20 Apr 2023 07:13:49 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 19 Apr 2023 23:19:22 -0700 Christoph Hellwig wrote:
> > > In this case yes, pinned user memory, it gets sliced up into MTU sized
> > > chunks, fed into an Rx queue of a device, and user can see packets
> > > without any copies.
> >
> > How long is the life time of these mappings?  Because dma_map_*
> > assumes a temporary mapping and not one that is pinned bascically
> > forever.
>
> Yeah, this one is "for ever".
>
> > > Quite similar use case #2 is upcoming io_uring / "direct placement"
> > > patches (former from Meta, latter for Google) which will try to receive
> > > just the TCP data into pinned user memory.
> >
> > I don't think we can just long term pin user memory here.  E.g. for
> > confidential computing cases we can't even ever do DMA straight to
> > userspace.  I had that conversation with Meta's block folks who
> > want to do something similar with io_uring and the only option is an
> > an allocator for memory that is known DMAable, e.g. through dma-bufs.
> >
> > You guys really all need to get together and come up with a scheme
> > that actually works instead of piling these hacks over hacks.
>
> Okay, that simplifies various aspects. We'll just used dma-bufs from
> the start in the new APIs.


I am not particularly familiar with dma-bufs. I want to know if this mechanism
can solve the problem of virtio-net.

I saw this framework, allowing the driver do something inside the ops of
dma-bufs.

If so, is it possible to propose a new patch based on dma-bufs?

Thanks.




_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
