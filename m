Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E924C001B0
	for <virtualization@archiver.kernel.org>; Fri, 14 Jul 2023 02:12:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BCA3B83EE9;
	Fri, 14 Jul 2023 02:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCA3B83EE9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QEMBiq41MjrR; Fri, 14 Jul 2023 02:12:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3B55C83ED2;
	Fri, 14 Jul 2023 02:12:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B55C83ED2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17820C0072;
	Fri, 14 Jul 2023 02:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 745FAC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 02:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B71560D78
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 02:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B71560D78
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mKQOXJGiUjwc
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 02:12:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE1F160B97
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CE1F160B97
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jul 2023 02:12:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=17; SR=0;
 TI=SMTPD_---0VnJx2Sq_1689300763; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VnJx2Sq_1689300763) by smtp.aliyun-inc.com;
 Fri, 14 Jul 2023 10:12:44 +0800
Message-ID: <1689300651.6874406-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next V1 0/4] virtio_net: add per queue interrupt
 coalescing support
Date: Fri, 14 Jul 2023 10:10:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230710092005.5062-1-gavinl@nvidia.com>
 <20230713074001-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230713074001-mutt-send-email-mst@kernel.org>
Cc: hawk@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, edumazet@google.com,
 Gavin Li <gavinl@nvidia.com>, jiri@nvidia.com, kuba@kernel.org,
 bpf@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org
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

On Thu, 13 Jul 2023 07:40:12 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Jul 10, 2023 at 12:20:01PM +0300, Gavin Li wrote:
> > Currently, coalescing parameters are grouped for all transmit and receive
> > virtqueues. This patch series add support to set or get the parameters for
> > a specified virtqueue.
> >
> > When the traffic between virtqueues is unbalanced, for example, one virtqueue
> > is busy and another virtqueue is idle, then it will be very useful to
> > control coalescing parameters at the virtqueue granularity.
>
> series:
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>


Why?

This series has the bug I reported.

Are you thinking that is ok? Or this is not a bug?

Thanks.



>
>
>
> > Example command:
> > $ ethtool -Q eth5 queue_mask 0x1 --coalesce tx-packets 10
> > Would set max_packets=10 to VQ 1.
> > $ ethtool -Q eth5 queue_mask 0x1 --coalesce rx-packets 10
> > Would set max_packets=10 to VQ 0.
> > $ ethtool -Q eth5 queue_mask 0x1 --show-coalesce
> >  Queue: 0
> >  Adaptive RX: off  TX: off
> >  stats-block-usecs: 0
> >  sample-interval: 0
> >  pkt-rate-low: 0
> >  pkt-rate-high: 0
> >
> >  rx-usecs: 222
> >  rx-frames: 0
> >  rx-usecs-irq: 0
> >  rx-frames-irq: 256
> >
> >  tx-usecs: 222
> >  tx-frames: 0
> >  tx-usecs-irq: 0
> >  tx-frames-irq: 256
> >
> >  rx-usecs-low: 0
> >  rx-frame-low: 0
> >  tx-usecs-low: 0
> >  tx-frame-low: 0
> >
> >  rx-usecs-high: 0
> >  rx-frame-high: 0
> >  tx-usecs-high: 0
> >  tx-frame-high: 0
> >
> > In this patch series:
> > Patch-1: Extract interrupt coalescing settings to a structure.
> > Patch-2: Extract get/set interrupt coalesce to a function.
> > Patch-3: Support per queue interrupt coalesce command.
> > Patch-4: Enable per queue interrupt coalesce feature.
> >
> > Gavin Li (4):
> >   virtio_net: extract interrupt coalescing settings to a structure
> >   virtio_net: extract get/set interrupt coalesce to a function
> >   virtio_net: support per queue interrupt coalesce command
> >   virtio_net: enable per queue interrupt coalesce feature
> >
> >  drivers/net/virtio_net.c        | 169 ++++++++++++++++++++++++++------
> >  include/uapi/linux/virtio_net.h |  14 +++
> >  2 files changed, 154 insertions(+), 29 deletions(-)
> >
> > --
> > 2.39.1
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
