Return-Path: <SRS0=kx+w=PB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D55C433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:02:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 218E660F94
	for <virtualization@archiver.kernel.org>; Wed, 13 Oct 2021 10:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 218E660F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D7DF180D22;
	Wed, 13 Oct 2021 10:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gsu5ATyApVEL; Wed, 13 Oct 2021 10:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1C43080B4A;
	Wed, 13 Oct 2021 10:02:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E05D0C0011;
	Wed, 13 Oct 2021 10:02:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D2A6C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:02:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6EF7F80CB7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:02:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PUW8xJroF5-p
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:02:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DB1F80B4A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 10:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634119373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cTBRWjn4ZBMdOQ4Tyf2d4YxDxN6ny+p38/iqj85IAIM=;
 b=I/o7MFt53n4NTvfD7TPo4Y03S5CvpoT57uT9ooU+4/mGNE4MPdySOVVyM1Sj/NqAbd6hH5
 8JJ1urUezMj2ppngHjsmn2WlznQWfHGaZrgCIT2N3IX0num+FFjHGxxNyu8esMl6jmhRnl
 1ftQ5iac4MVR9QfRgwV7a3l4Ddia1ds=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-vPdUK1d_P0SdALeH1GVxsg-1; Wed, 13 Oct 2021 06:02:51 -0400
X-MC-Unique: vPdUK1d_P0SdALeH1GVxsg-1
Received: by mail-wr1-f70.google.com with SMTP id
 k2-20020adfc702000000b0016006b2da9bso1577279wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Oct 2021 03:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cTBRWjn4ZBMdOQ4Tyf2d4YxDxN6ny+p38/iqj85IAIM=;
 b=8PEEcQFFXlw+datsRgHJJRXLLrs1KGQNyLrajmTrFQyl61NwT1pxBoTFMAL8DFsg56
 86wE0J8pd+MjcT7sgBfJV9BKbH+JGjbepwq1beCdgMTp2Bnvf2R3LrHyTpJkhSjca8i/
 1ofjUAd7aANAfprGJU+JyERYdRun+/LU5LZXA04nv0Kce163fkgfHOLydkafw3G0V/4v
 NKc9gL5YTT7IRRbyUHj0YZNZ0DrknrP1M9XFCVoWdqpcN+eaQSwAxcfGgpq64L3HfTC1
 XR78tlnYJhk3cB/P1Quk+Y5r3zRAC5K7L9m9eIBMbGx1/0vVwaiOy9wquoZ0EwW7k2P2
 o7Fg==
X-Gm-Message-State: AOAM533k+JJbrAkaJTItupY8FkWKQwG/47B0EXnW1xjMI38gCL5sZcd9
 iTf0yxRTUR5hpgX+clMcdhFMR7BwGPBo0vqci0XCLKsKu6hxzNDM1yneNPUPnqL/Sn8f+kF0siu
 y54IvCObONfHWXcBoMb3vO/dQjjE1FY5QqWaB75UOaA==
X-Received: by 2002:a05:6000:188e:: with SMTP id
 a14mr24969145wri.223.1634119370365; 
 Wed, 13 Oct 2021 03:02:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzARCeNL3l5AJ1i3mYqpJHOUp0qGSQusS2yTJ9KbSIuAD2HucJVBpvqqpsJ7F/QB3fTGMu9gw==
X-Received: by 2002:a05:6000:188e:: with SMTP id
 a14mr24969116wri.223.1634119370088; 
 Wed, 13 Oct 2021 03:02:50 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
 by smtp.gmail.com with ESMTPSA id h8sm13395499wrm.27.2021.10.13.03.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 03:02:49 -0700 (PDT)
Date: Wed, 13 Oct 2021 06:02:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2 09/12] virtio_ring: validate used buffer length
Message-ID: <20211013055951-mutt-send-email-mst@kernel.org>
References: <20211012065227.9953-1-jasowang@redhat.com>
 <20211012065227.9953-10-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211012065227.9953-10-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, david.kaplan@amd.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Oct 12, 2021 at 02:52:24PM +0800, Jason Wang wrote:
> This patch validate the used buffer length provided by the device
> before trying to use it. This is done by record the in buffer length
> in a new field in desc_state structure during virtqueue_add(), then we
> can fail the virtqueue_get_buf() when we find the device is trying to
> give us a used buffer length which is greater than the in buffer
> length.
> 
> Since some drivers have already done the validation by itself, this

by themselves

