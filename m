Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97259C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 05:17:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03B2B60C14;
	Wed, 20 Jul 2022 05:17:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 03B2B60C14
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a71tPE5m
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6pDEE3BJqQ3u; Wed, 20 Jul 2022 05:17:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F35D60BBD;
	Wed, 20 Jul 2022 05:16:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F35D60BBD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5407BC0033;
	Wed, 20 Jul 2022 05:16:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33493C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 05:16:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E357660BC1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 05:16:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E357660BC1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c0zOoF5PAvR9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 05:16:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D53F60BBD
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0D53F60BBD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 05:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=+Bj5xo3aBWzpgA1wxnI5L2KZvghnmty4TyKyCextdDY=; b=a71tPE5mXeW3OOa6Ki61VNAFN7
 qe6oaQig2z46CEFskkXRR2+vpeKovnxG7d+Zz/ha7q8DpJKBK70GyYUd4bZSZItK+gySP+6C0InhM
 FRV1Re1cCNyUOdMVH5c1ukvZAXbi+VZoMZl1ke8XjCyleZAJDa8j9FO1GrUBOP00V6kdOINqkAwm0
 Ewg5La+ZbRE0MICgJ5S0JvF1Rr9zhjYHFg41vMyAd01Wd9FMGYFR5JLbTzTf1QV8DxhLaXtHPdMe1
 4fQZxhdNitRhc3rtjftVw6Qcn/Kjk15Nj7T4NlmMGEKEHDxLqq2zFxzOsA3GLnqHmv+ck+xDgApYQ
 hz0iVRdQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1oE24l-000Sky-Qv; Wed, 20 Jul 2022 05:16:47 +0000
Date: Tue, 19 Jul 2022 22:16:47 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keir Fraser <keirf@google.com>
Subject: Re: [PATCH] virtio: Force DMA restricted devices through DMA API
Message-ID: <YtePv+AT+pqD2wHe@infradead.org>
References: <20220719100256.419780-1-keirf@google.com>
 <YtbMcBw4l0LAFn9+@infradead.org> <YtbRwO40CmIRWOUR@google.com>
 <YtbTGjRw65QEKkQA@infradead.org> <YtbXxl8STUtQkacb@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtbXxl8STUtQkacb@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, kernel-team@android.com
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

On Tue, Jul 19, 2022 at 04:11:50PM +0000, Keir Fraser wrote:
> Well here are two possible approaches:
> 
> 1. Revert e41b1355508d outright. I'm not even sure what it would mean
> for reported pages to go through IOMMU. And VIRTIO_F_ACCESS_PLATFORM
> is no longer IOMMU-specific anyway.
> 
> 2. Continue to clear the flag during virtio_balloon negotiation, but
> remember that it was offered, and test for that in vring_use_dma_api()
> as well as, or instead of, virtio_has_dma_quirk().
> 
> Do either of those appeal?

I'll have to defer to people that actually understand the virtio_balloon
code, because I haven't evey seriously looked at it.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
