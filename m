Return-Path: <SRS0=nl1Y=CC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AFBC433E1
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 15:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBD40206B5
	for <virtualization@archiver.kernel.org>; Mon, 24 Aug 2020 15:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD40206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6FEF32076B;
	Mon, 24 Aug 2020 15:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8malHmRvjOl; Mon, 24 Aug 2020 15:13:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 649492045C;
	Mon, 24 Aug 2020 15:13:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2349BC089E;
	Mon, 24 Aug 2020 15:13:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91644C0051;
 Mon, 24 Aug 2020 15:13:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7A2EB85FEF;
 Mon, 24 Aug 2020 15:13:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nlt021rrDdZe; Mon, 24 Aug 2020 15:13:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2AE00852E9;
 Mon, 24 Aug 2020 15:13:05 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 26FBD68AFE; Mon, 24 Aug 2020 17:13:01 +0200 (CEST)
Date: Mon, 24 Aug 2020 17:13:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: Is: virtio_gpu_object_shmem_init  issues? Was:Re: upstream
 boot error: general protection fault in swiotlb_map
Message-ID: <20200824151300.GA28575@lst.de>
References: <0000000000000c1f0005ac333382@google.com>
 <20200824150650.GD21321@char.us.oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200824150650.GD21321@char.us.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: thomas.tai@oracle.com, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 airlied@redhat.com, robin.murphy@arm.com, hch@lst.de,
 syzbot <syzbot+3f86afd0b1e4bf1cb64c@syzkaller.appspotmail.com>,
 m.szyprowski@samsung.com
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

On Mon, Aug 24, 2020 at 11:06:51AM -0400, Konrad Rzeszutek Wilk wrote:
> So it fails at
> 
> 683                 dev_WARN_ONCE(dev, 1,                                           
> 684                         "swiotlb addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> 685                         &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);   
> 
> 
> which makes no sense to me as `dev` surely exists. I can see in the console log:
> 
> virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
> 
> So what gives?

Well, look at the if around the WARN_ON - dma_capable failed on the
swiotlb buffer. This means the virtio drm thingy has a dma mask
(either the actual one set by the driver, or bus_dma_mask), which isn't
enough to address the swiotlb buffer.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
