Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F4842189F
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107655; cv=none; b=g8WxU9nN6bzv/OPN04iDhudYBcazksuknMrxhchzCKLmBfxT0WFdKnPuOxVZcQIXUXJpMsY6GXU6Z+wftQgI6QMLWZbBl2qEfA//Wk0f3foO8YET70D0U9qEwS93rGQo8gGG7wTtsU/yPlet3PTsVD/31t426g/evaRSGqhAVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107655; c=relaxed/simple;
	bh=ab9zrutGUbgPv13A+LvkoPjezfD4kCV3kGOGktx7bEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kisSIOmGth3XOEscXa2/h9NEFhcd2mh1Ku0WzI8GEGbyBfzsMUfwKwQCtCBt4XdeqKBfiDFqNqzkW1glzirA0QwhnyC0JZoXzznq9yqqOvvJsxM2z12r+D1BbxyU/oqq8hLOXEqqxHtDPfvbaY3TLHPda7aTIw08Jle4WKvh0cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMKa+kGB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMKa+kGB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781107652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KTtszs1VfX/4nkl7kmlsgenQX26GcZqb815crHf1KnU=;
	b=bMKa+kGBvoWdPdWLFzEvGlfax4c7iOMl4wF9ISO4wjAn9ymAr04+Dr0EJ1V7wy7VIHq0hu
	O3uQRUPxOLWa6mTfdJPRgoJR2r2V3IIH0JEcnbYI/8mgnuKXkUvTW8FFt8KR1mXkpYRuY8
	kuJp/6PWADlEJuc5cRbj+gCqCbYTnt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-eKcquVGOOwOMz01awCxjvg-1; Wed, 10 Jun 2026 12:07:31 -0400
X-MC-Unique: eKcquVGOOwOMz01awCxjvg-1
X-Mimecast-MFC-AGG-ID: eKcquVGOOwOMz01awCxjvg_1781107650
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4601c9b630fso2908351f8f.0
        for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 09:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107650; x=1781712450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTtszs1VfX/4nkl7kmlsgenQX26GcZqb815crHf1KnU=;
        b=as6zhAFzF+6OgJgiLSAY8k+FCrFuozzKBjFcH1JcX8ue/FhoaopEUKgQlmlV32eTyD
         7fNydE9umnncEL4jpgbsR0eWZf/gj9C6RXA/1HzraNbxpcjRFInU3mrsUiwa6gP9Cse7
         XRq57jPXQF68x7PeVWstg3zZ/kxYgAVuds8v9gf3oiVevyD0ImmCn5FwAZ0RJLKV2eE9
         A71Noz1PbN0UkizZmDbmibgrUy0uvIjjkJ3CHI46+NKbZ4s4pBW+ivd6fPnwjz/clGen
         cB+1cni5WB4lYb4+Hbdea4BHozGt1q2hgW53dkP7Q0+Cg2B1Zds1VKouJEbuCbQDu5vO
         fGSg==
X-Forwarded-Encrypted: i=1; AFNElJ/p6GX+ubwQi3rfWKbIiDdi88/x7uNnIq9ydHbqAr/3K5ghQ62xr7+srBQZb06QhfbWi0+YeBJ0na2bQALu/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzygyinluFPSgMftOI8umAXw84k57LdCWOFv6sobKTsccpb4+Kr
	5ufKMK2J9zLkVWsF2+o2cxyCDbe75pqmeQ4+1RllkfkjXJDBB3pFgznL6+iMzU2g7jHxpifHs9d
	Rbq+J57ErZdSOzNjOzvl4RyCv8tcD29MkBur8yV6xbGg0mFV6hxdUxZ8kSNuwSOglBdty
X-Gm-Gg: Acq92OHjtySJsgNUl1AXNRcniGicCAUllHU/0vSUt2CWzEv3sAJ51aovkY6EAY8udoe
	0khhQ/RUlpGvNnsibH3/2TeV3fWDkDpgP6t4qUJAwmb7+huOHslrMquXF+UpVQcIdgM+R7BcwDB
	jXBSvES5Wrl7mnK6pS/XmXK52QRwNb77yhVdBX9Yc2cS1JoiFlyMfXS/d+Z5A/E8vY94izh0FkO
	MwgX0aoDwXqAyYfZu4sHeLq+1dUFbycoDqSp6lQW/J1W0F6+9T+nrGM6xgUU3on+tGLTueJthpD
	TSFhKeF77mJlHIpB59B8+stl5gSw5HscwjJ3alEVZaxoQmIDVHCsggKaHJaPPjMsEnwX88VXokZ
	fR8jSX9nAon1qG996NuiI8PDkUpV8O9bDq5L0vLe6z9bdnz8Y+G0lag==
