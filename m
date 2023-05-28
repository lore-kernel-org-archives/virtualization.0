Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D021DC7EE2C
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 07:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 35F8060ECA;
	Sun, 28 May 2023 07:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 35F8060ECA
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OIjRjM9X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzFiIOcDWF1x; Sun, 28 May 2023 07:57:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 55D8460E91;
	Sun, 28 May 2023 07:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 55D8460E91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3458FC0035;
	Sun, 28 May 2023 07:57:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27AACC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 07:57:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB8FB41E09
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 07:57:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EB8FB41E09
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OIjRjM9X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mHgz9pOGiP6E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 07:57:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37D4041DE3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37D4041DE3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685260625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CyBcNco0Gge4gbJKk143iR4E9OyphOPro7TAZfxT0Hc=;
 b=OIjRjM9X+cPhEUzJW/EwmQv7OVPyaeG5j51v4RkLls6cxrZvLyBwpcyLBh04Y7kgZWbWWv
 JoJlCQj094bI9pIVMwBLlg9QIKUbPuc4Ux4juQ15b+WBLYQ7oI6rVEoJWDCXaLK+f6IzFx
 n4jNeAwjayWJN41/UpM7fwAsMIrSJHU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-H4l-pa1DMS-zjjalhm3XbA-1; Sun, 28 May 2023 03:57:04 -0400
X-MC-Unique: H4l-pa1DMS-zjjalhm3XbA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2f2981b8364so1283350f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 00:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685260623; x=1687852623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CyBcNco0Gge4gbJKk143iR4E9OyphOPro7TAZfxT0Hc=;
 b=LTdfin/biRHgm/cAca0/hiJAaQaqT0Z901QLEjD8d7ZEVw5kLXcJNhTrS5iS4AdoiU
 5sgLKzm0gyNbY1/WTc9DXD+z0uHEYPTU/ssYD10TtztvMjI43tWR/hk2PzhLlV/DNONb
 YMig+PQRJxav9JzpuuLu2dnP8N0IOBMnK3bpRPoOOm60xkyqxeOBoquMeMRWtsTqLOuQ
 NFDjWQprjlJWQ32AJIcZUN20RQ+kYuYGOfCwms20G4FlvYPLTdG2mm5I0+faGNFEVvwP
 xtA+ikHuAcx3C6Q/OKVnVmtS5Z42RAsaBkL+mopd6u/FSCEzjkGJuUOVRj0VRDYkCDgl
 RWsw==
X-Gm-Message-State: AC+VfDwuV60mqD8THoIT9HIlEK9d78PhzeJo+QwSMJHDzNc2oE2hR2dq
 PWPLq2MByEjoTfyj60CnonsxNpUw/LJG657SPArLFbGH30H4/8hUi8cphlmKDt0KAUp6IxhRDm3
 LCAvOWQUe/TA6f78G0U5z6XU1YAqF+7ZN+ckVf9GoUA==
X-Received: by 2002:adf:e792:0:b0:2ef:b4a9:202f with SMTP id
 n18-20020adfe792000000b002efb4a9202fmr7016234wrm.69.1685260623374; 
 Sun, 28 May 2023 00:57:03 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ767ZoQH/pG0ey6X7gF0Jmfrk6DqK79WVQkChFfUtJV6MOsypliJHSsmkZygA+OLw1Cb5+jbw==
X-Received: by 2002:adf:e792:0:b0:2ef:b4a9:202f with SMTP id
 n18-20020adfe792000000b002efb4a9202fmr7016219wrm.69.1685260622976; 
 Sun, 28 May 2023 00:57:02 -0700 (PDT)
Received: from redhat.com ([2.52.146.27]) by smtp.gmail.com with ESMTPSA id
 j13-20020a5d604d000000b00306344eaebfsm10100637wrt.28.2023.05.28.00.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 May 2023 00:57:02 -0700 (PDT)
Date: Sun, 28 May 2023 03:56:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio_ring: validate used buffer length
Message-ID: <20230528033037-mutt-send-email-mst@kernel.org>
References: <20230526063041.18359-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230526063041.18359-1-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
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

