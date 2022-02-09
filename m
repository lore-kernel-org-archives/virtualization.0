Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA79AC433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 08:27:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E51560F96;
	Wed,  9 Feb 2022 08:27:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29ysXOcDfLgH; Wed,  9 Feb 2022 08:27:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 170C760F94;
	Wed,  9 Feb 2022 08:27:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBD52C0011;
	Wed,  9 Feb 2022 08:27:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2714C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C33CC60F95
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:27:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2yDZzdjl8GcQ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:27:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7370760F94
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 08:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644395268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QWFS2lWkJwMufiiyBv+3xLsV54GNui3YT83HssOBlE=;
 b=Wb7QdqsRThXXed/QEKdWaP69VacJoESCogGOBddZBw9nEck1tyD9GvR8tPKUX51Wu/T2J7
 jx87F+ILdupH2FJv27Qx52Lm1l0ks839JgkO2UBvIVkAlqsURhL3dFh/iGQhiAenYM3oAo
 jddTM6jomRjh44BDcLQhJTGU0FMnNGc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-OR7MkeAnMRyyteltGCY_xg-1; Wed, 09 Feb 2022 03:27:46 -0500
X-MC-Unique: OR7MkeAnMRyyteltGCY_xg-1
Received: by mail-wm1-f72.google.com with SMTP id
 r205-20020a1c44d6000000b0037bb51b549aso2299125wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Feb 2022 00:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8QWFS2lWkJwMufiiyBv+3xLsV54GNui3YT83HssOBlE=;
 b=JoCUF0GWU9OILexnC/oZ6EZLqgPAx2kQhBmBGWwRWqwLem4vcdqyqTz69Cin0pyh30
 GUM9w+kFhUPTPzPQbZJ9P+vev93o5VBwTIC1d6EfGg7XjucLwEfBli0Ioj4ZLTrZPISw
 +PyoWf7RAWZx1cme9K2MZvOpaUn/jTUBKM771Tiw0p0RGAtYWwUSN0pc3EZfhO0P+Hch
 2gTNgqC4MzjMRZ9nwqLVvU45rvH0oOSyzV34MI68URkIL7XNtUOnYf6RUca+Gk8ksBIT
 bznzZ1X77Hg/DCxp7YpT0IFOtISC3wDTjSBVFLh+FdYytnJsC0X7JFNpUhb24qYiNLiE
 yqwQ==
X-Gm-Message-State: AOAM533zjLMGlkavzXZgFi0s33JwQ4MK7pGLKPzrqNIvuj/FDEzjsx7f
 pzKNpaT6MSegQ1yEX1yQiWu4P7Yz0UST/n0YLQrhXGWTZSXlyCL6vuflXfSEuUh6ofl4G9KHdNZ
 YpwS1D783zrA2bBjj6oqpVWVSt4hng6um+1/hHyVowQ==
X-Received: by 2002:a05:600c:430c:: with SMTP id
 p12mr1516613wme.156.1644395264882; 
 Wed, 09 Feb 2022 00:27:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz61XlLv13jFyjUak6xgKYBD8G/EHdydMsxOUqpgQlLjp1d7oGWF4hrmVdH/iwqfL5RxkmalA==
X-Received: by 2002:a05:600c:430c:: with SMTP id
 p12mr1516594wme.156.1644395264661; 
 Wed, 09 Feb 2022 00:27:44 -0800 (PST)
Received: from redhat.com ([2.52.2.146])
 by smtp.gmail.com with ESMTPSA id y3sm16442750wry.109.2022.02.09.00.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Feb 2022 00:27:44 -0800 (PST)
Date: Wed, 9 Feb 2022 03:27:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] virtio_blk: simplify refcounting
Message-ID: <20220209032732-mutt-send-email-mst@kernel.org>
References: <20220209082121.2628452-1-hch@lst.de>
 <20220209082121.2628452-6-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220209082121.2628452-6-hch@lst.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, Maxim Levitsky <maximlevitsky@gmail.com>,
 Alex Dubov <oakad@yahoo.com>, linux-mmc@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Feb 09, 2022 at 09:21:20AM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 74 +++++++++++---------------------------