> patch tries to makes the core validation optional. For the driver that
> doesn't want the validation, it can set the validate_used to be
> true (which could be overridden by force_used_validation). To be more
> efficient, a dedicate array is used for storing the validate used
> length, this helps to eliminate the cache stress if validation is done
> by the driver.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 56 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 58 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index d2ca0a7365f8..dee962bd8b04 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -14,6 +14,9 @@
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>  
> +static bool force_used_validation = false;
> +module_param(force_used_validation, bool, 0444);
> +
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -182,6 +185,9 @@ struct vring_virtqueue {
>  		} packed;
>  	};
>  
> +	/* Per-descriptor in buffer length */
> +	u32 *buflen;
> +
>  	/* How to notify other side. FIXME: commonalize hcalls! */
>  	bool (*notify)(struct virtqueue *vq);
>  
> @@ -490,6 +496,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -571,6 +578,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -610,6 +618,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[head] = buflen;
> +
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -784,6 +796,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[i])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[i]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1062,6 +1079,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u32 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1089,6 +1107,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1142,6 +1162,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].indir_desc = desc;
>  	vq->packed.desc_state[id].last = id;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	vq->num_added += 1;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -1176,6 +1200,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	unsigned int i, n, c, descs_used, err_idx;
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1250,6 +1275,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1269,6 +1296,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].indir_desc = ctx;
>  	vq->packed.desc_state[id].last = prev;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->buflen)
> +		vq->buflen[id] = buflen;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1455,6 +1486,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (vq->buflen && unlikely(*len > vq->buflen[id])) {
> +		BAD_RING(vq, "used len %d is larger than in buflen %u\n",
> +			*len, vq->buflen[id]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> @@ -1660,6 +1696,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	struct vring_virtqueue *vq;
>  	struct vring_packed_desc *ring;
>  	struct vring_packed_desc_event *driver, *device;
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
>  	size_t ring_size_in_bytes, event_size_in_bytes;
>  
> @@ -1749,6 +1786,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	if (!vq->packed.desc_extra)
>  		goto err_desc_extra;
>  
> +	if (!drv->validate_used || force_used_validation) {
> +		vq->buflen = kmalloc_array(num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;
> +	}
> +
>  	/* No callback?  Tell other side not to bother us. */
>  	if (!callback) {
>  		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
> @@ -1761,6 +1805,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
> +err_buflen:
> +	kfree(vq->packed.desc_extra);
>  err_desc_extra:
>  	kfree(vq->packed.desc_state);
>  err_desc_state:
> @@ -2168,6 +2214,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  					void (*callback)(struct virtqueue *),
>  					const char *name)
>  {
> +	struct virtio_driver *drv = drv_to_virtio(vdev->dev.driver);
>  	struct vring_virtqueue *vq;
>  
>  	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> @@ -2227,6 +2274,13 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	if (!vq->split.desc_extra)
>  		goto err_extra;
>  
> +	if (!drv->validate_used || force_used_validation) {
> +		vq->buflen = kmalloc_array(vring.num, sizeof(*vq->buflen),
> +					   GFP_KERNEL);
> +		if (!vq->buflen)
> +			goto err_buflen;
> +	}
> +
>  	/* Put everything in free lists. */
>  	vq->free_head = 0;
>  	memset(vq->split.desc_state, 0, vring.num *
> @@ -2237,6 +2291,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
>  	spin_unlock(&vdev->vqs_list_lock);
>  	return &vq->vq;
>  
> +err_buflen:
> +	kfree(vq->split.desc_extra);
>  err_extra:
>  	kfree(vq->split.desc_state);
>  err_state:
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 0cd8685aeba4..79e4f6765e3a 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -153,6 +153,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
>   * @feature_table_legacy: same as feature_table but when working in legacy mode.
>   * @feature_table_size_legacy: number of entries in feature table legacy array.
>   * @validate: optional function to do early checks
> + * @validate_used: whether the driver can validate used buffer length

So you set it to true to *not* have core validate used. Ugh.
I understand completely why it's like this: to have the default false
be safe. But let's call this out.

	@suppress_used_validation: set to not have core validate used length


>   * @probe: the function to call when a device is found.  Returns 0 or -errno.
>   * @scan: optional function to call after successful probe; intended
>   *    for virtio-scsi to invoke a scan.
> @@ -169,6 +170,7 @@ struct virtio_driver {
>  	unsigned int feature_table_size;
>  	const unsigned int *feature_table_legacy;
>  	unsigned int feature_table_size_legacy;
> +	bool validate_used;
>  	int (*validate)(struct virtio_device *dev);
>  	int (*probe)(struct virtio_device *dev);
>  	void (*scan)(struct virtio_device *dev);
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
