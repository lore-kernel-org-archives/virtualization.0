Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2EDC433F5
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 19:58:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2478860F5A
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 19:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2478860F5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD6D0607AF;
	Wed, 27 Oct 2021 19:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_hsLKwcaC_P; Wed, 27 Oct 2021 19:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E01F6066C;
	Wed, 27 Oct 2021 19:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5127FC0012;
	Wed, 27 Oct 2021 19:58:41 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32D0FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 144A9607AF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:58:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9iFEyxabvMcI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:58:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 487396066C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635364718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gnYp+Ff4hb5nCYByl2z0UK3tRsHSwGb6NEyDFeJqpaU=;
 b=d/+BZeurglBkFZMPUXyVjCqS9bcCOGIYAYqzKR6wLnbNITzDDJd4h18neyhHowGTKHV1iN
 ulDdTobVSNWO5ycuB4F1lj+piPPNJH4MA6H95PRE3F8QRWUqggSVfzgSoJl2gG/v/ZkY1f
 cGSidhsnjuu5VwZXNxhYyjtZuOBfUIA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-Fr1UaLTeOkSU1c2fzjTAXQ-1; Wed, 27 Oct 2021 15:58:36 -0400
X-MC-Unique: Fr1UaLTeOkSU1c2fzjTAXQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 i9-20020a508709000000b003dd4b55a3caso3345703edb.19
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 12:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gnYp+Ff4hb5nCYByl2z0UK3tRsHSwGb6NEyDFeJqpaU=;
 b=7HVoZZOWGL+x8PDzR2xUYFnaMgRCQSj6Q1IQKam5j2+BqpG7klvsKJ96BRULdyqr23
 iaaR8De/G8CBHKiq/AVeQ9y8oHgfXlCSiu7q4pXS2u9UWvwGmeW2ap9T2bVRIpcVQFnm
 vFOFH761SDK/AYBftyLVGxnT4ic1gmb/WlXHnJdqJP9W8sgCnhDFAPuoIUVpTZng1TzL
 SjtqoIIB3FCFLU0MMIEpmKYDpB6i08dQILQq3CsWgLZ8b21SKeRW4vAw8FyLF5yFHYxJ
 zV3XOyr158IJpFe576TN95ly/rz2gjT6nS+rjhl1bD1eSX0XOafmxVJjFKwmo7o9G5I5
 rOTA==
X-Gm-Message-State: AOAM5335k0XxLaft1WrgmDzQZ5iBYJMXQYmnUTwowtICqxQKrQ1jHOJy
 bcmCxYTspo1w422sHo5DjIQ07isHQ2ZHB4qgBRGJITk4hdWpcJjSugLzEg4+jFTuNd0ru6HrurD
 LAuvkeIINwJ0MLEQPm2uz1ldIBDLQW/9SVmqvCN1AXg==
X-Received: by 2002:aa7:db93:: with SMTP id u19mr11525972edt.179.1635364715592; 
 Wed, 27 Oct 2021 12:58:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJycH4irDBiKduRr0odmcV94oTFExCh07bjLyoBA8odK5EFPAdjJ0vRsc5zlYNzBq9zpNBJlVA==
X-Received: by 2002:aa7:db93:: with SMTP id u19mr11525950edt.179.1635364715442; 
 Wed, 27 Oct 2021 12:58:35 -0700 (PDT)
Received: from redhat.com ([2.55.137.59])
 by smtp.gmail.com with ESMTPSA id x6sm507400eds.83.2021.10.27.12.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 12:58:34 -0700 (PDT)
Date: Wed, 27 Oct 2021 15:58:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xie Yongji <xieyongji@bytedance.com>
Subject: Re: [PATCH v3 4/4] virtio-blk: Use blk_validate_block_size() to
 validate block size
Message-ID: <20211027155738-mutt-send-email-mst@kernel.org>
References: <20211026144015.188-1-xieyongji@bytedance.com>
 <20211026144015.188-5-xieyongji@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20211026144015.188-5-xieyongji@bytedance.com>
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

On Tue, Oct 26, 2021 at 10:40:15PM +0800, Xie Yongji wrote:
> The block layer can't support a block size larger than
> page size yet. And a block size that's too small or
> not a power of two won't work either. If a misconfigured
> device presents an invalid block size in configuration space,
> it will result in the kernel crash something like below:
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
> So let's use a block layer helper to validate the block size.
> 
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>


Please merge through the block tree because of the
dependency.

Jens can you pick this up?

> ---
>  drivers/block/virtio_blk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 303caf2d17d0..fd086179f980 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -815,9 +815,17 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
>  				   struct virtio_blk_config, blk_size,
>  				   &blk_size);
> -	if (!err)
> +	if (!err) {
> +		err = blk_validate_block_size(blk_size);
> +		if (err) {
> +			dev_err(&vdev->dev,
> +				"virtio_blk: invalid block size: 0x%x\n",
> +				blk_size);
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