On Fri, May 26, 2023 at 02:30:41PM +0800, Jason Wang wrote:
> This patch validate

validates

> the used buffer length provided by the device
> before trying to use it.

before returning it to caller

> This is done by remembering the in buffer
> length in a dedicated array during virtqueue_add(), then we can fail
> the virtqueue_get_buf() when we find the device is trying to give us a
> used buffer length which is greater than we stored before.

than what we stored

> 
> This validation is disable

disabled

> by default via module parameter to unbreak
> some existing devices since some legacy devices are known to report
> buggy used length.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

First I'm not merging this without more data about
what is known to be broken and what is known to work well
in the commit log. And how exactly do things work if used length
is wrong?
Second what's wrong with dma_desc_extra that we already maintain?
Third motivation - it's part and parcel of the hardening effort yes?
I'd like to know the fate of VIRTIO_HARDEN_NOTIFICATION before
we do more hardening. If it's irrevocably broken let's rip it out?


> ---
> Changes since V4:
> - drop the flat for driver to suppress the check
> - validation is disabled by default
> - don't do validation for legacy device
> - rebase and support virtqueue resize
> ---
>  drivers/virtio/virtio_ring.c | 75 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 143f380baa1c..5b151605aaf8 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -15,6 +15,9 @@
>  #include <linux/spinlock.h>
>  #include <xen/xen.h>
>  
> +static bool force_used_validation = false;
> +module_param(force_used_validation, bool, 0444);
> +
>  #ifdef DEBUG
>  /* For development, we want to crash whenever the ring is screwed. */
>  #define BAD_RING(_vq, fmt, args...)				\
> @@ -105,6 +108,9 @@ struct vring_virtqueue_split {
>  	struct vring_desc_state_split *desc_state;
>  	struct vring_desc_extra *desc_extra;
>  
> +	/* Maximum in buffer length, NULL means no used validation */
> +	u32 *buflen;
> +
>  	/* DMA address and size information */
>  	dma_addr_t queue_dma_addr;
>  	size_t queue_size_in_bytes;
> @@ -145,6 +151,9 @@ struct vring_virtqueue_packed {
>  	struct vring_desc_state_packed *desc_state;
>  	struct vring_desc_extra *desc_extra;
>  
> +	/* Maximum in buffer length, NULL means no used validation */
> +	u32 *buflen;
> +
>  	/* DMA address and size information */
>  	dma_addr_t ring_dma_addr;
>  	dma_addr_t driver_event_dma_addr;
> @@ -552,6 +561,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	unsigned int i, n, avail, descs_used, prev, err_idx;
>  	int head;
>  	bool indirect;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -635,6 +645,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  						     VRING_DESC_F_NEXT |
>  						     VRING_DESC_F_WRITE,
>  						     indirect);
> +			buflen += sg->length;
>  		}
>  	}
>  	/* Last one doesn't continue. */
> @@ -675,6 +686,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
>  	else
>  		vq->split.desc_state[head].indir_desc = ctx;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->split.buflen)
> +		vq->split.buflen[head] = buflen;
> +
>  	/* Put entry in available array (but don't update avail->idx until they
>  	 * do sync). */
>  	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
> @@ -861,6 +876,11 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", i);
>  		return NULL;
>  	}
> +	if (vq->split.buflen && unlikely(*len > vq->split.buflen[i])) {
> +		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> +			*len, vq->split.buflen[i]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_split clears data, so grab it now. */
>  	ret = vq->split.desc_state[i].data;
> @@ -1085,10 +1105,25 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
>  			 vring_split->queue_dma_addr,
>  			 dma_dev);
>  
> +	kfree(vring_split->buflen);
>  	kfree(vring_split->desc_state);
>  	kfree(vring_split->desc_extra);
>  }
>  
> +static bool vring_needs_used_validation(const struct virtio_device *vdev)
> +{
> +	/*
> +	 * Several legacy devices are known to produce buggy used
> +	 * length. In order to let driver work, we won't validate used
> +	 * buffer length in this case.
> +	 */
> +	if (!virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
> +		return false;
> +	if (force_used_validation)
> +		return true;
> +	return false;
> +}
> +
>  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  				   struct virtio_device *vdev,
>  				   u32 num,
> @@ -1137,7 +1172,19 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
>  	vring_split->vring_align = vring_align;
>  	vring_split->may_reduce_num = may_reduce_num;
>  
> +	if (vring_needs_used_validation(vdev)) {
> +		vring_split->buflen =
> +			kmalloc_array(num, sizeof(*vring_split->buflen),
> +				      GFP_KERNEL);
> +		if (!vring_split->buflen)
> +			goto err_buflen;
> +	}
> +
>  	return 0;
> +
> +err_buflen:
> +	vring_free_split(vring_split, vdev, dma_dev);
> +	return -ENOMEM;
>  }
>  
>  static struct virtqueue *vring_create_virtqueue_split(
> @@ -1297,6 +1344,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	unsigned int i, n, err_idx;
>  	u16 head, id;
>  	dma_addr_t addr;
> +	u32 buflen = 0;
>  
>  	head = vq->packed.next_avail_idx;
>  	desc = alloc_indirect_packed(total_sg, gfp);
> @@ -1325,6 +1373,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  			desc[i].addr = cpu_to_le64(addr);
>  			desc[i].len = cpu_to_le32(sg->length);
>  			i++;
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1379,6 +1429,10 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
>  	vq->packed.desc_state[id].last = id;
>  	vq->packed.desc_state[id].premapped = premapped;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->packed.buflen)
> +		vq->packed.buflen[id] = buflen;
> +
>  	vq->num_added += 1;
>  
>  	pr_debug("Added buffer head %i to %p\n", head, vq);
> @@ -1416,6 +1470,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	__le16 head_flags, flags;
>  	u16 head, id, prev, curr, avail_used_flags;
>  	int err;
> +	u32 buflen = 0;
>  
>  	START_USE(vq);
>  
> @@ -1498,6 +1553,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  					1 << VRING_PACKED_DESC_F_AVAIL |
>  					1 << VRING_PACKED_DESC_F_USED;
>  			}
> +			if (n >= out_sgs)
> +				buflen += sg->length;
>  		}
>  	}
>  
> @@ -1518,6 +1575,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
>  	vq->packed.desc_state[id].last = prev;
>  	vq->packed.desc_state[id].premapped = premapped;
>  
> +	/* Store in buffer length if necessary */
> +	if (vq->packed.buflen)
> +		vq->packed.buflen[id] = buflen;
> +
>  	/*
>  	 * A driver MUST NOT make the first descriptor in the list
>  	 * available before all subsequent descriptors comprising
> @@ -1718,6 +1779,11 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
>  		BAD_RING(vq, "id %u is not a head!\n", id);
>  		return NULL;
>  	}
> +	if (vq->packed.buflen && unlikely(*len > vq->packed.buflen[id])) {
> +		BAD_RING(vq, "used len %d is larger than max in buffer len %u\n",
> +			*len, vq->packed.buflen[id]);
> +		return NULL;
> +	}
>  
>  	/* detach_buf_packed clears data, so grab it now. */
>  	ret = vq->packed.desc_state[id].data;
> @@ -1937,6 +2003,7 @@ static void vring_free_packed(struct vring_virtqueue_packed *vring_packed,
>  				 vring_packed->device_event_dma_addr,
>  				 dma_dev);
>  
> +	kfree(vring_packed->buflen);
>  	kfree(vring_packed->desc_state);
>  	kfree(vring_packed->desc_extra);
>  }
> @@ -1988,6 +2055,14 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
>  
>  	vring_packed->vring.num = num;
>  
> +	if (vring_needs_used_validation(vdev)) {
> +		vring_packed->buflen =
> +			kmalloc_array(num, sizeof(*vring_packed->buflen),
> +				      GFP_KERNEL);
> +		if (!vring_packed->buflen)
> +			goto err;
> +	}
> +
>  	return 0;
>  
>  err:
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
