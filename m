Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9DFC77B61
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 03:26:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EB6774191C;
	Tue, 11 Apr 2023 03:26:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB6774191C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WWoVu5I1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t0LmLpQOXMvV; Tue, 11 Apr 2023 03:26:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6D6DA418F5;
	Tue, 11 Apr 2023 03:26:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6D6DA418F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 47EC2C0037;
	Tue, 11 Apr 2023 03:26:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA47DC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:26:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A63C7418F9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:26:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A63C7418F9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FP8cBpUTEXwK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:26:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AA644418F5
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AA644418F5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 03:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=DC5u8l4lJzbsQBRaLAkYVIiucfFkMjjITmrUllC4Hos=; b=WWoVu5I1cosjh/ODWQbzF3fHq6
 ZiAw0B7K1xhuSwFE7vheT8myPR+MvQINW1AprDJI0GHYx76AGMWfn/RUhDINOxT/6pyqmLXYe3cYR
 05AT6QKYsOUBxhqYy2zcEqXWlyHQA5RdYooNOf6r6u6SemcF1zkOuyuY9R8FJGRQj9aHDkvII/CjU
 6pEZbyMUzWS782+MsBAg8KIbdonnS/mbU+rQnOfXzeR8IGuwgsiKKDe9tenPaWQLYa8Y7joIJagXo
 wLOGVgtiW4CXsKRtCMCAoZegeNVhJy1c8uO2s6euEy1JJHmcKtojAXeSn+gZl6Ceipojhw6E53Ug2
 11Wg4HqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1pm4eC-00GK9s-29; Tue, 11 Apr 2023 03:26:20 +0000
Date: Mon, 10 Apr 2023 20:26:20 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Message-ID: <ZDTTXCPaW8D1nW4C@infradead.org>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Apr 11, 2023 at 09:56:19AM +0800, Xuan Zhuo wrote:
> Do you mean we should not change the dma_ops from the outside of the core
> kernel/dma/?

Basically, yes.  That plus probing for the IOMMU drivers.

> How about adding one new "dma_direct" to struct devive?

Why would we?

Can you please explain what you're even trying to do?  But checking
a dma_direct flag for sure isn't the solution.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
