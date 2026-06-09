Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F65A3DC4D0
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 07:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780990541; cv=none; b=ikkMwICdvnWlX66Nr3NUwNC5Mz1AL3vQYSy6w9HmIJVxB9Ku04nG9OLeoxFMkZP7pA91edJZAl8clKiz2ooxNag45eWXmFe6gACF8KllzTHyNodcM+MuTlJBIYw71e36I9CbHxZ+YQNagmKHZu4CQ/P4135PFDRAgGcWTUxvgqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780990541; c=relaxed/simple;
	bh=sWTUZp435LUI34hu5hbXbmA9JlnW2fhGEhRaeblH3+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvgCkSJIal0PP9estBhw+7UkY6zleBXCAc43k5wBGA1cfVtRwXMXLviLpTgJpINXieRNE4+1GL1dFLKCwJHEpRlcmclLwCRZN2KmC7UJQp79FFVNF2VW2qf1izXDDes/zmsEws3uz9cANMcgqntRLF7UYdmWCVA+5xNpTu552AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u9oEkYEB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9oEkYEB"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36da8439078so4616998a91.2
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 00:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780990538; x=1781595338; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cs0o2fvjFQWHzbbh8UI+DrytIQQ2LBIXnDQNLOZxtrY=;
        b=u9oEkYEBToa/9oQN81wQ9BcwA2i/fuASB+RR0Yn3ezDPfAak8KF0rFg5Sjn1ERpOkh
         kUUq3fFxb31g5DYLgWs/mwEsV1C1bJ6gvaAtxG8yrX8STS1L0bomZWv1rhwX39U1Oy5I
         m9NysuRy7/kWAtbHJ5c386h14YpEtJqj0kWew31BvXjviL9fa5IlY/vwLKyraArw3kAr
         wiyiTUes9mgR3CUjx2v+VMxETqfzukHAqdRdkuSiFLKBeTTgn4USVxPGtNntMWBzgX6x
         I7bya08Q5QoknbNrE+DPp7MIRNZxpn1b963HT2JmZ3ynoujO7b1U41DVhNgYhBy2Gjet
         xE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780990538; x=1781595338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cs0o2fvjFQWHzbbh8UI+DrytIQQ2LBIXnDQNLOZxtrY=;
        b=PWhevw1o+LWU4pxLRRi6cxZITTMgSmj+KR13HJiRWkoOVBkDdFKvD+6/coTQBAug9p
         6zp2mz4UpXA8IL3CZZiUvVtJ2uIQJOmZ7WiWvozinV60V5MKnMefyB7TqhtSO04GPChU
         klHUakLnDV+SZ3HS1DxPiq5ZppsOeB5DyBSN5JkK9mOQ+hph+CX9RzPwLecRAMN93eQo
         Z2quF6rGvjRUvRs/R/55lMymrN2zhH+ar8qGAh6zbHP0ZYL7doQ3cGA+YPnd70kBw4gS
         P45yIA/BL8o6hxQmPxG0+Vq9gdXiV4wrcnslASzvQBuoliDDFx/J7KZ4FMJNgOd9Qoys
         vaEg==
X-Forwarded-Encrypted: i=1; AFNElJ/0N84IuURGqfX8COoLVxrxEQbmNYDCAQCYPAhuE35QoMHx5ICsdRborMvxrV0L1HDRr52Q2yegl6QwNd4nxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxlDkkCByAXozJ3X9jmCE69lY6NWs93EmaVqjsReFoz0S96Ndqu
	zzq6ezWlWr9e12eUe0SA/Z68UpkokAY3LtgtAI+a+dfL3CmLhgxPRKpWgvaBWc70CW8=
X-Gm-Gg: Acq92OEgOLq2OFTP6RoKgQC/Ww+nZI+9LU8WJ8sC2SLg+PnIvvsI08KFDt3eaaV+aGL
	ID/Vba7hxWFp/wn66BBa7jexRUeDV88voK31OwUZj+GQiN5MTjIjPx2+Z+Sa2apkmiU/imxmc4K
	hDhnwgLlLE5lV+YZzJzBMTD14ML+vNpU7fUPuyRw6p/tQl0BXqIXhkeeLbiLOkwQjK93yPnYDPI
	boCXgyUjmH0kGEkl+ND0h86KSAYSin40yguQBgFM5EZWhIN2HCCGeO3Re6J19Gp/7MWEbEfGeUI
	eb+rWyAok9LblcF2f4wJ8rDt77qDVgVoLG61SrG8gdgpB1N60Z+mP8d1dvKNy6iHWaN4F8IW8TQ
	MOxJPV02h8l82h9MlDnXGIJTRtpSC2O1zr7qROI5XT1eN3+7SFABNGaHkPmCZifJJh59SoYPgv2
	J+RWIyVAwkxp5l/7iDE2NEVPFOGDGpW7EPhA==