X-Received: by 2002:adf:fcce:0:b0:45e:df08:b18 with SMTP id ffacd0b85a97d-4603075ca65mr27339702f8f.32.1781107649611;
        Wed, 10 Jun 2026 09:07:29 -0700 (PDT)
X-Received: by 2002:adf:fcce:0:b0:45e:df08:b18 with SMTP id ffacd0b85a97d-4603075ca65mr27339610f8f.32.1781107648928;
        Wed, 10 Jun 2026 09:07:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f0a43e9sm72246046f8f.0.2026.06.10.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:07:28 -0700 (PDT)
Date: Wed, 10 Jun 2026 12:07:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, viresh.kumar@linaro.org,
	"Chen, Jian Jun" <jian.jun.chen@intel.com>, andi.shyti@kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH v5] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <20260610120606-mutt-send-email-mst@kernel.org>
References: <20260610155834.79207-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260610155834.79207-1-gavin.li@samsara.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VmGWq067TbbdGMC0Kdevg8i1IVsHp8EudE4yRuh12hY_1781107650
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 10, 2026 at 11:58:34AM -0400, Gavin Li wrote:
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

But maybe, if queue reset is supported, we could use that?

Is that problematic?


And maybe fallback on device reset on interrupt even?

> ---
> 
> Changes in v5:
> - DMA-align all bounce buffers
> 
> Changes in v4:
> - Pack bounce buffers into a single allocation after reqs[]
> - Remove per-request buf pointer and xfer->num
> - Remove req.msg, track message direction with req->read
> - Simplify xfer release to a single kfree()
> - Restore using j to track successful transfers in _complete_xfer()
> ---
>  drivers/i2c/busses/i2c-virtio.c | 135 +++++++++++++++++++++++++-------
>  1 file changed, 108 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 5da6fef92bec3..a5602865102d9 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -10,10 +10,13 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/completion.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
>  #include <linux/virtio_config.h>
> @@ -31,39 +34,80 @@ struct virtio_i2c {
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
> + * - padding to dma_get_cache_alignment()
> + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[0].len)]
> + *   ...
> + * - u8 bounce_buf[virtio_i2c_bounce_size(msgs[num-1].len)]
> + */
> +struct virtio_i2c_xfer {
> +	struct kref ref;
> +	u8 *bounce_buf_base;
> +	struct virtio_i2c_req reqs[];
> +};
> +
> +static size_t virtio_i2c_bounce_size(unsigned int len)
> +{
> +	return ALIGN(len, dma_get_cache_alignment());
> +}
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
> @@ -82,23 +126,31 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
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
> +		bounce_buf += virtio_i2c_bounce_size(msgs[i].len);
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
> @@ -106,26 +158,38 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
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
> +		bounce_buf += virtio_i2c_bounce_size(msg->len);
>  	}
>  
>  	return j;
> @@ -136,14 +200,31 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  {
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
> -	struct virtio_i2c_req *reqs;
> -	int count;
> +	struct virtio_i2c_xfer *xfer;
> +	size_t alloc_size;
> +	int i, count;
> +
> +	alloc_size = struct_size(xfer, reqs, num);
> +	if (check_add_overflow(alloc_size,
> +			       dma_get_cache_alignment() - 1,
> +			       &alloc_size)) /* padding for PTR_ALIGN() */
> +		return -EOVERFLOW;
> +	for (i = 0; i < num; i++) {
> +		if (check_add_overflow(alloc_size,
> +				       virtio_i2c_bounce_size(msgs[i].len),
> +				       &alloc_size))
> +			return -EOVERFLOW;
> +	}
>  
> -	reqs = kzalloc_objs(*reqs, num);
> -	if (!reqs)
> +	xfer = kzalloc(alloc_size, GFP_KERNEL);
> +	if (!xfer)
>  		return -ENOMEM;
>  
> -	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> +	kref_init(&xfer->ref);
> +	xfer->bounce_buf_base = PTR_ALIGN((u8 *)(xfer->reqs + num),
> +					  dma_get_cache_alignment());
> +
> +	count = virtio_i2c_prepare_xfer(vq, xfer, msgs, num);
>  	if (!count)
>  		goto err_free;
>  
> @@ -157,10 +238,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
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

