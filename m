Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A233F9A05
	for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789735163; cv=none; b=bqSomyVD5Z05BSzMATEjaypWQPinEvYidcGNGa7o2hADYQcOzy5S0pM7P8HHc6nJLF0X/9mNLeZKff0FITR7l6RKI+wTCSZSbayqEg/Toih/TkOH5bGwIZcCm66BmLLcK5SVU/aGzoqI2L/NtxE3TkzV6zyNVX60jENwDRbTC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789735163; c=relaxed/simple;
	bh=kigmj7KheVI1jVhW+lA+XS1EsEO2BIkt0zpw6QUT29Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UzzFkFkhH+3XxW/yVzUVljD1gMT9+PGj+7LIlkh93sFFKQUm5jT0LWlKrCg7ZKSZL586bvR61TxtCUadUXcA2fBvwOP/wUC4GXGhAsNN+XlABZ7u9PDAXvtOyHDch2LllWy26sjVYlYRjUH5w3YxuZhIrqH8rlGedlg2jOEov0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZIzhRBGj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZIzhRBGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789735159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sNsc17Pvzd7sL7hQZNidFKGB3iUuH+JESwTaP4lZryk=;
	b=ZIzhRBGjIbSpgMfyKzollEc+1enpYw6t2pdvkqJ3rKAmK4NXbcXdWKS7iBixm2CQAk+wGk
	aBakhpPLnqY2G+HiAWP24WLpQDODq+MhciUtFNdVOPiptryx6qawRjBe01eXkRnA+NJt0R
	Gl6HRzxnXiKIFx9eAG38SGUgDyX1w7I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-zR5Y0zccOISK-wckaSm6_g-1; Fri, 18 Sep 2026 08:39:18 -0400
X-MC-Unique: zR5Y0zccOISK-wckaSm6_g-1
X-Mimecast-MFC-AGG-ID: zR5Y0zccOISK-wckaSm6_g_1789735157
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso5897365e9.2
        for <virtualization@lists.linux.dev>; Fri, 18 Sep 2026 05:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789735157; x=1790339957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sNsc17Pvzd7sL7hQZNidFKGB3iUuH+JESwTaP4lZryk=;
        b=OgZTI2VBQdoh7UDxAbTmTwrtphXs9ZjERZdkwDwlmDA2gz+4Zp0sERVGDdfW3UMJec
         nU2R3zSZ+CSdZ7dTbXr69GOYQMVWL/JrT8zVUE8nHUwiVmdogTk4xLiUHg0oWZZ3wzkm
         gtDrj5uswaN3DXTU1vmrxFG4KU5Ay1HTRKCfXNsSu+RVikWugyKrq35u0hfs+X4CHP8v
         XxbjuC7FrKMTwJBpdiXf3jsZU6NSVM3Idq1lOKPgnbENH5Q4hAtZtyN7yA+s4pKANX73
         hxhJBmWIK3X9G/oE/enkz7md4XHQ8232YOkSq1mdzwUW0/R+Ot8C7WrF3DhjAXzpIA0d
         s18A==
X-Forwarded-Encrypted: i=1; AKwUvBxZ4nG3MWmVt7igvVqxt1Tuc/iXKm31p+EJfa7WgCa4QppEf/VHVhV2BLUV3/2TtOBt55WD7UEATD+1TlEEVQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m9N7AUmnFMhBZyAMx3Yl8j2tF3kQXlil9IwaLhmspSPw7SqWuB
	wjU2n0+xXd5jNRAhFbneuyQ64+mJLSMJctcwHNRd4bun0Kiw3huRohLgIrlZSMifGxmBRcNve6+
	PZ1blC8uAKfiglEkIDIAUDUueh5nSWgRQ60ObD4W32CARN0XCmP+PttVmgIjPctMQMllPFXLqIi
	jn
