Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0019C77B60
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 07:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9344B614F2;
	Fri, 31 Mar 2023 07:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9344B614F2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BiC0NmI6eJrL; Fri, 31 Mar 2023 07:31:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EE2B360B0B;
	Fri, 31 Mar 2023 07:31:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EE2B360B0B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1F27C0036;
	Fri, 31 Mar 2023 07:31:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 34DA8C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:31:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0A1C28449E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:31:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A1C28449E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gRKZJ1p13fic
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:31:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2F268449D
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E2F268449D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 07:31:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vf1OBz8_1680247898; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vf1OBz8_1680247898) by smtp.aliyun-inc.com;
 Fri, 31 Mar 2023 15:31:39 +0800
Message-ID: <1680247317.9193828-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 00/16] virtio-net: split virtio-net.c
Date: Fri, 31 Mar 2023 15:21:57 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230328092847.91643-1-xuanzhuo@linux.alibaba.com>
 <20230330015412-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230330015412-mutt-send-email-mst@kernel.org>
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

On Thu, 30 Mar 2023 02:17:43 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Mar 28, 2023 at 05:28:31PM +0800, Xuan Zhuo wrote:
> > Considering the complexity of virtio-net.c and the new features we want
> > to add, it is time to split virtio-net.c into multiple independent
> > module files.
> >
> > This is beneficial to the maintenance and adding new functions.
> >
> > And AF_XDP support will be added later, then a separate xsk.c file will
> > be added.
> >
> > This patchset split virtio-net.c into these parts:
> >
> > * virtnet.c:         virtio net device ops (napi, tx, rx, device ops, ...)
> > * virtnet_common.c:  virtio net common code
> > * virtnet_ethtool.c: virtio net ethtool callbacks
> > * virtnet_ctrl.c:    virtio net ctrl queue command APIs
> > * virtnet_virtio.c:  virtio net virtio callbacks/ops (driver register, virtio probe, virtio free, ...)
> >
> > Please review.
> >
> > Thanks.
>
>
> I don't feel this is an improvement as presented, will need more work
> to make code placement more logical.

Yes, this does need some time and energy. But I think this always need to do,
just when to do it. I think it is currently an opportunity.


>
> For example where do I find code to update rq stats?
> Rx data path should be virtnet.c?
> No it's in virtnet_ethtool.c because rq stats can be
> accessed by ethtool.

That's what I do.

> A bunch of stuff seems to be in headers just because of technicalities.
> virtio common seems to be a dumping ground with no guiding principle at
> all.

Yes, I agree, with the development of time, common will indeed become a dumping
group. This is something we should pay attention to after this.


> drivers/net/virtio/virtnet_virtio.c is weird with
> virt repeated three times in the path.

Any good idea.

>
> These things only get murkier with time, at the point of reorg
> I would expect very logical placement, since
> without clear guiding rule finding where something is becomes harder but
> more importantly we'll now get endless heartburn about where does each new
> function go.
>
>
> The reorg is unfortunately not free - for example git log --follow will
> no longer easily match virtio because --follow works with exactly one
> path.

One day we will face this problem.

> It's now also extra work to keep headers self-consistent.

Can we make it simpler, first complete the split.


> So it better be a big improvement to be worth it.


Or about split, do you have any better thoughts? Or do you think we have always
been like this and make Virtio-Net more and more complicated?


Thanks.

>
>
>
>
> > Xuan Zhuo (16):
> >   virtio_net: add a separate directory for virtio-net
> >   virtio_net: move struct to header file
> >   virtio_net: add prefix to the struct inside header file
> >   virtio_net: separating cpu-related funs
> >   virtio_net: separate virtnet_ctrl_set_queues()
> >   virtio_net: separate virtnet_ctrl_set_mac_address()
> >   virtio_net: remove lock from virtnet_ack_link_announce()
> >   virtio_net: separating the APIs of cq
> >   virtio_net: introduce virtnet_rq_update_stats()
> >   virtio_net: separating the funcs of ethtool
> >   virtio_net: introduce virtnet_dev_rx_queue_group()
> >   virtio_net: introduce virtnet_get_netdev()
> >   virtio_net: prepare for virtio
> >   virtio_net: move virtnet_[en/dis]able_delayed_refill to header file
> >   virtio_net: add APIs to register/unregister virtio driver
> >   virtio_net: separating the virtio code
> >
> >  MAINTAINERS                                   |    2 +-
> >  drivers/net/Kconfig                           |    8 +-
> >  drivers/net/Makefile                          |    2 +-
> >  drivers/net/virtio/Kconfig                    |   11 +
> >  drivers/net/virtio/Makefile                   |   10 +
> >  .../net/{virtio_net.c => virtio/virtnet.c}    | 2368 ++---------------
> >  drivers/net/virtio/virtnet.h                  |  213 ++
> >  drivers/net/virtio/virtnet_common.c           |  138 +
> >  drivers/net/virtio/virtnet_common.h           |   14 +
> >  drivers/net/virtio/virtnet_ctrl.c             |  272 ++
> >  drivers/net/virtio/virtnet_ctrl.h             |   45 +
> >  drivers/net/virtio/virtnet_ethtool.c          |  578 ++++
> >  drivers/net/virtio/virtnet_ethtool.h          |    8 +
> >  drivers/net/virtio/virtnet_virtio.c           |  880 ++++++
> >  drivers/net/virtio/virtnet_virtio.h           |    8 +
> >  15 files changed, 2366 insertions(+), 2191 deletions(-)
> >  create mode 100644 drivers/net/virtio/Kconfig
> >  create mode 100644 drivers/net/virtio/Makefile
> >  rename drivers/net/{virtio_net.c => virtio/virtnet.c} (50%)
> >  create mode 100644 drivers/net/virtio/virtnet.h
> >  create mode 100644 drivers/net/virtio/virtnet_common.c
> >  create mode 100644 drivers/net/virtio/virtnet_common.h
> >  create mode 100644 drivers/net/virtio/virtnet_ctrl.c
> >  create mode 100644 drivers/net/virtio/virtnet_ctrl.h
> >  create mode 100644 drivers/net/virtio/virtnet_ethtool.c
> >  create mode 100644 drivers/net/virtio/virtnet_ethtool.h
> >  create mode 100644 drivers/net/virtio/virtnet_virtio.c
> >  create mode 100644 drivers/net/virtio/virtnet_virtio.h
> >
> > --
> > 2.32.0.3.g01195cf9f
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
