Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471A9403AE0
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104110; cv=none; b=pHtX5lrTebvR64O7aO5h5jwy/9uheYVdQVt9g1oufDSRLYeafu8OypSch4MLxTs7lL5R4R+p6Md+OPlVFW6FRVSB8VrS4sFyfpynCCEVWpbG/B2awelxIZc7Ymp9NsCqUmOofxbHuwFRy9I/zOR9/T0If7IvHCrs/ZTv4Tr/hLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104110; c=relaxed/simple;
	bh=cNThQlfS58F1r95X/itrRc2OX2+y1zC+o2y9ilcM6o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=m8GEnRlxcduuwedBfp2EwQ1ky22wBxTi+ARPhLJXXNosuoyPFtVf8FDNvZZ3sm3VKS8g9vA2qQPP+gW2kwxyHWKt4x86AaKJhfpB8Y85DGDOJQIt4gglOFx90I7n1ZdgoUp/DUmo51wb46tzYVH+/HpIZHRX+1+d/U1aM7C5qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwrqZlYM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwrqZlYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781104107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dGSS9VTzk4uar69LKrLRgBTTrN3k3lycm4CMSdOQbOY=;
	b=fwrqZlYMFsPVPG9rx1aQ7dc0ZWtBz7keaUAc7xLFUNsBtfdNKZbQCZIbKvB2xk0dFTKw/t
	/zQRpymOAwb1B/4o7C06ldA8H+/sB9PBuk5BI25H5LVJLyyuKkQHhRSGLA+a+jt68iHUK/
	dcMZHDlgWW1MihsTI0AOt1VWV8R4ro8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-wHdCvvOwMFSBkh2zc1vMHQ-1; Wed, 10 Jun 2026 11:08:26 -0400
X-MC-Unique: wHdCvvOwMFSBkh2zc1vMHQ-1
X-Mimecast-MFC-AGG-ID: wHdCvvOwMFSBkh2zc1vMHQ_1781104105
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-396a9348bfdso43225091fa.1
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 08:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781104104; x=1781708904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGSS9VTzk4uar69LKrLRgBTTrN3k3lycm4CMSdOQbOY=;
        b=JitsduSUorXuovT031AAtOG71hPgx0vmAZ4EurfAJ5adWZNdlv54WOXXJ6zJymZCSM
         CL0l9jbEJg1ueHE3YrHAHS3QCfcYO1DR6XcXavk80BNAC0lOKzVG/p8gWZKseTdVninc
         AetQHLls/XDE6sI4FUoxMXw42tSQTSOqt/htkkGfyBTA6b84V3xxGkI5Zuou8YEV85HI
         fIkL5qIO2r2SgILIxjtfeKDsfO5uyxIrIIQo9TwGkyxHVlq2YBo23WbnRbDMExbWFfG0
         rX8GxFtLTWwga4Fkme66by2DrMN3JhkeVvsLmf/W0bt3SCXJQN2Epc1tboTqpE0CIYD3
         Gg7w==
X-Forwarded-Encrypted: i=1; AFNElJ/IOQZw0wJeS8DTVTedoiLYX9gt6Tv8KSJnYDOg+n6Xr8zYLyU7e6AGb3M1Kt20TquyeNDbBZPvoLy/Gf6kSw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx1f6+7X0CKXB8Lm+YiuTc/+eZ7mxqtxLNm5L/Gv0UQZn/5N+gC
	i7hho8UakIAOM/u261ygzr5+Jw4imZQaO/v2wJOV+9OCiRY7OSXbsp4hqVQqtQuDGIaG6pPOtW9
	Ie7/vrVzKAs2YTBol3gXXpVybOEIgvoxYyUh2HnbgLuSiQhPa4tJH9U4JDNJDDbLQBgdn
X-Gm-Gg: Acq92OFCjKu08N/wJBGKO6l8BeNwNC5wsavR/FiT6rMDY+K36ih21elrPzbpJ7weWwm
	4+l6MDsHR3+mW/3XI2VgiHauvSQjUSIVtK79mhhZ0F3/zBUl6AG8WZqCc3TYy1d+91VrwJ5ZrVg
	S8S4UExqcD5ePDXAuXA87S4NutL+iO7BeaYUVcbqBIK9LGcG9XSO/+bDzMpGsOrEuyXB1853Wyy
	B1Pk9rSHcmHrWRqjvmBUXB7xYO19aqoxjabQ1DdPQlFPMH4M869QClsXWketX/OqEiSk5YJrTem
	YuM+1SQQVW/FSuZ70UyfeBgJvS75RYrVEervlfUeB4CL3S9Hv4wRTR48+JbvTUZ6vbhL50gWzac
	9Nk/yZgJ9ove2aJSj40FbfzCYjGEDiAESS888es2Ds/jMnGzl6Tg1yQ==
