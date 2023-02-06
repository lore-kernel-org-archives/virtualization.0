Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D18C636CD
	for <virtualization@archiver.kernel.org>; Mon,  6 Feb 2023 02:47:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1BE3E813DE;
	Mon,  6 Feb 2023 02:47:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BE3E813DE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h-qy-3G_eABk; Mon,  6 Feb 2023 02:47:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9E80E813CB;
	Mon,  6 Feb 2023 02:47:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E80E813CB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A8FC0032;
	Mon,  6 Feb 2023 02:47:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36874C002B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 02:46:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04C9D813D4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 02:46:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04C9D813D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5kkKjsWySntX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 02:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C994C813CB
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C994C813CB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  6 Feb 2023 02:46:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VawTkZu_1675651606; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VawTkZu_1675651606) by smtp.aliyun-inc.com;
 Mon, 06 Feb 2023 10:46:47 +0800
Message-ID: <1675651276.3841548-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/33] virtio-net: support AF_XDP zero copy
Date: Mon, 6 Feb 2023 10:41:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <5fda6140fa51b4d2944f77b9e24446e4625641e2.camel@redhat.com>
 <1675395211.6279888-2-xuanzhuo@linux.alibaba.com>
 <20230203034212-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230203034212-mutt-send-email-mst@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
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

On Fri, 3 Feb 2023 04:17:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Fri, Feb 03, 2023 at 11:33:31AM +0800, Xuan Zhuo wrote:
> > On Thu, 02 Feb 2023 15:41:44 +0100, Paolo Abeni <pabeni@redhat.com> wrote:
> > > On Thu, 2023-02-02 at 19:00 +0800, Xuan Zhuo wrote:
> > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > > > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > > > performance of zero copy is very good. mlx5 and intel ixgbe already support
> > > > this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> > > > feature.
> > > >
> > > > Virtio-net did not support per-queue reset, so it was impossible to support XDP
> > > > Socket Zerocopy. At present, we have completed the work of Virtio Spec and
> > > > Kernel in Per-Queue Reset. It is time for Virtio-Net to complete the support for
> > > > the XDP Socket Zerocopy.
> > > >
> > > > Virtio-net can not increase the queue at will, so xsk shares the queue with
> > > > kernel.
> > > >
> > > > On the other hand, Virtio-Net does not support generate interrupt manually, so
> > > > when we wakeup tx xmit, we used some tips. If the CPU run by TX NAPI last time
> > > > is other CPUs, use IPI to wake up NAPI on the remote CPU. If it is also the
> > > > local CPU, then we wake up sofrirqd.
> > >
> > > Thank you for the large effort.
> > >
> > > Since this will likely need a few iterations, on next revision please
> > > do split the work in multiple chunks to help the reviewer efforts -
> > > from Documentation/process/maintainer-netdev.rst:
> > >
> > >  - don't post large series (> 15 patches), break them up
> > >
> > > In this case I guess you can split it in 1 (or even 2) pre-req series
> > > and another one for the actual xsk zero copy support.
> >
> >
> > OK.
> >
> > I can split patch into multiple parts such as
> >
> > * virtio core
> > * xsk
> > * virtio-net prepare
> > * virtio-net support xsk zerocopy
> >
> > However, there is a problem, the virtio core part should enter the VHOST branch
> > of Michael. Then, should I post follow-up patches to which branch vhost or
> > next-next?
> >
> > Thanks.
> >
>
> Here are some ideas on how to make the patchset smaller
> and easier to merge:
> - keep everything in virtio_net.c for now. We can split
>   things out later, but this way your patchset will not
>   conflict with every since change merged meanwhile.
>   Also, split up needs to be done carefully with sane
>   APIs between components, let's maybe not waste time
>   on that now, do the split-up later.
> - you have patches that add APIs then other
>   patches use them. as long as it's only virtio net just
>   add and use in a single patch, review is actually easier this way.

I will try to merge #16-#18 and #20-#23.


> - we can try merging pre-requisites earlier, then patchset
>   size will shrink.

Do you mean the patches of virtio core? Should we put these
patches to vhost branch?

Thanks.

>
>
> > >
> > > Thanks!
> > >
> > > Paolo
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
