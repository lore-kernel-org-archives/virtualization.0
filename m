Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39EAC4167E
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D76260F70
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D76260F70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 656B440135;
	Mon, 25 Oct 2021 17:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Nq5ZKJ5DP_b; Mon, 25 Oct 2021 17:08:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id ED6944011E;
	Mon, 25 Oct 2021 17:08:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACCD6C0019;
	Mon, 25 Oct 2021 17:08:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D92EBC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:08:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B3B19607F2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:08:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ApyrGMsHQfWY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:08:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 00CCC607F1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635181722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIsnWAzuBFe9gHiSmJ+BSqRSt/Kzk0fPACQvjnOMXwM=;
 b=Oh6sKCxC7U0dihYbfp0SzgvakwAipNOdpAdbv9tUveIhJ9pSlkfy+HplR476ovYT5Haj3J
 weSQ61Iorxo4dtXIAk7l3/jp75Vk9x2o+XBxCwUDeE5wABZiQWXhR2IuXBZmIjFOJFwCOO
 VCskU0v5IzEUykrrFSkBbiVvh76JIHA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-j4mgstErMlSWw_L7cNWqyw-1; Mon, 25 Oct 2021 13:08:41 -0400
X-MC-Unique: j4mgstErMlSWw_L7cNWqyw-1
Received: by mail-wr1-f69.google.com with SMTP id
 d10-20020adffd8a000000b00167f0846597so2840797wrr.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 10:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pIsnWAzuBFe9gHiSmJ+BSqRSt/Kzk0fPACQvjnOMXwM=;
 b=4Z8ZAAOc7szwY8ougtOKQYnX8TLQGOg0Yurz7bkkkSkcsXk0BFp6KT/mgiTlZFlQBX
 X8q5JKwxejlgPzs6GxcDUimJ0VlxZEJZuUcMKixhpImee5LSdzzGlP2/pKrFazgKkxtl
 lhNj83SXpn/Ga5xLnwHfWNV4WX/djNDmm795HaofQe1JMmTgYA5+4JBe9UYFZOMhls+Z
 c68FbhMS3C2wRNfRkFkKBi2gGMXjw7YMjzzAlJ5RIjyMkUsGDGt7qIfucvRHsB+ygqRJ
 JvaMF7kwzZOUGiaQU7ZcXCnHX2FaavI5dPEVKN1HteHv5k3nie+eBMPupE5yvXMufKTZ
 zePg==
X-Gm-Message-State: AOAM532g1ESqY8y9zZNJj8XjkzU0HvaoGfj+Jyo3OD8zTCa5upP3dOUf
 m64J9Wo1ZjxtwMJRHFN+osji/dHOs97x9YXs/8kD2xkbCqpn8cEvi+hpXvUWVW76jS0yIrZCD2t
 gcwp/fMJzlT8USW7/vFb6oPIqQNKvX2xnazI19Jkhqg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr21291679wmj.23.1635181719800; 
 Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyZto2WrweAcCxAfmQR9rdm2tzfsLZ7d2NbPqmOXvvnrZdmXf2381albDqxjOgnO+tqj1h8A==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr21291660wmj.23.1635181719596; 
 Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
Received: from redhat.com ([2.55.12.86])
 by smtp.gmail.com with ESMTPSA id w10sm9506341wrp.25.2021.10.25.10.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Oct 2021 10:08:39 -0700 (PDT)
Date: Mon, 25 Oct 2021 13:08:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211025130321-mutt-send-email-mst@kernel.org>
References: <20211025142506.167-1-xieyongji@bytedance.com>
 <20211025142506.167-5-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20211025142506.167-5-xieyongji@bytedance.com>
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

On Mon, Oct 25, 2021 at 10:25:06PM +0800, Xie Yongji wrote:
> The block layer can't support the block size larger than

the block size -> block sizes, or a block size

> page size yet.

And to add to that, a block size that's too small or
not a power of two won't work either, right?
Mention that too.


> If an untrusted device

nothing to do with trust. A misconfigured device.

> presents an invalid
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

I know you are trying to be polite but it's misplaced here.
Just say what it is:

Use a block layer helper to validate the block size.

> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  drivers/block/virtio_blk.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 303caf2d17d0..8b5833997f8e 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -815,9 +815,16 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		err = blk_validate_block_size(blk_size);
> +		if (err) {
> +			dev_err(&vdev->dev,
> +				"get invalid block size: %u\n", blk_size);

Probably hex. Add virtio_blk: and drop "get" here - it's ungrammatical.
	"virtio_blk: invalid block size: 0x%x\n", blk_size.

> +			goto out_cleanup_disk;
> +		}
> +
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