X-Received: by 2002:a2e:9a16:0:b0:396:a6d3:f04d with SMTP id 38308e7fff4ca-396d0895474mr75298631fa.14.1781104104278;
        Wed, 10 Jun 2026 08:08:24 -0700 (PDT)
X-Received: by 2002:a2e:9a16:0:b0:396:a6d3:f04d with SMTP id 38308e7fff4ca-396d0895474mr75298491fa.14.1781104103650;
        Wed, 10 Jun 2026 08:08:23 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2be369sm62591361fa.26.2026.06.10.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:08:22 -0700 (PDT)
Date: Wed, 10 Jun 2026 11:08:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v4] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610110532-mutt-send-email-mst@kernel.org>
References: <20260610150232.24834-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260610150232.24834-1-gavin.li@samsara.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2uR-v_ZOKD3k4AtHxK-lrB531ds-Gsm2G2NUbwoK9zY_1781104105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 11:02:32AM -0400, Gavin Li wrote:
> commit a663b3c47ab1 ("i2c: virtio: Avoid hang by using interruptible
> completion wait") switched virtio_i2c_complete_reqs() to
> wait_for_completion_interruptible() so a stuck device cannot hang a
> task forever. That left a use-after-free: if the wait returns early on
> a signal, virtio_i2c_xfer() frees reqs and DMA bounce buffers while the
> device may still hold virtqueue tokens pointing at &reqs[i] and DMA
> into read buffers. When those requests complete later,
> virtio_i2c_msg_done() calls complete() on freed memory.
> 
> Waiting uninterruptibly for every completion before freeing avoids the
> UAF but can hang the caller indefinitely if the virtio side never
> completes the request. Performing a queue reset / device reset is
> possible in this scenario, but adds complexity.
> 
> This commit manages the freeing of the xfer allocations via kref, and
> ensures that each in-flight request holds a reference. This fixes the
> use-after-free by ensuring that the virtio device has a valid location
> to write to until the request completes. This will cause a memory leak
> in cases where the device hangs, but that is much preferable to memory
> corruption.
> 
> Additionally, force usage of a bounce buffer even if the i2c_msg buf is
> DMA-safe, since the buffer passed to the virtqueue must remain valid
> even if the transfer is interrupted. Remove usage of
> i2c_get_dma_safe_msg_buf() since it may pass through msg->buf directly.
> All bounce buffers are part of the single xfer allocation, so there is
> no additional allocation overhead.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>
> 
> ---
> 
> Changes in v4:
> - Pack bounce buffers into a single allocation after reqs[]
> - Remove per-request buf pointer and xfer->num
> - Remove req.msg, track message direction with req->read
> - Simplify xfer release to a single kfree()
> - Restore using j to track successful transfers in _complete_xfer()
> ---
>  drivers/i2c/busses/i2c-virtio.c | 121 +++++++++++++++++++++++++-------
>  1 file changed, 94 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..33b469ca39d4b 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -13,7 +13,9 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
> @@ -31,39 +33,74 @@ struct virtio_i2c {
>  	struct virtqueue *vq;
>  };
>  
> +struct virtio_i2c_xfer;
> +
>  /**
>   * struct virtio_i2c_req - the virtio I2C request structure
> + * @xfer: owning transfer
>   * @completion: completion of virtio I2C message
> + * @read: true if this is a read message (I2C_M_RD is set)
>   * @out_hdr: the OUT header of the virtio I2C message
> - * @buf: the buffer into which data is read, or from which it's written
>   * @in_hdr: the IN header of the virtio I2C message
>   */
>  struct virtio_i2c_req {
> +	struct virtio_i2c_xfer *xfer;
>  	struct completion completion;
> +	bool read;
>  	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
> -	uint8_t *buf				____cacheline_aligned;
>  	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
>  };
>  
> +/**
> + * struct virtio_i2c_xfer - a queued I2C transfer
> + * @ref: one ref for the caller, plus one per in-flight virtqueue request
> + * @bounce_buf_base: start of bounce buffer region
> + * @reqs: the virtio I2C requests
> + *
> + * Allocation layout:
> + * - struct virtio_i2c_xfer xfer
> + * - struct virtio_i2c_req reqs[num]
> + * - u8 bounce_buf[msgs[0].len]
> + *   ...
> + * - u8 bounce_buf[msgs[num-1].len]

You seems to be ignoring DMA alignment requirements here.
Did you try running with DMA debugging enabled?


> + */
> +struct virtio_i2c_xfer {
> +	struct kref ref;
> +	u8 *bounce_buf_base;
> +	struct virtio_i2c_req reqs[];
> +};
> +
> +static void virtio_i2c_xfer_release(struct kref *ref)
> +{
> +	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
> +	kfree(xfer);
> +}
> +
>  static void virtio_i2c_msg_done(struct virtqueue *vq)
>  {
>  	struct virtio_i2c_req *req;
>  	unsigned int len;
>  
> -	while ((req = virtqueue_get_buf(vq, &len)))
> +	while ((req = virtqueue_get_buf(vq, &len))) {
>  		complete(&req->completion);
> +		kref_put(&req->xfer->ref, virtio_i2c_xfer_release);
> +	}
>  }
>  
> -static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> -				   struct virtio_i2c_req *reqs,
> +static int virtio_i2c_prepare_xfer(struct virtqueue *vq,
> +				   struct virtio_i2c_xfer *xfer,
>  				   struct i2c_msg *msgs, int num)
>  {
>  	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	struct virtio_i2c_req *reqs = xfer->reqs;
> +	u8 *bounce_buf = xfer->bounce_buf_base;
>  	int i;
>  
>  	for (i = 0; i < num; i++) {
>  		int outcnt = 0, incnt = 0;
>  
> +		reqs[i].xfer = xfer;
> +		reqs[i].read = !!(msgs[i].flags & I2C_M_RD);
>  		init_completion(&reqs[i].completion);
>  
>  		/*
> @@ -82,23 +119,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  		sgs[outcnt++] = &out_hdr;
>  
>  		if (msgs[i].len) {
> -			reqs[i].buf = i2c_get_dma_safe_msg_buf(&msgs[i], 1);
> -			if (!reqs[i].buf)
> -				break;
> +			/*
> +			 * Even if msg->flags has I2C_M_DMA_SAFE set, a bounce
> +			 * buffer is required because the transfer may be
> +			 * interrupted, after which msg->buf is no longer valid.
> +			 */
> +			if (!(msgs[i].flags & I2C_M_RD))
> +				memcpy(bounce_buf, msgs[i].buf, msgs[i].len);
>  
> -			sg_init_one(&msg_buf, reqs[i].buf, msgs[i].len);
> +			sg_init_one(&msg_buf, bounce_buf, msgs[i].len);
>  
>  			if (msgs[i].flags & I2C_M_RD)
>  				sgs[outcnt + incnt++] = &msg_buf;
>  			else
>  				sgs[outcnt++] = &msg_buf;
>  		}
> +		bounce_buf += msgs[i].len;
>  
>  		sg_init_one(&in_hdr, &reqs[i].in_hdr, sizeof(reqs[i].in_hdr));
>  		sgs[outcnt + incnt++] = &in_hdr;
>  
> +		/* This reference is released in virtio_i2c_msg_done(). */
> +		kref_get(&xfer->ref);
> +
>  		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
> -			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			kref_put(&xfer->ref, virtio_i2c_xfer_release);
>  			break;
>  		}
>  	}
> @@ -106,26 +151,38 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  	return i;
>  }
>  
> -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> -				    struct virtio_i2c_req *reqs,
> -				    struct i2c_msg *msgs, int num)
> +static int virtio_i2c_complete_xfer(struct virtio_i2c_xfer *xfer,
> +				    struct i2c_msg *msgs,
> +				    int num)
>  {
> +	struct virtio_i2c_req *reqs = xfer->reqs;
> +	u8 *bounce_buf = xfer->bounce_buf_base;
>  	bool failed = false;
>  	int i, j = 0;
>  
>  	for (i = 0; i < num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
> +		struct i2c_msg *msg = &msgs[i];
> +
> +		if (wait_for_completion_interruptible(&req->completion))
> +			return -EINTR;
> +
> +		if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
> +			/*
> +			 * Don't break yet. Try to wait until all requests
> +			 * complete to ensure that the virtqueue has enough
> +			 * descriptor slots for the next transfer.
> +			 */
> +			failed = true;
> +		}
>  
>  		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> +			if (req->read)
> +				memcpy(msg->buf, bounce_buf, msg->len);
> +			j++;
>  		}
>  
> -		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +		bounce_buf += msg->len;
>  	}
>  
>  	return j;
> @@ -136,14 +193,24 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  {
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
> -	struct virtio_i2c_req *reqs;
> -	int count;
> +	struct virtio_i2c_xfer *xfer;
> +	size_t alloc_size;
> +	int i, count;
>  
> -	reqs = kzalloc_objs(*reqs, num);
> -	if (!reqs)
> +	alloc_size = struct_size(xfer, reqs, num);
> +	for (i = 0; i < num; i++) {
> +		if (check_add_overflow(alloc_size, msgs[i].len, &alloc_size))
> +			return -EOVERFLOW;
> +	}
> +
> +	xfer = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!xfer)
>  		return -ENOMEM;
>  
> -	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> +	kref_init(&xfer->ref);
> +	xfer->bounce_buf_base = (u8 *)(xfer->reqs + num);
> +
> +	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
>  	if (!count)
>  		goto err_free;
>  
> @@ -157,10 +224,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	virtqueue_kick(vq);
>  
> -	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
> +	count = virtio_i2c_complete_xfer(xfer, msgs, count);
>  
>  err_free:
> -	kfree(reqs);
> +	kref_put(&xfer->ref, virtio_i2c_xfer_release);
>  	return count;
>  }
>  
> -- 
> 2.54.0