X-Received: by 2002:a17:90b:3b90:b0:366:132:fda7 with SMTP id 98e67ed59e1d1-370ef0f5bcamr20111195a91.10.1780990538044;
        Tue, 09 Jun 2026 00:35:38 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf82841sm22001694a91.2.2026.06.09.00.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:35:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 13:05:33 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Gavin Li <gavin.li@samsara.com>
Cc: linux-i2c@vger.kernel.org, "Chen, Jian Jun" <jian.jun.chen@intel.com>, 
	andi.shyti@kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2] i2c: virtio: retain xfer with kref to fix UAF on
 interrupted wait
Message-ID: <ae754hwynvlfnuway2jdjuebyammfrz225pxymfhuqpusp4xkp@joyqrrkberpc>
References: <20260607143608.76122-1-gavin.li@samsara.com>
 <20260608174435.62359-1-gavin.li@samsara.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608174435.62359-1-gavin.li@samsara.com>

On 08-06-26, 13:44, Gavin Li wrote:
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
> completes the request. The virtio spec provides no way to cancel an
> in-flight transfer, so that is not an acceptable tradeoff.
> 
> This commit makes two changes:
> 
> - Manage the freeing of the xfer allocations via kref, and ensure that
>   each in-flight request holds a reference. This fixes the
>   use-after-free by ensuring that the virtio device has a valid location
>   to write to until the request completes. This will cause a memory
>   leak in cases where the device hangs, but that is much preferable to
>   memory corruption.
> 
> - Use wait_for_completion_killable() instead of _interruptible(). Even
>   partial I2C transactions can have side effects, so the only time it
>   makes sense to interrupt a transaction is when a process needs to be
>   killed. Most existing I2C drivers don't support interruption at all,
>   so this should not break userspace applications. This also addresses
>   issues with Go programs accessing devices via the I2C userspace API,
>   since the Go runtime stochastically signals SIGURG to running threads;
>   leaving this as _interruptible() may cause partial side effects from
>   which it is impossible to cleanly restart.
> 
> Signed-off-by: Gavin Li <gavin.li@samsara.com>
> ---
>  drivers/i2c/busses/i2c-virtio.c | 89 ++++++++++++++++++++++++---------
>  1 file changed, 64 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-virtio.c b/drivers/i2c/busses/i2c-virtio.c
> index 726c162cabd86..f7320a67a3409 100644
> --- a/drivers/i2c/busses/i2c-virtio.c
> +++ b/drivers/i2c/busses/i2c-virtio.c
> @@ -13,6 +13,7 @@
>  #include <linux/err.h>
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
> +#include <linux/kref.h>
>  #include <linux/module.h>
>  #include <linux/virtio.h>
>  #include <linux/virtio_ids.h>
> @@ -31,39 +32,77 @@ struct virtio_i2c {
>  	struct virtqueue *vq;
>  };
>  
> +struct virtio_i2c_xfer;
> +
>  /**
>   * struct virtio_i2c_req - the virtio I2C request structure
> + * @xfer: owning transfer
> + * @msg: copy of the I2C message for virtio_i2c_xfer_release
>   * @completion: completion of virtio I2C message
>   * @out_hdr: the OUT header of the virtio I2C message
>   * @buf: the buffer into which data is read, or from which it's written
>   * @in_hdr: the IN header of the virtio I2C message
>   */
>  struct virtio_i2c_req {
> +	struct virtio_i2c_xfer *xfer;
> +	struct i2c_msg msg;
>  	struct completion completion;
>  	struct virtio_i2c_out_hdr out_hdr	____cacheline_aligned;
>  	uint8_t *buf				____cacheline_aligned;
>  	struct virtio_i2c_in_hdr in_hdr		____cacheline_aligned;
>  };
>  
> +/**
> + * struct virtio_i2c_xfer - a queued I2C transfer
> + * @ref: one ref for the caller, plus one per in-flight virtqueue request
> + * @num: number of messages
> + * @reqs: the virtio I2C requests
> + */
> +struct virtio_i2c_xfer {
> +	struct kref ref;
> +	int num;
> +	struct virtio_i2c_req reqs[];
> +};
> +
> +static void virtio_i2c_xfer_release(struct kref *ref)
> +{
> +	struct virtio_i2c_xfer *xfer = container_of(ref, struct virtio_i2c_xfer, ref);
> +	int i;
> +
> +	for (i = 0; i < xfer->num; i++) {
> +		struct virtio_i2c_req *req = &xfer->reqs[i];
> +		i2c_put_dma_safe_msg_buf(req->buf, &req->msg, false);
> +	}
> +
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
>  static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
> -				   struct virtio_i2c_req *reqs,
> +				   struct virtio_i2c_xfer *xfer,
>  				   struct i2c_msg *msgs, int num)
>  {
>  	struct scatterlist *sgs[3], out_hdr, msg_buf, in_hdr;
> +	struct virtio_i2c_req *reqs = xfer->reqs;
>  	int i;
>  
> +	kref_init(&xfer->ref);
> +
>  	for (i = 0; i < num; i++) {
>  		int outcnt = 0, incnt = 0;
>  
> +		reqs[i].xfer = xfer;
> +		reqs[i].msg = msgs[i];
>  		init_completion(&reqs[i].completion);
>  
>  		/*
> @@ -99,36 +138,36 @@ static int virtio_i2c_prepare_reqs(struct virtqueue *vq,
>  
>  		if (virtqueue_add_sgs(vq, sgs, outcnt, incnt, &reqs[i], GFP_KERNEL)) {
>  			i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], false);
> +			reqs[i].buf = NULL; /* prevent free by virtio_i2c_xfer_release */
>  			break;
>  		}
> +
> +		kref_get(&xfer->ref); /* released in virtio_i2c_msg_done() */

Maybe move the comment above the code ? Can be dropped too.

Also, maybe there is a small race here, not sure. What if the other
side (polls and) processes the message as soon as it is added to the
queue with virtqueue_add_sgs() ? In that case virtio_i2c_msg_done()
will call complete (which won't harm) and kref_put(). If this happens
for the first req of the xfer, it may end up freeing the xfer while
being used here ?

>  	}
>  
> +	xfer->num = i;
>  	return i;
>  }
>  
> -static int virtio_i2c_complete_reqs(struct virtqueue *vq,
> -				    struct virtio_i2c_req *reqs,
> -				    struct i2c_msg *msgs, int num)
> +static int virtio_i2c_complete_reqs(struct virtio_i2c_xfer *xfer)

