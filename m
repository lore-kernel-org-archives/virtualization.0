Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B613C4332F
	for <virtualization@archiver.kernel.org>; Wed, 21 Dec 2022 10:48:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9D02416E9;
	Wed, 21 Dec 2022 10:48:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9D02416E9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=otvVEkZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95gpmQ-Ll-qH; Wed, 21 Dec 2022 10:48:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 012F3416FA;
	Wed, 21 Dec 2022 10:48:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 012F3416FA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 092EBC0071;
	Wed, 21 Dec 2022 10:48:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E21C0070
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3E58F416FA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:48:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E58F416FA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H9AmRU9aGSON
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:48:35 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 78368416E9
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78368416E9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Dec 2022 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=G8BfwESgESTNnYvNeYuCU3HSzchk37wUY4xu9hlmTjk=; b=otvVEkZIWl9/t3BCnbtxXKY6rO
 d4t7QZr+4tBuq2CDIYERTqHcR9d/xd9lwXbuCZOYYLKwo77AJqLiqdrSqZbrY9VCfk5V1uPcJ5h1a
 sldq+uvJ1Dcfx9EiU8yiYmTGtNWXLugedGwnTNP5FvyUdlkwKBwfrgQNR6+PYx5RKlmBpAFmyCyw1
 5Z2ABoqUwTJGcevg0Y/YoW08Soe0SHmvrZFs6fGsfHYIJyO6gk+Lx0bkbQ104Y1pkWTZw4dnTfX2R
 +60DK0PZjn6RWXaQ1wqfXUj+1he5LQOrObWEGx3H58YnUpJBdPjWM59l0A3sLhfIYXXXdczldnZcA
 glvEGxtw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1p7weE-00DhGc-Rt; Wed, 21 Dec 2022 10:48:30 +0000
Date: Wed, 21 Dec 2022 02:48:30 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-blk: support completion batching for the
 IRQ path
Message-ID: <Y6LkfrTVV/M2eye/@infradead.org>
References: <20221220153613.21675-1-suwan.kim027@gmail.com>
 <20221220153613.21675-3-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221220153613.21675-3-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, mst@redhat.com,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

> +		if (likely(!blk_should_fake_timeout(req->q)) &&
> +			!blk_mq_complete_request_remote(req) &&
> +			!blk_mq_add_to_batch(req, iob, vbr->status,
> +						virtblk_complete_batch))

One tab indents for line continuations are really confusing.  Please
make this:

		if (likely(!blk_should_fake_timeout(req->q)) &&
		    !blk_mq_complete_request_remote(req) &&
		    !blk_mq_add_to_batch(req, iob, vbr->status,
					 virtblk_complete_batch))

> +	found = virtblk_handle_req(vq, iob);
>  
>  	if (found)

You can drop the found variable here now:

	if (virtblk_handle_req(vq, iob))
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
