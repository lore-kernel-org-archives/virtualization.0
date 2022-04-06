Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCB9C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 05:00:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B19E3417A3;
	Wed,  6 Apr 2022 05:00:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p603faG-Io9M; Wed,  6 Apr 2022 05:00:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 112674179F;
	Wed,  6 Apr 2022 05:00:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC0D8C001D;
	Wed,  6 Apr 2022 05:00:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBECC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 05:00:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2C8F81A27
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 05:00:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5RJ0aRi4e185
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 05:00:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E805E81A23
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 05:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CT9E1WyFV78lNGbgBTxuNPDqR29ylS3lVr+dNAQX09g=; b=lv6KXqr9v6E+H897+r+bibfh6z
 2VctEoqicC7uA4zxq4DFvgDDPsmsbDKXlsQrIsnKflXPMuNBvRsIrLNhsUC46hsSKLPI/4Of5ZWZj
 JVe5SHSnQ0Ivef0aCrUbRBkS+A+KYYj2zz5YL4jRL50Lolvep2QFlv6HlvuHz15tfcMzkvK20JNnM
 n7jqLGOaP+wBhoqdDi1z9ArDU0juyg29qIynpgs11yo9Z/5cJjXTzpCl+/nHrnpk4+ZwiM/9UEEPI
 Gm0PYMgjniX3BG0Y4K0K3honl671KG3jzPYLg44ClLKeaDmDo4/h5sd5bXKU783CMrr6jlS9Vbphx
 nYg0slPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nbxmP-003mxi-Ub; Wed, 06 Apr 2022 05:00:29 +0000
Date: Tue, 5 Apr 2022 22:00:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Suwan Kim <suwan.kim027@gmail.com>
Subject: Re: [PATCH v5 1/2] virtio-blk: support polling I/O
Message-ID: <Yk0ebS3cl95XtOuj@infradead.org>
References: <20220405150924.147021-1-suwan.kim027@gmail.com>
 <20220405150924.147021-2-suwan.kim027@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220405150924.147021-2-suwan.kim027@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
Cc: mgurtovoy@nvidia.com, linux-block@vger.kernel.org, mst@redhat.com,
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

On Wed, Apr 06, 2022 at 12:09:23AM +0900, Suwan Kim wrote:
> +        for (i = 0; i < num_vqs - num_poll_vqs; i++) {
> +                callbacks[i] = virtblk_done;
> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req.%d", i);
> +                names[i] = vblk->vqs[i].name;
> +        }
> +
> +        for (; i < num_vqs; i++) {
> +                callbacks[i] = NULL;
> +                snprintf(vblk->vqs[i].name, VQ_NAME_LEN, "req_poll.%d", i);
> +                names[i] = vblk->vqs[i].name;
> +        }

This uses spaces for indentation.

> +		/*
> +		 * Regular queues have interrupts and hence CPU affinity is
> +		 * defined by the core virtio code, but polling queues have
> +		 * no interrupts so we let the block layer assign CPU affinity.
> +		 */
> +		if (i != HCTX_TYPE_POLL)
> +			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
> +		else
> +			blk_mq_map_queues(&set->map[i]);

Nit, but I would have just done a "positive" check here as that is ab it
easier to read:

		if (i == HCTX_TYPE_POLL)
			blk_mq_map_queues(&set->map[i]);
		else
			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
