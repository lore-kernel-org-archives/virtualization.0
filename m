Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A83C77B73
	for <virtualization@archiver.kernel.org>; Wed, 19 Apr 2023 05:10:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3267081FA8;
	Wed, 19 Apr 2023 05:10:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3267081FA8
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kmqCtpP7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n6LySW792XTF; Wed, 19 Apr 2023 05:10:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C005E81FAC;
	Wed, 19 Apr 2023 05:10:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C005E81FAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88E94C007A;
	Wed, 19 Apr 2023 05:10:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4DDEC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 96F6881FA8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:10:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 96F6881FA8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RJZLxqpnI4FT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:10:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEA2381F91
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEA2381F91
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Apr 2023 05:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Hlt4ClBcH4Zpv14Jo5nP3ouuHzLmtcUPYoMH//ixe80=; b=kmqCtpP7PbmZQe9mZOCdGpu/ZQ
 dmrys8EsW/yGCGGt9ZGJ5W9yWkxhcBZVEr9OKCAP2qpGKTEdWehiEkpkY6twsp2W+GUR0PgnELPNK
 dNxOT+qRTXYRkxf1XTcX31/M5N3m2DYKHZ+56aitJzAcTFp4WlGViXFPBKDV8TB8mfl4hiwLoSm+Z
 acPKdWS/M5OqX04tMV2uTUum6dHJMiayELXyNxAN4uExRBunV8F1SSeS+DQ29a3AGTe2nRxNQ0jGx
 yCnyNNSYkkLHVbDFCylJJ9v2++yeOYoTKrz9QN/l6F31qUcSFaDOeP94RtmNKyAWXAGqs+U6B6c5N
 pnnRXQiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pp04x-0044st-2c; Wed, 19 Apr 2023 05:10:03 +0000
Date: Tue, 18 Apr 2023 22:10:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZD93q4C5DkBK4lTI@infradead.org>
References: <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <ZDTTXCPaW8D1nW4C@infradead.org>
 <1681194222.3822775-2-xuanzhuo@linux.alibaba.com>
 <ZDT+hc2XsqbVifjL@infradead.org>
 <1681194809.9329011-4-xuanzhuo@linux.alibaba.com>
 <ZDUCDeYLqAwQVJe7@infradead.org>
 <1681197823.3277218-8-xuanzhuo@linux.alibaba.com>
 <ZDVPkw/AoNwlJ2tl@infradead.org>
 <1681798732.0641289-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681798732.0641289-1-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 18, 2023 at 02:18:52PM +0800, Xuan Zhuo wrote:
> Sorry, rethink about this, I think we maybe misunderstand something.
> 
> First of all, let me give you a brief introduce of virtio device and pci device.
> If I make mistake, please point out.
> 
> 
> First, when one virtio pci device is probed, then the virtio pci driver will be
> called. Then we got one pci_device.

Yes.

> Then virtio_pci_probe will alloc one new device, and register it to virtio bus
> by register_virtio_device().
> 
> 
> So here we have two device: pci-device and virtio-device.

Yes.

> If we call DMA API inside virtio, we use the pci-device. The virtio-device is
> not used for DMA API.

Exactly.

> Now we want to use the virtio-device to do direct dma. The virtio-device
> is created by virtio_pci_probe() of virtio pci driver. And register to virtio
> bus. So no firmware and not iommu and the bus is virtio bus, why we can not
> change the dma_ops of virtio-device?

Because firmware doesn't know about your virtio-device.  It is just a
made up Linux concept, and the IOMMU and firmware tables for it don't
know about it.  DMA must only ever be done on actual physical
(including "physical" devices emulated by a hypervisor) devices, not
on devices made up by Linux.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
