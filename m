Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A7FC6FD1F
	for <virtualization@archiver.kernel.org>; Wed, 22 Mar 2023 03:59:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 745FD41511;
	Wed, 22 Mar 2023 03:59:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 745FD41511
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aL9p6BQj7TuM; Wed, 22 Mar 2023 03:59:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9F906413A3;
	Wed, 22 Mar 2023 03:59:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9F906413A3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66B08C0071;
	Wed, 22 Mar 2023 03:59:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B8EDC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70D6881F86
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:59:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70D6881F86
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MPtqh080SaAe
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:59:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78F2A81770
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78F2A81770
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 03:59:25 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R711e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0VePChuW_1679457557; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VePChuW_1679457557) by smtp.aliyun-inc.com;
 Wed, 22 Mar 2023 11:59:18 +0800
Message-ID: <1679457374.90297-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/8] virtio_net: refactor xdp codes
Date: Wed, 22 Mar 2023 11:56:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230321233325-mutt-send-email-mst@kernel.org>
 <1679456456.3777983-1-xuanzhuo@linux.alibaba.com>
 <20230321235326-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321235326-mutt-send-email-mst@kernel.org>
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

On Tue, 21 Mar 2023 23:53:52 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Wed, Mar 22, 2023 at 11:40:56AM +0800, Xuan Zhuo wrote:
> > On Tue, 21 Mar 2023 23:34:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Wed, Mar 22, 2023 at 11:03:00AM +0800, Xuan Zhuo wrote:
> > > > Due to historical reasons, the implementation of XDP in virtio-net is relatively
> > > > chaotic. For example, the processing of XDP actions has two copies of similar
> > > > code. Such as page, xdp_page processing, etc.
> > > >
> > > > The purpose of this patch set is to refactor these code. Reduce the difficulty
> > > > of subsequent maintenance. Subsequent developers will not introduce new bugs
> > > > because of some complex logical relationships.
> > > >
> > > > In addition, the supporting to AF_XDP that I want to submit later will also need
> > > > to reuse the logic of XDP, such as the processing of actions, I don't want to
> > > > introduce a new similar code. In this way, I can reuse these codes in the
> > > > future.
> > > >
> > > > Please review.
> > > >
> > > > Thanks.
> > >
> > > I really want to see that code make progress though.
> >
> > I want to know, you refer to virtio-net + AF_XDP or refactor for XDP.
> >
> > > Would it make sense to merge this one through the virtio tree?
> >
> > There are some small problems that we merge this patch-set to Virtio Tree
> > directly.
> >
> > Thanks.
>
> what exactly? is there a dependency on net-next?

There will be a conflict, I submitted to net before. Now net-next includes it.

[1]. https://lore.kernel.org/netdev/20230315015223.89137-1-xuanzhuo@linux.alibaba.com/

There are no other problems.

Thanks.

>
> > >
> > > Then you will have all the pieces in one place and try to target
> > > next linux.
> > >
> > >
> > > > Xuan Zhuo (8):
> > > >   virtio_net: mergeable xdp: put old page immediately
> > > >   virtio_net: mergeable xdp: introduce mergeable_xdp_prepare
> > > >   virtio_net: introduce virtnet_xdp_handler() to seprate the logic of
> > > >     run xdp
> > > >   virtio_net: separate the logic of freeing xdp shinfo
> > > >   virtio_net: separate the logic of freeing the rest mergeable buf
> > > >   virtio_net: auto release xdp shinfo
> > > >   virtio_net: introduce receive_mergeable_xdp()
> > > >   virtio_net: introduce receive_small_xdp()
> > > >
> > > >  drivers/net/virtio_net.c | 615 +++++++++++++++++++++++----------------
> > > >  1 file changed, 357 insertions(+), 258 deletions(-)
> > > >
> > > > --
> > > > 2.32.0.3.g01195cf9f
> > >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
