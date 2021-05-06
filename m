Return-Path: <SRS0=qSBX=KB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C1C433B4
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 12:40:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23C5B60FD9
	for <virtualization@archiver.kernel.org>; Thu,  6 May 2021 12:40:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23C5B60FD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CC0E14023D;
	Thu,  6 May 2021 12:40:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h4qC69ayRgZL; Thu,  6 May 2021 12:40:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 79125401E3;
	Thu,  6 May 2021 12:40:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AA64C000E;
	Thu,  6 May 2021 12:40:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED882C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 12:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DBDA5831A5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 12:40:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tabg090PadFa
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 12:40:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C758083163
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 May 2021 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=AD0sAWVYmtsdfX/1qJIycAe6dGL+6Xym4wYSSCA/ZWA=; b=Knv76pWNR7EX+umtx0kknr9/zW
 4Cx84E+uUtdIKOw4KBknZRa9rQPuT0UKAytjyAeaiFMGcMJ4sdRYQEIInv+qpSdRYCMcpKVqXmeM8
 oXVNFhIf44UIR9zDAFInNMjJjblZca0Anf3ctjCUibF1hVQRi80ZJXwY6SRx1K63KnNpE1vgB6VPt
 E4vSa1UKZABtpAxlJ7qAg7HydfpvAR2VWF3aweASqb7UutsrASrZUn3fqyWe16JycCnSUJ09amKrO
 zT6oKwD0Mp17uaT6tUtwluYyFgzDEl4j1/zUv3bfWWu7H5yEWIH0teZBPkkeOzymiWYVaZivVLRsf
 FdWzGOhQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1ledGv-001iN8-3b; Thu, 06 May 2021 12:38:43 +0000
Date: Thu, 6 May 2021 13:38:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH V2 0/7] Do not read from descripto ring
Message-ID: <20210506123829.GA403858@infradead.org>
References: <20210423080942.2997-1-jasowang@redhat.com>
 <0e9d70b7-6c8a-4ff5-1fa9-3c4f04885bb8@redhat.com>
 <20210506041057-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210506041057-mutt-send-email-mst@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

On Thu, May 06, 2021 at 04:12:17AM -0400, Michael S. Tsirkin wrote:
> Let's try for just a bit, won't make this window anyway:
> 
> I have an old idea. Add a way to find out that unmap is a nop
> (or more exactly does not use the address/length).
> Then in that case even with DMA API we do not need
> the extra data. Hmm?

So we actually do have a check for that from the early days of the DMA
API, but it only works at compile time: CONFIG_NEED_DMA_MAP_STATE.

But given how rare configs without an iommu or swiotlb are these days
it has stopped to be very useful.  Unfortunately a runtime-version is
not entirely trivial, but maybe if we allow for false positives we
could do something like this

bool dma_direct_need_state(struct device *dev)
{
	/* some areas could not be covered by any map at all */
	if (dev->dma_range_map)
		return false;
	if (force_dma_unencrypted(dev))
		return false;
	if (dma_direct_need_sync(dev))
		return false;
	return *dev->dma_mask == DMA_BIT_MASK(64);
}

bool dma_need_state(struct device *dev)
{
	const struct dma_map_ops *ops = get_dma_ops(dev);

	if (dma_map_direct(dev, ops))
		return dma_direct_need_state(dev);
	return ops->unmap_page ||
		ops->sync_single_for_cpu || ops->sync_single_for_device;
}
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
