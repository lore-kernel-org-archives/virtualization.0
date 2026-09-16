Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F883659FD
	for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570838; cv=none; b=oR7T+AVM5/2vxIGfQJuAQjwPqmr2E2V4UwugEWAN2SyaTlPVltw8N/8DmSh9HpjxxQuPTVBB4tkqdCj9ckeV9u5i31xE+daUE74WXDSVPJAU2J10DBvrkKMZByT/ncOCEyK8CvFLD41bwe3fG0q6CWaWOqRbMBB+pBvvWQSLJKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570838; c=relaxed/simple;
	bh=9tI4U4sigauxv7+vSOHtv7WRiUpJF6qwzNnTtt4QssI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=TBVnzSRJWZXBk96qz3DlRsOZS5kshf9ZAz8g01QoBbZPWnySG/wncIop1ShBiiLFd2BN5mddVn4Q2wT9gR/JQrk9MdFVn1uuyS8oSFCw8v7MLTbVTdL3dGVmm3bj6WCxmbf8gZ129HGn5dls4Ufa1VJsG85PTO2yCpyxPudYB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQCEET+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQCEET+q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789570834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vErMH5Jpyy8oa53cLRlOD7zEIY+iQEIFyTm7guhxWj0=;
	b=ZQCEET+qbgkBmkcylL7Eq7e6j8OYyfNIfg4jLq8Y3eb7FStd3tuMmXMUBHTU5jrDFtSRYL
	GYiSFoL19cy+ogw3G9wja76dzeJVjG0GH39YFs2t5M0WwkUlcjY9Xc+OreUb2qRZTzmj37
	mBBh8VuMwFn++yFtSSrK7zjYJDY8acU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212--k6Etf35OyyihCQM2qO2ew-1; Wed, 16 Sep 2026 11:00:30 -0400
X-MC-Unique: -k6Etf35OyyihCQM2qO2ew-1
X-Mimecast-MFC-AGG-ID: -k6Etf35OyyihCQM2qO2ew_1789570829
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2967165d94so309429066b.3
        for <virtualization@lists.linux.dev>; Wed, 16 Sep 2026 08:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570829; x=1790175629;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vErMH5Jpyy8oa53cLRlOD7zEIY+iQEIFyTm7guhxWj0=;
        b=l504c+PquwbeD11s/pIvjg8Jj3kNh/BZhTDfgkLAj0/nTHVcMSWwgM1JmFzn4ts94s
         pklO+KQENO7HH6X4LKGVKJBjpCCVkzg056+F3O6yV9JngnZq1HuUzzo4wqljcvRQEKOr
         uXy1I71JFey0wycdfiFtEX14nw2lLXxJ+O+gDruIssNx7rIgVVH2ooEnRCxm4/2hvF6i
         PR6jdsM+dCBoBnioO64HZyuCfNptLMDV48mONNsmIP3uvaJH78IV8TPd5/zOfT0PDtc/
         tSpnfNsRYlDRHteBIPMKxueH8h79MdubXlgNERM8upHZ8jmNTdBj8UU5enEXV7+l7E31
         iP7A==
X-Gm-Message-State: AFuF++li7/IFHHk859bax+08vH3FARbx+DG4mwm17IbuEMXTZ1aXgAGC
	XGjEB/Yq0AfQpuWsnbn3kes8hoqlxMbz8Yea2hXo9zwSV+37eRUpyELY/nHIOqocTnMr+HnrAbW
	C/A/RP8UCKvTzfShykJedWrQz0pZy7udfGh2ZbVJ9ITl51mlqoxz4a7DyReSgzjEj9mHU
X-Gm-Gg: AYBFou3wKTmgVA14L24Wrl7SlduAhQU8A7HsofTL9w+fC5fw+o5RLMdwGfhF/M1KYSw
	3pVmAXRHl2tj8qS6Li6pHnCz7WidBfxWnlyeBm6/3d2sL1pBESn7CUClQKoIxx4qS7h++xHk24P
	Bo/U4IzznQcoSMc2O7nmmaE4naBkReiJpTvdenS0lnfiWswWjFNX8gCo1LG+b+iwp4+GKrspddP
	uCkmxUijs9h0znAIdq67/b1ex+uqP+JVq02KVqsYvscesedyKesWOM1+Wl0nnhIhcbintGTPVas
	yBvMwDjB5dn0n/PhYEzudo9NWEvyD/XNkEnA4NxcOT+/ctVocRIONfpJ5yLruHTnrtdMMJxRqeD
	VYj1zIfzVwOF8gIkqF13unPI=
X-Received: by 2002:a17:907:7287:b0:c26:19de:912c with SMTP id a640c23a62f3a-c29e530a4c5mr215296966b.31.1789570829140;
        Wed, 16 Sep 2026 08:00:29 -0700 (PDT)
X-Received: by 2002:a17:907:7287:b0:c26:19de:912c with SMTP id a640c23a62f3a-c29e530a4c5mr215291666b.31.1789570828446;
        Wed, 16 Sep 2026 08:00:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de4893aasm153542566b.30.2026.09.16.08.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 08:00:27 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:00:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sergii Ushakov <sergiiushakov@google.com>
Cc: virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	Jason Wang <jasowangio@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] virtio-blk: clamp max_segments when indirect
 descriptors are disabled
