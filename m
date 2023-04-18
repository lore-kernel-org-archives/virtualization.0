Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA5AC77B75
	for <virtualization@archiver.kernel.org>; Tue, 18 Apr 2023 06:31:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4D2B56131A;
	Tue, 18 Apr 2023 06:31:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4D2B56131A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7vQwdOUasf6O; Tue, 18 Apr 2023 06:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DD71A613BC;
	Tue, 18 Apr 2023 06:31:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD71A613BC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7F32C0037;
	Tue, 18 Apr 2023 06:31:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C42EFC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:31:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A713483BB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:31:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A713483BB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8pOR7z3vbrPB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:31:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AA3D983BA3
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AA3D983BA3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Apr 2023 06:31:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VgOGGJs_1681799494; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgOGGJs_1681799494) by smtp.aliyun-inc.com;
 Tue, 18 Apr 2023 14:31:35 +0800
Message-ID: <1681798732.0641289-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 18 Apr 2023 14:18:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <ZDTTXCPaW8D1nW4C@infradead.org>
 <1681194222.3822775-2-xuanzhuo@linux.alibaba.com>
 <ZDT+hc2XsqbVifjL@infradead.org>
 <1681194809.9329011-4-xuanzhuo@linux.alibaba.com>
 <ZDUCDeYLqAwQVJe7@infradead.org>
 <1681197823.3277218-8-xuanzhuo@linux.alibaba.com>
 <ZDVPkw/AoNwlJ2tl@infradead.org>
In-Reply-To: <ZDVPkw/AoNwlJ2tl@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Guenter Roeck <linux@roeck-us.net>,
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

On Tue, 11 Apr 2023 05:16:19 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Apr 11, 2023 at 03:23:43PM +0800, Xuan Zhuo wrote:
> > > If a direct map or not is used is a decision done by the platform code,
> > > often based on firmware tables.  You can't just override that.
> >
> >
> > Can Virtio Device set its own dma_ops? It is a device on the virtual bus. It
> > sets its own DMA_OPS. I think it is reasonable.
>
> No, it can't.  virtio devices are backed by PCI, platform or other
> bus devices, and the (often virtual) firmware controls how DMA mapping
> is to be performed for them, at least for the platform_access case.


Sorry, rethink about this, I think we maybe misunderstand something.

First of all, let me give you a brief introduce of virtio device and pci device.
If I make mistake, please point out.


First, when one virtio pci device is probed, then the virtio pci driver will be
called. Then we got one pci_device.

Then virtio_pci_probe will alloc one new device, and register it to virtio bus
by register_virtio_device().


So here we have two device: pci-device and virtio-device.

If we call DMA API inside virtio, we use the pci-device. The virtio-device is
not used for DMA API.

Now we want to use the virtio-device to do direct dma. The virtio-device
is created by virtio_pci_probe() of virtio pci driver. And register to virtio
bus. So no firmware and not iommu and the bus is virtio bus, why we can not
change the dma_ops of virtio-device?


Thanks.





































_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
