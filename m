Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46601C433EF
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 13:20:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C27836054F
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 13:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C27836054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7EF994029A;
	Mon, 25 Oct 2021 13:20:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AekS_xdj__EL; Mon, 25 Oct 2021 13:20:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FE1F40239;
	Mon, 25 Oct 2021 13:20:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17BACC0012;
	Mon, 25 Oct 2021 13:20:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7916C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 13:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C5F9F60780
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 13:20:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kfd0wqZHBizX
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 13:20:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D758B605CD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 13:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635167999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQ1OI9HAD5wjVNNOGgAN/kQupBGnrAHU5IxWWPewKWg=;
 b=K+E7lXTNZl5o5E8yFGZqgCowZ2oLAcO22GtsqYBMO0b8GvyVkU/YKGiOLyka6sIniAtwth
 i4BI9N6GkWLUNgyQvhuEgqO61sNgRQYMa/KR6eHbY1Q4rrLaQIVO2SUf0JXrsbqjiVVID0
 EGRiwJSRxG9gfSLlBUc+eKx1rspiCdM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-539-wzHjIrY-Mre8qSoIowOlwg-1; Mon, 25 Oct 2021 09:19:58 -0400
X-MC-Unique: wzHjIrY-Mre8qSoIowOlwg-1
Received: by mail-wm1-f70.google.com with SMTP id
 g187-20020a1c20c4000000b0032cacfe6dabso2094735wmg.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 06:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pQ1OI9HAD5wjVNNOGgAN/kQupBGnrAHU5IxWWPewKWg=;
 b=MQPBo45CXVyvZv+k1PuPd9+JVzi8M7P8UE7hL20co2UX80YLj2ddYFXC2ATScaR5iO
 zPxHHUDvs1D6ZnBpltmSLdAVUW7RueSFwamYIZuoOJ3gyQ57QY6GOkLxxHUBVXLxTYbd
 p+ntMJxHo88ZbpNarHdpY2RX/2kSpKEnwy3350zMe3n2yikU/35UM90B69Rh6z2nT+GN
 fwWN6i1h8VJX2FeByDvH6GawiPQG5L9sQj+JG/0g6lF4exW3DfteLDIRCzSEJBkgixOP
 gkmRglbLktJkZjyrDEqOEOBmKR5FkohrrIx25DSJ325prr0i+EyGNVScjbNNkZl/yVVF
 xpFQ==
X-Gm-Message-State: AOAM5323wDy4KPn1LiAeTwZTjKeP85a5WLTJDaLgO4mwu896NhlczqTj
 em1qMFcoBgG7BvKKFb+Y4pbDaN8n+gt0qLNbuF6c06pKZdsN8IL8JmCvn2FssV/SzFtEQ8fcL3A
 8CordyL7P4YFrZd0LfP2T/pNMFBkA+RqEKXzYW5FtDA==
X-Received: by 2002:adf:d20d:: with SMTP id j13mr21610400wrh.432.1635167997170; 
 Mon, 25 Oct 2021 06:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/aD7gRnCuI5j47+0ONiKyu52bZ58nYsV/ZMfaGwWvIPrql4qDGm85P73R9e6uVPOdWjBWhQ==
X-Received: by 2002:adf:d20d:: with SMTP id j13mr21610369wrh.432.1635167997009; 
 Mon, 25 Oct 2021 06:19:57 -0700 (PDT)
Received: from redhat.com ([2a03:c5c0:207e:bfd4:918:2bfe:a2a5:6abe])
 by smtp.gmail.com with ESMTPSA id s11sm8355747wrt.60.2021.10.25.06.19.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 06:19:56 -0700 (PDT)
Date: Mon, 25 Oct 2021 09:19:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211025091911-mutt-send-email-mst@kernel.org>
References: <20211025094306.97-1-xieyongji@bytedance.com>
 <20211025094306.97-5-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20211025094306.97-5-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: axboe@kernel.dk, josef@toxicpanda.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org, hch@lst.de
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

On Mon, Oct 25, 2021 at 05:43:06PM +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than
> page size yet. If an untrusted device presents an invalid
> block size in configuration space, it will result in the
> kernel crash something like below:
> 
> [  506.154324] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [  506.160416] RIP: 0010:create_empty_buffers+0x24/0x100
> [  506.174302] Call Trace:
> [  506.174651]  create_page_buffers+0x4d/0x60
> [  506.175207]  block_read_full_page+0x50/0x380
> [  506.175798]  ? __mod_lruvec_page_state+0x60/0xa0
> [  506.176412]  ? __add_to_page_cache_locked+0x1b2/0x390
> [  506.177085]  ? blkdev_direct_IO+0x4a0/0x4a0
> [  506.177644]  ? scan_shadow_nodes+0x30/0x30
> [  506.178206]  ? lru_cache_add+0x42/0x60
> [  506.178716]  do_read_cache_page+0x695/0x740
> [  506.179278]  ? read_part_sector+0xe0/0xe0
> [  506.179821]  read_part_sector+0x36/0xe0
> [  506.180337]  adfspart_check_ICS+0x32/0x320
> [  506.180890]  ? snprintf+0x45/0x70
> [  506.181350]  ? read_part_sector+0xe0/0xe0
> [  506.181906]  bdev_disk_changed+0x229/0x5c0
> [  506.182483]  blkdev_get_whole+0x6d/0x90
> [  506.183013]  blkdev_get_by_dev+0x122/0x2d0
> [  506.183562]  device_add_disk+0x39e/0x3c0
> [  506.184472]  virtblk_probe+0x3f8/0x79b [virtio_blk]
> [  506.185461]  virtio_dev_probe+0x15e/0x1d0 [virtio]
> 
> So this patch tries to use the block layer helper to
> validate the block size.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 303caf2d17d0..5bcacefe969e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -815,9 +815,12 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		if (blk_validate_block_size(blk_size))
> +			goto out_cleanup_disk;
> +


Did you test this with an invalid blk size? It seems unlikely that it
fails properly the way you'd expect.

>  		blk_queue_logical_block_size(q, blk_size);
> -	else
> +	} else
>  		blk_size = queue_logical_block_size(q);
>  
>  	/* Use topology information if available */
> -- 
> 2.11.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