Message-ID: <20260916104218-mutt-send-email-mst@kernel.org>
References: <20260814105954.4060627-1-sergiiushakov@google.com>
 <20260817134202.160669-1-sergiiushakov@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260817134202.160669-1-sergiiushakov@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q_HhgZuMAD9-buUgMAht3QXC4Ci4NxZQ9UgUBn-6Vaw_1789570829
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2026 at 03:42:02PM +0200, Sergii Ushakov wrote:
> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
> 
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS (1024). When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
> 
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).
> 
> Automatically clamp sg_elems to (ring_size - 2) when indirect
> descriptors are disabled.
> 
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> v1 -> v2:
> - Drop max_segments module parameter and rely solely on automatic clamping
>   when indirect descriptors are disabled (suggested by Christoph Hellwig).
> - Guard (ring_size - 2) calculation with ring_size > 2 to prevent underflow.
> - Update commit description accordingly.
> 
>  drivers/block/virtio_blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..8f5a2d5323a6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1267,6 +1267,13 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> +	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> +		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[0].vq);
> +
> +		if (ring_size > 2)
> +			sg_elems = min(sg_elems, ring_size - 2);
> +	}
> +
>  	/* We can handle whatever the host told us to handle. */
>  	lim->max_segments = sg_elems;


I do not get why it does not clamp with VIRTIO_RING_F_INDIRECT_DESC.
Spec says:

 A driver MUST NOT create a descriptor chain longer than the Queue Size of the device.

Also, pls add a comment explaining where does this 2 come from.

What about ring size 2? I guess



> When VIRTIO_RING_F_INDIRECT_DESC is not negotiated by the host, every
> scatter-gather segment in a request must consume a physical slot in
> the virtqueue ring.
> 
> If the host does not advertise VIRTIO_BLK_F_SEG_MAX and provides a small
> virtqueue (e.g. 128 descriptors on QNX Hypervisor), the block layer
> defaults max_segments to BLK_MAX_SEGMENTS

Does it?

        err = virtio_cread_feature(vdev, VIRTIO_BLK_F_SEG_MAX,
                                   struct virtio_blk_config, seg_max,
                                   &sg_elems);
                 
        /* We need at least one SG element, whatever they say. */
        if (err || !sg_elems)
                sg_elems = 1;

so set to 1 without VIRTIO_BLK_F_SEG_MAX


        /* Prevent integer overflows and honor max vq size */
        sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);

unchanged here

        /* We can handle whatever the host told us to handle. */
        lim->max_segments = sg_elems;

assigned to max_segments here


> BLK_MAX_SEGMENTS (1024).

In which tree does BLK_MAX_SEGMENTS equal 1024?

git show next-20260915:include/linux/blkdev.h | grep -n 'BLK_MAX_SEGMENTS'
1234:      BLK_MAX_SEGMENTS        = 128,




> When a multi-page
> compound bio arrives from the page cache, virtqueue_add_split() rejects
> the request with -ENOSPC and triggers:
> 
>   WARNING: at drivers/virtio/virtio_ring.c:1493 virtqueue_add+...
>   WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
> 
> This permanently wedges the blk-mq queue and blocks all subsequent disk
> I/O in uninterruptible sleep (D state).

Please clarify the reproducer, including the negotiated features,
max_segments, actual ring sizes, and total_sg at the failure. As
described, it should not trigger and I do not see how
the patch is supposed to change the failing configuration.

> 
> Automatically clamp sg_elems to (ring_size - 2) when indirect
> descriptors are disabled.
> 
> Signed-off-by: Sergii Ushakov <sergiiushakov@google.com>
> ---
> v1 -> v2:
> - Drop max_segments module parameter and rely solely on automatic clamping
>   when indirect descriptors are disabled (suggested by Christoph Hellwig).
> - Guard (ring_size - 2) calculation with ring_size > 2 to prevent underflow.
> - Update commit description accordingly.
> 
>  drivers/block/virtio_blk.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 32bf3ba07a9d..8f5a2d5323a6 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1267,6 +1267,13 @@ static int virtblk_read_limits(struct virtio_blk *vblk,

Well we only set the limit at probe. virtblk_restore_priv() recreates
the queues on resume and reset recovery, then resumes dispatch without
checking their sizes against the existing limit. ring allocation
can reduce the size under memory pressure, including during recovery.

Since you are now (correctly) tying request size to vq size,
this needs to be resolved.



>  	/* Prevent integer overflows and honor max vq size */
>  	sg_elems = min_t(u32, sg_elems, VIRTIO_BLK_MAX_SG_ELEMS - 2);
>  
> +	if (!virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC)) {

Why exempt indirect descriptors? The virtio spec says:

	A driver MUST NOT create a descriptor chain longer than the Queue Size
	of the device.

Even on devices ignoring that -
there is a failure path even when indirect descriptors are
negotiated: virtqueue_add_split() falls back to direct descriptors if
the indirect-table allocation fails. So if the request exceeds the ring
size, it returns -ENOSPC even on an empty ring. virtio_queue_rq() then
stops the hardware queue, with no outstanding completion to restart it.


> +		u32 ring_size = virtqueue_get_vring_size(vblk->vqs[0].vq);

Why 0? VQ 0 is not necessarily the smallest queue. The transport specifies
sizes per queue, and Linux can reduce individual split-ring sizes
during allocation.

> +
> +		if (ring_size > 2)
> +			sg_elems = min(sg_elems, ring_size - 2);

The subtraction is correct: virtblk_add_req() uses separate outgoing
and incoming header descriptors, including for zone append.
However, we really should have a comment explaining that, here.

And, ring_size <= 2 must be rejected rather than bypassing the clamp:
A two-entry direct ring can pass probe, yet even one data segment
needs three descriptors and hits the same permanent -ENOSPC condition.

> +	}
> +
>  	/* We can handle whatever the host told us to handle. */
>  	lim->max_segments = sg_elems;
>  
> -- 
> 2.55.0.691.gc56d675ccc-goog
> 

>  
> -- 
> 2.55.0.691.gc56d675ccc-goog

