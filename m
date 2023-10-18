Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9925CDB47E
	for <virtualization@archiver.kernel.org>; Wed, 18 Oct 2023 09:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36303822EA;
	Wed, 18 Oct 2023 09:19:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 36303822EA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TR-D8lF2lYI1; Wed, 18 Oct 2023 09:19:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B69FB822F9;
	Wed, 18 Oct 2023 09:19:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B69FB822F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79A9AC0071;
	Wed, 18 Oct 2023 09:19:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38C7CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:19:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 076DC822F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:19:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 076DC822F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sz7KhJT6GmlD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:19:35 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 812A8822EA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Oct 2023 09:19:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 812A8822EA
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R921e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VuQCd7i_1697620768; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VuQCd7i_1697620768) by smtp.aliyun-inc.com;
 Wed, 18 Oct 2023 17:19:29 +0800
Message-ID: <1697620622.3183842-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 02/22] virtio_ring: introduce
 virtqueue_dma_[un]map_page_attrs
Date: Wed, 18 Oct 2023 17:17:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
 <20231011092728.105904-3-xuanzhuo@linux.alibaba.com>
 <1697615580.6880193-1-xuanzhuo@linux.alibaba.com>
 <20231018035751-mutt-send-email-mst@kernel.org>
 <1697616022.630633-2-xuanzhuo@linux.alibaba.com>
 <20231018044204-mutt-send-email-mst@kernel.org>
 <1697619441.5367694-3-xuanzhuo@linux.alibaba.com>
 <20231018051201-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018051201-mutt-send-email-mst@kernel.org>
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

On Wed, 18 Oct 2023 05:13:44 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Oct 18, 2023 at 04:57:21PM +0800, Xuan Zhuo wrote:
> > On Wed, 18 Oct 2023 04:44:24 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Oct 18, 2023 at 04:00:22PM +0800, Xuan Zhuo wrote:
> > > > On Wed, 18 Oct 2023 03:59:03 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > > On Wed, Oct 18, 2023 at 03:53:00PM +0800, Xuan Zhuo wrote:
> > > > > > Hi Michael,
> > > > > >
> > > > > > Do you think it's appropriate to push the first two patches of this patch set to
> > > > > > linux 6.6?
> > > > > >
> > > > > > Thanks.
> > > > >
> > > > > I generally treat patchsets as a whole unless someone asks me to do
> > > > > otherwise. Why do you want this?
> > > >
> > > > As we discussed, the patch set supporting AF_XDP will be push to net-next.
> > > > But the two patchs belong to the vhost.
> > > >
> > > > So, if you think that is appropriate, I will post a new patchset(include the two
> > > > patchs without virtio-net + AF_XDP) to vhost. I wish that can be merged to 6.6.
> > >
> > > Oh wait 6.6? Too late really, merge window has been closed for weeks.
> >
> > I mean as a fix. So I ask you do you think it is appropriate?
>
> Sure if there's a bugfix please post is separately - what issues do
> these two patches fix? this is the part I'm missing. Especially patch 2
> which just adds a new API.


No bugfix. That is the requirement of the supporting AF_XDP.

So please ignore my question. Sorry ^_^.

Thanks.


>
> > >
> > > > Then when the 6.7 net-next merge window is open, I can push this patch set to 6.7.
> > > > The v1 version use the virtqueue_dma_map_single_attrs to replace
> > > > virtqueue_dma_map_page_attrs. But I think we should use virtqueue_dma_map_page_attrs.
> > > >
> > > > Thanks.
> > > >
> > >
> > > Get a complete working patchset that causes no regressions posted first please
> > > then we will discuss merge strategy.
> > > I would maybe just put everything in one file for now, easier to merge,
> > > refactor later when it's all upstream. But up to you.
> >
> > OK. I will get a working patchset firstly.
> >
> > Thanks.
> >
> > >
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