X-Gm-Gg: AYBFou2tmgQ/193aCykuf5p8nDb343ilPFRvH2CX6C2l11jtCTuqQqH6wEjSkM7/51N
	9DoBKc6tj/SrW3djNwYw3Wg9427vZhizwzzTYORNqgrRbjKFB6FJ0ElOc5xzHWQ4PbBoOpy2O9P
	1p5e02tZmTeAuFlM6xWg8DgqNceYK7pZIICnHpfNds1olyoz9v4haxHGiMqTeoz/vJwJpLWNDHn
	M9W5hZdbLyh2s92jAehz/5lKePS9+BAfMA9+0OY4UdJD1m5nqIHq1AQ7lfiKUTDZevKGcBK4PLr
	EcRPOvgY3b3Wie9n78A6Ff7IiRkMVn8Cy1PaDvrDLuWg+q0JvP449wT+FWcklxUkYFgcoq0BHeX
	T+mzxfiCyWfEorSppBvMEtSE=
X-Received: by 2002:a05:600c:6296:b0:49e:63cd:31fb with SMTP id 5b1f17b1804b1-49fc5714bdamr31003245e9.9.1789735156686;
        Fri, 18 Sep 2026 05:39:16 -0700 (PDT)
X-Received: by 2002:a05:600c:6296:b0:49e:63cd:31fb with SMTP id 5b1f17b1804b1-49fc5714bdamr31002895e9.9.1789735156181;
        Fri, 18 Sep 2026 05:39:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc55cd8a8sm55011365e9.0.2026.09.18.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:39:15 -0700 (PDT)
Date: Fri, 18 Sep 2026 08:39:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: axboe@kernel.dk, virtualization@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefanha@redhat.com, hch@infradead.org, jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com
Subject: Re: [PATCH v3] virtio-blk: clamp max_segments to virtqueue ring size
Message-ID: <20260918083557-mutt-send-email-mst@kernel.org>
References: <20260916104218-mutt-send-email-mst@kernel.org>
 <20260918113412.1142493-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260918113412.1142493-1-sergiiushakov@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 186HAGqyBvZN6Z0LZuxSs4WhnlWGfjEj02DautI_h-M_1789735157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Love the patch! yet something to improve:

On Fri, Sep 18, 2026 at 01:34:12PM +0200, Sergii Ushakov wrote:
> In virtblk_add_req(), each request consumes 2 extra descriptors (out_hdr
> and in_hdr) in addition to the data scatter-gather segments.
> 
> When a hypervisor (e.g. QNX Hypervisor) advertises VIRTIO_BLK_F_SEG_MAX
> with seg_max = 1024 alongside a 1024-entry split ring (vring.num = 1024)
> and VIRTIO_RING_F_INDIRECT_DESC disabled, lim->max_segments is set to
> 1024. When the block layer submits requests with 1023 or 1024 data
> segments, total_sg reaches 1025 or 1026. This exceeds vring.num (1024),
> causing virtqueue_add_split() to return -ENOSPC and permanently wedge
> the blk-mq queue.
> 
> Furthermore, the Virtio specification (2.7.5.3.1) requires that a
> descriptor chain never exceed the Queue Size, and virtqueue_add_split()
> falls back to direct descriptors if indirect table allocation fails.
> 
> Fix this by:
> 1. Rejecting queues with ring_size < 3 at probe, or
>    ring_size < (queue_max_segments + 2) during resume/reset recovery in
>    init_vq().
> 2. Unconditionally clamping sg_elems to (ring_size - 2) across all
>    virtqueues in virtblk_read_limits().
> 


Fixes tag please?

> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> Hi Michael,
> 
> Thank you for the detailed review!
> 
> I logged the values in virtblk_read_limits() on the QNX Hypervisor guest:
>   virtio_blk virtio0: 1/0/0 default/read/poll queues
>   virtio_blk virtio0: F_SEG_MAX=1 seg_max=1024 F_INDIRECT=0 vring_size=1024 max_segments=1024
> 
>   dev_info(&vdev->dev,
>            "virtio_blk debug: F_SEG_MAX=%d seg_max=%u F_INDIRECT=%d vring_size=%u max_segments=%u\n",
>            virtio_has_feature(vdev, VIRTIO_BLK_F_SEG_MAX),
>            sg_elems,
>            virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC),
>            virtqueue_get_vring_size(vblk->vqs[0].vq),
>            lim->max_segments);
> 
> So what actually happens:
> 1. The host *does* advertise VIRTIO_BLK_F_SEG_MAX=1 with seg_max=1024 (setting
>    seg_max equal to the virtqueue size vring_size=1024), and does *not*
>    offer VIRTIO_RING_F_INDIRECT_DESC (F_INDIRECT=0).
> 2. Because seg_max (1024) <= VIRTIO_BLK_MAX_SG_ELEMS - 2 (32766),
>    virtblk_read_limits() sets lim->max_segments = 1024.
> 3. The block layer submits requests with 1023 or 1024 data segments.
>    virtblk_add_req() adds 2 extra descriptors (out_hdr and in_hdr),
>    resulting in total_sg > 1024.
> 4. Since total_sg > vq->split.vring.num and !vq->indirect,
>    virtqueue_add_split() triggers:
>      WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> In v3, I drop the !virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)
> condition and clamp sg_elems to (ring_size - 2) unconditionally across all
> virtqueues.
> 
> Also, init_vq() checks all virtqueues:
> - At initial probe (!vblk->disk), it enforces ring_size >= 3.
> - On resume/recovery, it enforces
>   ring_size >= queue_max_segments(vblk->disk->queue) + 2.
> 
> Logs after the v3 patch:
>   virtio_blk virtio0: F_SEG_MAX=1 seg_max=1022 F_INDIRECT=0 vring_size=1024 max_segments=1022
> 
>  drivers/block/virtio_blk.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..c263d0e3db95 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1021,6 +1021,21 @@ static int init_vq(struct virtio_blk *vblk)
>  		goto out;
>  
>  	for (i = 0; i < num_vqs; i++) {
> +		unsigned int ring_size = virtqueue_get_vring_size(vqs[i]);
> +		unsigned int min_ring_size = 3;
> +
> +		if (vblk->disk)
> +			min_ring_size = queue_max_segments(vblk->disk->queue) + 2;

could you pls add code comments documenting the constants here?


> +
> +		if (ring_size < min_ring_size) {
> +			dev_err(&vdev->dev,
> +				"virtqueue %u ring size %u is smaller than minimum %u\n",
> +				i, ring_size, min_ring_size);
> +			vdev->config->del_vqs(vdev);
> +			err = -EINVAL;
> +			goto out;
> +		}
> +
>  		spin_lock_init(&vblk->vqs[i].lock);
>  		vblk->vqs[i].vq = vqs[i];
>  	}
> @@ -1253,7 +1268,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>  	u16 min_io_size;
>  	u8 physical_block_exp, alignment_offset;
>  	size_t max_dma_size;
> -	int err;
> +	int err, i;
>  
>  	/* We need to know how many segments before we allocate. */
>  	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
> @@ -1267,6 +1282,23 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> +	/*
> +	 * virtblk_add_req() uses separate outgoing and incoming header
> +	 * descriptors (out_hdr and in_hdr), consuming 2 extra descriptors
> +	 * per request in addition to the data segments.
> +	 *
> +	 * Per virtio specification (2.7.5.3.1), a driver MUST NOT create a
> +	 * descriptor chain longer than the Queue Size of the device.
> +	 *
> +	 * Clamp max_segments to (ring_size - 2) across all virtqueues so
> +	 * that a request never exceeds the ring size of any queue.
> +	 */
> +	for (i = 0; i < vblk->num_vqs; i++) {
> +		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[i].vq);
> +
> +		sg_elems = min_t(u32, sg_elems, ring_size - 2);
> +	}
> +
>  	/* We can handle whatever the host told us to handle. */
>  	lim->max_segments = sg_elems;
>  
> @@ -1466,6 +1498,7 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	mutex_init(&vblk->vdev_mutex);
>  
>  	vblk->vdev = vdev;
> +	vblk->disk = NULL;
>  
>  	INIT_WORK(&vblk->config_work, virtblk_config_changed_work);
>  
> -- 
> 2.55.0.1082.g2b9226bbc0-goog

