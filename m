Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D90C4332F
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 13:34:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF9D1827C5;
	Thu, 24 Feb 2022 13:34:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nF72BAsA5AmB; Thu, 24 Feb 2022 13:34:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BCB4E81D7C;
	Thu, 24 Feb 2022 13:34:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 936B5C0021;
	Thu, 24 Feb 2022 13:34:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01F0EC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:34:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E4CB9415C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l2TzKOR1-2ns
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:34:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F064B40928
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FsO7bPKCV3C+M1TmyA8utq7bBJP2VWHvNICABqAl79U=; b=S7udAxLeP/5cwJAjGJh4uUL0Ry
 CcU+7HikmsczEpk++c4m8HqRS7wR08qeINQ8FJKz5mYPcL3oDMMTxGpc/vWlAjmKFWKTMz9N0SKmM
 BH8o4jn9w2gVBHn6lhKn7G7FOEWzDVkHbEFsMcUAU34NGYHXAGOu/cz7GEQmX09DadRgetvKqrOLH
 5H90zoraVUu6qPB1t+GTb+DPbVqF2yNoO5FGPpq9JWWdADWYa+BOxup3gZM44oC6ONha6VVhYBkx+
 ytuwHUnchJeSegXZo26fF3rxI5NQ/veEON4lUWRGmdNfdc3aKUe4gRZpyozB26wPVD2G9IQOZHa6Q
 o3NVLx+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nNEG1-000x30-BW; Thu, 24 Feb 2022 13:34:09 +0000
Date: Thu, 24 Feb 2022 05:34:09 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH] virtio-blk: Check the max discard segment for discard
 request
Message-ID: <YheJUTK8BKCjEQYF@infradead.org>
References: <20220223133627.102-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220223133627.102-1-xieyongji@bytedance.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mst@redhat.com
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

On Wed, Feb 23, 2022 at 09:36:27PM +0800, Xie Yongji wrote:
> Currently we have a BUG_ON() to make sure the number of sg list
> does not exceed queue_max_segments() in virtio_queue_rq().
> However, the block layer uses queue_max_discard_segments()
> instead of queue_max_segments() to limit the sg list for
> discard requests. So the BUG_ON() might be triggered if
> virtio-blk device reports a larger value for max discard
> segment than queue_max_segments(). To fix it, this patch
> checks the max discard segment for the discard request
> in the BUG_ON() instead.

This looks god, but jut removing the BUG_ON might be even better.
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
