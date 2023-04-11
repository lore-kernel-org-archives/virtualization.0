Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6842DC76196
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 02:01:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1421613FE;
	Tue, 11 Apr 2023 02:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1421613FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nxUh3_o-XixU; Tue, 11 Apr 2023 02:01:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2829E60F13;
	Tue, 11 Apr 2023 02:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2829E60F13
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8946C0037;
	Tue, 11 Apr 2023 02:01:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86BE9C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:01:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BB954055F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:01:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5BB954055F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YgOQHsSn1ph8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:01:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C69EE40298
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C69EE40298
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 02:01:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0Vfq6Rmu_1681178467; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vfq6Rmu_1681178467) by smtp.aliyun-inc.com;
 Tue, 11 Apr 2023 10:01:08 +0800
Message-ID: <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Tue, 11 Apr 2023 09:56:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Christoph Hellwig <hch@infradead.org>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
In-Reply-To: <ZDQq0pDVkr8TvoTM@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, 10 Apr 2023 08:27:14 -0700, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Apr 10, 2023 at 01:14:13PM +0800, Jason Wang wrote:
> > > But rethink, this is unreliable. Some platforms have returned their own ops,
> > > including X86.
> > >
> > > Because the priority of dev->dma_ops is higher than get_arch_dma_ops(), we
> > > should not let dev->dma_ops be null. We should define a set of dma_ops to
> > > actively implement direct dMA.
> >
> > Then this will duplicate with existing DMA API helpers. Could we tweak
> > the sparc or introduce a new flag for the device structure then the
> > DMA API knows it needs to use direct mapping?
> >
> > Adding Christoph for more comments.
>
> Code outside of the core kernel/dma/ code has no business doing
> anything with the dma_ops.

Do you mean we should not change the dma_ops from the outside of the core
kernel/dma/?

How about adding one new "dma_direct" to struct devive?

--- a/include/linux/dma-map-ops.h
+++ b/include/linux/dma-map-ops.h
@@ -88,6 +88,9 @@ struct dma_map_ops {

 static inline const struct dma_map_ops *get_dma_ops(struct device *dev)
 {
+       if (dev->dma_direct)
+               return NULL;
+
        if (dev->dma_ops)
                return dev->dma_ops;
        return get_arch_dma_ops();


Thanks.



> WTF is going on?
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
