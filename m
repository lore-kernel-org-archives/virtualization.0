Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FCEC433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Feb 2022 06:27:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25DE983F2F;
	Thu,  3 Feb 2022 06:27:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 61oImxzppVYQ; Thu,  3 Feb 2022 06:27:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AC2A283F2A;
	Thu,  3 Feb 2022 06:27:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F65FC0011;
	Thu,  3 Feb 2022 06:27:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1881CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 06:27:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EA75C415E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 06:27:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZN-GxxOf_Qwr
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 06:27:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 192D341594
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Feb 2022 06:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643869630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4Q3hJgKl1GZvpzGFs1izzlrbs0UNXcazvIKGrrx7xHU=;
 b=dJExdtI2TeZ56acTO+lHZF80hDFiwqq66CmlzqTfTjK8C9Nx2hGxZv73qm7RnIH9UZgyw2
 bQFToZpRBzIqNBczTxf5Lc/pPYaFdjwPsCdgLQDi3qzSjK/K0zS8MhJlTplA82nBYe+SPo
 8GDve5PmldKjFcPznxLgtvNlwyBrZdo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-4cJwT_wIO-a999G9qgsufA-1; Thu, 03 Feb 2022 01:27:09 -0500
X-MC-Unique: 4cJwT_wIO-a999G9qgsufA-1
Received: by mail-wr1-f69.google.com with SMTP id
 l22-20020adfa396000000b001d8e6467fe8so279345wrb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Feb 2022 22:27:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4Q3hJgKl1GZvpzGFs1izzlrbs0UNXcazvIKGrrx7xHU=;
 b=Bbb41kDM42TP+3sZd8SG7ArSeDXB1d3TM1h7md5xQ7crRaXuDwsoPNOjS+dJ3pwRyP
 5Q8cxOJwjYOPv0fvsVvX11lPbSy4G/JbrMa41eS5TENI7mdxG8lHZKuB01/fxQUwoaSj
 Hfh/p+6OMnWKrr6In4wppiWdambajssmrco9mAf+WdNISGfknK4Q0ox09m6a2pr/Ehte
 TEMcaesp5sk65xXlCJkOGizI0Y1+lcrdBHuVR/VrgL62C6gorBRYcu//iGPEANynfYvR
 xY5dQxYRmPamAnvPW7eU2CmBjjpGPr9nSFfju1eomjbqNjkUzxFLQ9fQTTScJGesfOGO
 X/RQ==
X-Gm-Message-State: AOAM532RWKwS1/wxPVXqf9aUosvt9UdqzsUPJ6h4G96bGGRjtNBI6wqF
 B8aY8j4SrVtR+a80uqcCqlPGwC3rAWTqpxYJxvqVGvwNvHcSup84vdiwHnDtZxJKYvvc1ewz2eL
 y3aULe3EufECNPCiumV9wiMmtxIbnq7JvcgTlmlT2eg==
X-Received: by 2002:a05:600c:19d2:: with SMTP id
 u18mr8762747wmq.101.1643869628551; 
 Wed, 02 Feb 2022 22:27:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzwiRrXNiT1PFeEaEWqx53rsILaHA53YSG2uTc3uPWU3z3/gKj5cRHza8XX+2eY8cuzPj6uA==
X-Received: by 2002:a05:600c:19d2:: with SMTP id
 u18mr8762735wmq.101.1643869628366; 
 Wed, 02 Feb 2022 22:27:08 -0800 (PST)
Received: from redhat.com ([2.55.131.61])
 by smtp.gmail.com with ESMTPSA id v3sm18549520wru.15.2022.02.02.22.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Feb 2022 22:27:07 -0800 (PST)
Date: Thu, 3 Feb 2022 01:27:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/5] virtio_blk: simplify refcounting
Message-ID: <20220203012654-mutt-send-email-mst@kernel.org>
References: <20220202155659.107895-1-hch@lst.de>
 <20220202155659.107895-3-hch@lst.de>
MIME-Version: 1.0
In-Reply-To: <20220202155659.107895-3-hch@lst.de>
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

On Wed, Feb 02, 2022 at 04:56:56PM +0100, Christoph Hellwig wrote:
> Implement the ->free_disk method to free the virtio_blk structure only
> once the last gendisk reference goes away instead of keeping a local
> refcount.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/block/virtio_blk.c | 64 +++++++-------------------------------
>  1 file changed, 12 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index c443cd64fc9b4..2d939ac1508c1 100644
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
> @@ -985,8 +947,6 @@ static void virtblk_remove(struct virtio_device *vdev)
>  	kfree(vblk->vqs);
>  
>  	mutex_unlock(&vblk->vdev_mutex);
> -
> -	virtblk_put(vblk);
>  }
>  
>  #ifdef CONFIG_PM_SLEEP
> -- 
> 2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
