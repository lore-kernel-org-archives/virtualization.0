Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72FDC61DA4
	for <virtualization@archiver.kernel.org>; Thu, 16 Feb 2023 11:50:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 51BF54189E;
	Thu, 16 Feb 2023 11:50:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 51BF54189E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AG_SDll4KrCy; Thu, 16 Feb 2023 11:50:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8EADC408D9;
	Thu, 16 Feb 2023 11:50:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8EADC408D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E4F1C0033;
	Thu, 16 Feb 2023 11:50:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9620CC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 11:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70C7681F72
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 11:50:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 70C7681F72
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3KzHfRbS8QAW
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 11:50:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 37B4181F68
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 37B4181F68
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Feb 2023 11:50:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R411e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VboRG7-_1676548241; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VboRG7-_1676548241) by smtp.aliyun-inc.com;
 Thu, 16 Feb 2023 19:50:42 +0800
Message-ID: <1676547964.6918266-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost 00/10] virtio core prepares for AF_XDP
Date: Thu, 16 Feb 2023 19:46:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsMfBLByXpPrHXDcsDdQmJSQAp-HEanCAn1-d8kFtFYJQ@mail.gmail.com>
In-Reply-To: <CACGkMEsMfBLByXpPrHXDcsDdQmJSQAp-HEanCAn1-d8kFtFYJQ@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
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

On Thu, 16 Feb 2023 13:27:00 +0800, Jason Wang <jasowang@redhat.com> wrote:
> On Tue, Feb 14, 2023 at 3:27 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> > copy feature of xsk (XDP socket) needs to be supported by the driver. The
> > performance of zero copy is very good.
> >
> > ENV: Qemu with vhost.
> >
> >                    vhost cpu | Guest APP CPU |Guest Softirq CPU | PPS
> > -----------------------------|---------------|------------------|------------
> > xmit by sockperf:     90%    |   100%        |                  |  318967
> > xmit by xsk:          100%   |   30%         |   33%            | 1192064
>
> What's the setup of this test?
>
> CPU model/frequency, packet size, zerocopy enabled or not.

Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz

zerocopy: enabled

size: 64


>
> (I remember I can get better performance with my old laptop through
> pktgen (about 2Mpps))

Let's compare sockperf just.

The result of the test on Alibaba Cloud was 3.5M+PPS/60%cpu.

Thanks.


>
> Thanks
>
> > recv by sockperf:     100%   |   68%         |   100%           |  692288
> > recv by xsk:          100%   |   33%         |   43%            |  771670
> >
> > Before achieving the function of Virtio-Net, we also have to let virtio core
> > support these features:
> >
> > 1. virtio core support premapped
> > 2. virtio core support reset per-queue
> > 3. introduce DMA APIs to virtio core
> >
> > Please review.
> >
> > Thanks.
> >
> > Xuan Zhuo (10):
> >   virtio_ring: split: refactor virtqueue_add_split() for premapped
> >   virtio_ring: packed: separate prepare code from
> >     virtuque_add_indirect_packed()
> >   virtio_ring: packed: refactor virtqueue_add_packed() for premapped
> >   virtio_ring: split: introduce virtqueue_add_split_premapped()
> >   virtio_ring: packed: introduce virtqueue_add_packed_premapped()
> >   virtio_ring: introduce virtqueue_add_inbuf_premapped()
> >   virtio_ring: add api virtio_dma_map() for advance dma
> >   virtio_ring: introduce dma sync api for virtio
> >   virtio_ring: correct the expression of the description of
> >     virtqueue_resize()
> >   virtio_ring: introduce virtqueue_reset()
> >
> >  drivers/virtio/virtio_ring.c | 792 ++++++++++++++++++++++++++++-------
> >  include/linux/virtio.h       |  29 ++
> >  2 files changed, 659 insertions(+), 162 deletions(-)
> >
> > --
> > 2.32.0.3.g01195cf9f
> >
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
