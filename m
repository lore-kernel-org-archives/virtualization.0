Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE7BEB64DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 03:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BDC5140B9A;
	Tue, 11 Jul 2023 03:13:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDC5140B9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pDNGe4gSNwOg; Tue, 11 Jul 2023 03:13:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C57A40BEE;
	Tue, 11 Jul 2023 03:13:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C57A40BEE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D82C0072;
	Tue, 11 Jul 2023 03:13:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E717C0072
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 03:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5BA1261063
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 03:13:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BA1261063
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-6ExqB50Qrg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 03:13:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8E90760E2E
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E90760E2E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 03:13:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=18; SR=0;
 TI=SMTPD_---0Vn6n-l6_1689045189; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vn6n-l6_1689045189) by smtp.aliyun-inc.com;
 Tue, 11 Jul 2023 11:13:09 +0800
Message-ID: <1689045049.360526-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Date: Tue, 11 Jul 2023 11:10:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Gavin Li <gavinl@nvidia.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <1688981109.6377137-1-xuanzhuo@linux.alibaba.com>
 <ea32a1cf-3a77-d63b-034f-0f80d2dd80ea@nvidia.com>
In-Reply-To: <ea32a1cf-3a77-d63b-034f-0f80d2dd80ea@nvidia.com>
Cc: ast@kernel.org, hawk@kernel.org, daniel@iogearbox.net, mst@redhat.com,
 netdev@vger.kernel.org, john.fastabend@gmail.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 Heng Qi <hengqi@linux.alibaba.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Tue, 11 Jul 2023 10:34:33 +0800, Gavin Li <gavinl@nvidia.com> wrote:
>
> On 7/10/2023 5:25 PM, Xuan Zhuo wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, 10 Jul 2023 12:20:01 +0300, Gavin Li <gavinl@nvidia.com> wrote:
> >
> > As far as I know, Heng Qi does that. I'm not sure, it's the same piece.
> >
> > cc @Heng Qi
> >
> > Thanks.
> Do you mean the one below?

YES


>
> https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>
> The code is to implement what it described and I don't have better
> words. So, I copied the text from Heng Qi's.

Maybe he wrote code for it. I think you should ask him about his plans first.

Thanks.


>
> >
> >
> >> Currently, coalescing parameters are grouped for all transmit and receive
> >> virtqueues. This patch series add support to set or get the parameters for
> >> a specified virtqueue.
> >>
> >> When the traffic between virtqueues is unbalanced, for example, one virtqueue
> >> is busy and another virtqueue is idle, then it will be very useful to
> >> control coalescing parameters at the virtqueue granularity.
> >>
> >> Example command:
> >> $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> >> Would set max_packets=10 to VQ 1.
> >> $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> >> Would set max_packets=10 to VQ 0.
> >> $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> >>   Queue: 0
> >>   Adaptive RX: off  TX: off
> >>   stats-block-usecs: 0
> >>   sample-interval: 0
> >>   pkt-rate-low: 0
> >>   pkt-rate-high: 0
> >>
> >>   rx-usecs: 222
> >>   rx-frames: 0
> >>   rx-usecs-irq: 0
> >>   rx-frames-irq: 256
> >>
> >>   tx-usecs: 222
> >>   tx-frames: 0
> >>   tx-usecs-irq: 0
> >>   tx-frames-irq: 256
> >>
> >>   rx-usecs-low: 0
> >>   rx-frame-low: 0
> >>   tx-usecs-low: 0
> >>   tx-frame-low: 0
> >>
> >>   rx-usecs-high: 0
> >>   rx-frame-high: 0
> >>   tx-usecs-high: 0
> >>   tx-frame-high: 0
> >>
> >> In this patch series:
> >> Patch-1: Extract interrupt coalescing settings to a structure.
> >> Patch-2: Extract get/set interrupt coalesce to a function.
> >> Patch-3: Support per queue interrupt coalesce command.
> >> Patch-4: Enable per queue interrupt coalesce feature.
> >>
> >> Gavin Li (4):
> >>    virtio_net: extract interrupt coalescing settings to a structure
> >>    virtio_net: extract get/set interrupt coalesce to a function
> >>    virtio_net: support per queue interrupt coalesce command
> >>    virtio_net: enable per queue interrupt coalesce feature
> >>
> >>   drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> >>   include/uapi/linux/virtio_net.h |  14 +++
> >>   2 files changed, 154 insertions(+), 29 deletions(-)
> >>
> >> --
> >> 2.39.1
> >>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
