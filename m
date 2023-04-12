Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F0C7619A
	for <virtualization@archiver.kernel.org>; Wed, 12 Apr 2023 11:55:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E778741E27;
	Wed, 12 Apr 2023 11:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E778741E27
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NX92vPxj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KVVAlfAva-np; Wed, 12 Apr 2023 11:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25EFF408DD;
	Wed, 12 Apr 2023 11:55:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25EFF408DD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B21DEC0037;
	Wed, 12 Apr 2023 11:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93C0EC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 11:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 685568233D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 11:55:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 685568233D
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NX92vPxj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGg1MzXgyEaT
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 11:54:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0B4918230B
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B4918230B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Apr 2023 11:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=E7jhS3JdgTZerJzluPFl2gDl/bk0jtiuw7jd95fOsqA=; b=NX92vPxjegipd9/4yjbvyWlS5t
 F0fuje4fySpqTcwaWUrLIrS+DTyW7UO9YtPA95SJxfJYxQkhmFN2fe68X36L0qihse5B0//31O5U1
 CIHOnRWcEcgAq2h3hf01hUvJqT8G7r9fvcaZHLcaYMkaPX2AixKV9CgXkxJqSNobz/zDsDymm9jan
 RR0YyvpWgaHxVdI3c3f+lGUQl4c0xOi42XhLu/DyJGFgEtVnU8mMkLUZmi9IeqanEHu1kWdXFK7Hg
 YZO829eSldlJdLx6piWQyvT0eNiaj8K4BDxTM28BCzJlSnV8essY0x7mF6P4ACbQqPxcEYLsGkmEC
 3LB0gtiA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pmZ3u-002yMb-1J; Wed, 12 Apr 2023 11:54:54 +0000
Date: Wed, 12 Apr 2023 04:54:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZDacDi/THFo0UIfu@infradead.org>
References: <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
 <1681193477.0633929-1-xuanzhuo@linux.alibaba.com>
 <ZDT8S6Q9mzNa5dRh@infradead.org>
 <1681194480.146465-3-xuanzhuo@linux.alibaba.com>
 <1681265026.6082013-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681265026.6082013-1-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Guenter Roeck <linux@roeck-us.net>
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

On Wed, Apr 12, 2023 at 10:03:46AM +0800, Xuan Zhuo wrote:
> We discusses this question last at [1]. We planned to pass one device to xsk.
> Then xsk can use the DMA API on this device. The device can be one hw
> device(such as PCI, mmio) or virtio device. If it is one hw device, no problem.

What do you mean with one here?  A virtio device should never be baken
by more than one hardware device.

> If it is one virtio device, then we expect that DMA API on that will return
> direct dma map, because the dma_ops of the virtio device is NULL. But on some
> platform such as sparc64 or some case of x86, the arch has own dma_ops. So we
> wrong.

No, you can't expect a device to use any particular dma ops.  Most
platforms support either the direct mapping or some form of IOMMU.

But for virtio thinks are even more complicated - unless
VIRTIO_F_ACCESS_PLATFORM is set (which really must be set for all
real hardware devices for them to work), the DMA API isn't even used
at all.  That means the virtual platform (i.e.g qemu) does DMA based
on physical addresses and virtio ignores all the plaform DMA setup.

> And as the discuss of this thread, we cannot get direct dma address from
> virtio device by DMA API. So, we need xsk to expose the DMA ops to the
> virtio-net driver when virtio core can not use the DMA API.
> 
> All the processing of dma inside xsk:
> 1. map/unmap at enable/disable
> 2. dma sync

For the VIRTIO_F_ACCESS_PLATFORM you can just use the DMA API like
any other device, but this really should be done inside virtio instead
of an upper layer.

For the !VIRTIO_F_ACCESS_PLATFORM case there is no need to sync,
and the dma mapping is a simple virt_to_phys or page_to_phys, so
there's no real need to premap to start with.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