Maybe rename to complete_xfer now ?

>  {
> -	bool failed = false;
> -	int i, j = 0;
> +	struct virtio_i2c_req *reqs = xfer->reqs;
> +	int i, fail_index = -1;
>  
> -	for (i = 0; i < num; i++) {
> +	for (i = 0; i < xfer->num; i++) {
>  		struct virtio_i2c_req *req = &reqs[i];
> -
> -		if (!failed) {
> -			if (wait_for_completion_interruptible(&req->completion))
> -				failed = true;
> -			else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK)
> -				failed = true;
> -			else
> -				j++;
> +		if (wait_for_completion_killable(&req->completion)) {

Maybe do this in a separate patch ?

> +			return -EINTR;
> +		} else if (req->in_hdr.status != VIRTIO_I2C_MSG_OK) {
> +			/* Don't break yet. Try to wait until all requests complete. */
> +			if (fail_index < 0)
> +				fail_index = i;
>  		}
> -
> -		i2c_put_dma_safe_msg_buf(reqs[i].buf, &msgs[i], !failed);
> +		i2c_put_dma_safe_msg_buf(req->buf, &req->msg, fail_index < 0);
> +		req->buf = NULL; /* prevent free by virtio_i2c_xfer_release */
>  	}
>  
> -	return j;
> +	return fail_index >= 0 ? fail_index : xfer->num; /* number of successful transactions */

If this comment is required, maybe add it above the line instead.

>  }
>  
>  static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
> @@ -136,14 +175,14 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  {
>  	struct virtio_i2c *vi = i2c_get_adapdata(adap);
>  	struct virtqueue *vq = vi->vq;
> -	struct virtio_i2c_req *reqs;
> +	struct virtio_i2c_xfer *xfer;
>  	int count;
>  
> -	reqs = kcalloc(num, sizeof(*reqs), GFP_KERNEL);
> -	if (!reqs)
> +	xfer = kzalloc(struct_size(xfer, reqs, num), GFP_KERNEL);
> +	if (!xfer)
>  		return -ENOMEM;
>  
> -	count = virtio_i2c_prepare_reqs(vq, reqs, msgs, num);
> +	count = virtio_i2c_prepare_reqs(vq, xfer, msgs, num);
>  	if (!count)
>  		goto err_free;
>  
> @@ -157,10 +196,10 @@ static int virtio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
>  	 */
>  	virtqueue_kick(vq);
>  
> -	count = virtio_i2c_complete_reqs(vq, reqs, msgs, count);
> +	count = virtio_i2c_complete_reqs(xfer);
>  
>  err_free:
> -	kfree(reqs);
> +	kref_put(&xfer->ref, virtio_i2c_xfer_release);
>  	return count;
>  }

Nice work Gavin.

-- 
viresh