>  1 file changed, 21 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b4..05cc5451d6cc1 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -69,13 +69,6 @@ struct virtio_blk {
>  	/* Process context for config space updates */
>  	struct work_struct config_work;
>  
> -	/*
> -	 * Tracks references from block_device_operations open/release and
> -	 * virtio_driver probe/remove so this object can be freed once no
> -	 * longer in use.
> -	 */
> -	refcount_t refs;
> -
>  	/* What host tells us, plus 2 for header & tailer. */
>  	unsigned int sg_elems;
>  
> @@ -391,43 +384,6 @@ static int virtblk_get_id(struct gendisk *disk, char *id_str)
>  	return err;
>  }
>  
> -static void virtblk_get(struct virtio_blk *vblk)
> -{
> -	refcount_inc(&vblk->refs);
> -}
> -
> -static void virtblk_put(struct virtio_blk *vblk)
> -{
> -	if (refcount_dec_and_test(&vblk->refs)) {
> -		ida_simple_remove(&vd_index_ida, vblk->index);
> -		mutex_destroy(&vblk->vdev_mutex);
> -		kfree(vblk);
> -	}
> -}
> -
> -static int virtblk_open(struct block_device *bd, fmode_t mode)
> -{
> -	struct virtio_blk *vblk = bd->bd_disk->private_data;
> -	int ret = 0;
> -
> -	mutex_lock(&vblk->vdev_mutex);
> -
> -	if (vblk->vdev)
> -		virtblk_get(vblk);
> -	else
> -		ret = -ENXIO;
> -
> -	mutex_unlock(&vblk->vdev_mutex);
> -	return ret;
> -}
> -
> -static void virtblk_release(struct gendisk *disk, fmode_t mode)
> -{
> -	struct virtio_blk *vblk = disk->private_data;
> -
> -	virtblk_put(vblk);
> -}
> -
>  /* We provide getgeo only to please some old bootloader/partitioning tools */
>  static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  {
> @@ -460,11 +416,19 @@ static int virtblk_getgeo(struct block_device *bd, struct hd_geometry *geo)
>  	return ret;
>  }
>  
> +static void virtblk_free_disk(struct gendisk *disk)
> +{
> +	struct virtio_blk *vblk = disk->private_data;
> +
> +	ida_simple_remove(&vd_index_ida, vblk->index);
> +	mutex_destroy(&vblk->vdev_mutex);
> +	kfree(vblk);
> +}
> +
>  static const struct block_device_operations virtblk_fops = {
> -	.owner  = THIS_MODULE,
> -	.open = virtblk_open,
> -	.release = virtblk_release,
> -	.getgeo = virtblk_getgeo,
> +	.owner  	= THIS_MODULE,
> +	.getgeo		= virtblk_getgeo,
> +	.free_disk	= virtblk_free_disk,
>  };
>  
>  static int index_to_minor(int index)
> @@ -791,8 +755,6 @@ static int virtblk_probe(struct virtio_device *vdev)
>  		goto out_free_index;
>  	}
>  
> -	/* This reference is dropped in virtblk_remove(). */
> -	refcount_set(&vblk->refs, 1);
>  	mutex_init(&vblk->vdev_mutex);
>  
>  	vblk->vdev = vdev;
> @@ -948,7 +910,13 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	return 0;
>  
>  out_cleanup_disk:
> -	blk_cleanup_disk(vblk->disk);
> +	blk_cleanup_queue(vblk->disk->queue);
> +	blk_mq_free_tag_set(&vblk->tag_set);
> +	vdev->config->del_vqs(vdev);
> +	kfree(vblk->vqs);
> +	put_disk(vblk->disk);
> +	return err;
> +
>  out_free_tags:
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  out_free_vq:
> @@ -970,7 +938,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	flush_work(&vblk->config_work);
>  
>  	del_gendisk(vblk->disk);
> -	blk_cleanup_disk(vblk->disk);
> +	blk_cleanup_queue(vblk->disk->queue);
>  	blk_mq_free_tag_set(&vblk->tag_set);
>  
>  	mutex_lock(&vblk->vdev_mutex);
> @@ -986,7 +954,7 @@ static void virtblk_remove(struct virtio_device *vdev)
>  
>  	mutex_unlock(&vblk->vdev_mutex);
>  
> -	virtblk_put(vblk);
> +	put_disk(vblk->disk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.30.2
> 
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/virtualization
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
