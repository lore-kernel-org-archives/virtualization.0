Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C1CC76195
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 12:21:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9712A41833;
	Tue, 21 Mar 2023 12:21:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9712A41833
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vjsPH6JUFnA6; Tue, 21 Mar 2023 12:21:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DB5D74180C;
	Tue, 21 Mar 2023 12:21:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DB5D74180C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6215C0035;
	Tue, 21 Mar 2023 12:21:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B066DC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:21:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 83E7881F68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:21:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 83E7881F68
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9cGO4Vgi7yzz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:21:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5A77E81FC8
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5A77E81FC8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 12:21:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeN-dCC_1679401303; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeN-dCC_1679401303) by smtp.aliyun-inc.com;
 Tue, 21 Mar 2023 20:21:44 +0800
Message-ID: <1679401220.8186114-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC net-next 0/8] virtio_net: refactor xdp codes
Date: Tue, 21 Mar 2023 20:20:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230315041042.88138-1-xuanzhuo@linux.alibaba.com>
 <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1679399929.1424522-1-xuanzhuo@linux.alibaba.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

On Tue, 21 Mar 2023 19:58:49 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> On Wed, 15 Mar 2023 12:10:34 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > Due to historical reasons, the implementation of XDP in virtio-net is relatively
> > chaotic. For example, the processing of XDP actions has two copies of similar
> > code. Such as page, xdp_page processing, etc.
> >
> > The purpose of this patch set is to refactor these code. Reduce the difficulty
> > of subsequent maintenance. Subsequent developers will not introduce new bugs
> > because of some complex logical relationships.
> >
> > In addition, the supporting to AF_XDP that I want to submit later will also need
> > to reuse the logic of XDP, such as the processing of actions, I don't want to
> > introduce a new similar code. In this way, I can reuse these codes in the
> > future.
> >
> > This patches are developed on the top of another patch set[1]. I may have to
> > wait to merge this. So this patch set is a RFC.
>
>
> Hi, Jason:
>
> Now, the patch set[1] has been in net-next. So this patch set can been merge
> into net-next.
>
> Please review.


I do not know why this patch set miss Jason. I send it normally. ^_^

Thanks.



>
> Thanks.
>
>
> >
> > Please review.
> >
> > Thanks.
> >
> > [1]. https://lore.kernel.org/netdev/20230315015223.89137-1-xuanzhuo@linux.alibaba.com/
> >
> >
> > Xuan Zhuo (8):
> >   virtio_net: mergeable xdp: put old page immediately
> >   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
> >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> >     run xdp
> >   virtio_net: separate the logic of freeing xdp shinfo
> >   virtio_net: separate the logic of freeing the rest mergeable buf
> >   virtio_net: auto release xdp shinfo
> >   virtio_net: introduce receive_mergeable_xdp()
> >   virtio_net: introduce receive_small_xdp()
> >
> >  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
> >  1 file changed, 357 insertions(+), 258 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
> > _______________________________________________
> > Virtualization mailing list
> > Virtualization@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/virtualization
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
