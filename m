Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334CBE6F
	for <virtualization@lists.linux.dev>; Thu, 10 Oct 2024 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548843; cv=none; b=bcRqRkMi3OugdivTO19K9yAAan/CHdyMzJS5UhwcVX0Ujs/VPQyCTUwVim8Vg8dUyam1xm6ZxcFMfqxf40Ri5N1fCcNLSn/LFmVv0upsBAJB/pOmfCrNG/KncTfZn7pfRHjj5pOko2Uiga0td3+fw4mA9MEAIgn3Pe4hPFFO02I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548843; c=relaxed/simple;
	bh=nDVa7RVh92aEfQ/hZHOHzlUnbGa4NOkJY4JkRjXz/p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=LphwxF79KDGr1Avk9cqIJJOuCNF32PoSci2GC4x8lKridfD/qTankaPWDDVhccGEekERqgz6mDJmIasj33+CqqgUdsr5lDx4Yr2Ec10i6szRtWgdUtkoAQeMWC5x0W2Iu7qB95s3ub3j26zm02sor2WIdQckMFydMV8BzExMjE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hv6IgA1P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hv6IgA1P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728548840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1/PgTzn0LaEAcE+t+4UnDSYLRSLO4dLOSvdtip/laKw=;
	b=Hv6IgA1P1jVBTSW1Lbl8RYzhyF6PeH9HJmkcGCnG/D4LndZu18Fjiwepeiv6ylOeLIVtvw
	CPgCxkrNhuQorG0hRtKfK0UulXImxmzLweGYD7294//lbcwZCz391yENFvxMFWC8tIUKXS
	r+dGSpFmKdhvSn+sslH/umgQY1Jm5NQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Z48BkXhkP62rcmDy7m-xcg-1; Thu, 10 Oct 2024 04:27:18 -0400
X-MC-Unique: Z48BkXhkP62rcmDy7m-xcg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a99482f029aso43585966b.3
        for <virtualization@lists.linux.dev>; Thu, 10 Oct 2024 01:27:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548837; x=1729153637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/PgTzn0LaEAcE+t+4UnDSYLRSLO4dLOSvdtip/laKw=;
        b=hBC9Di3cW54ySva/98L8Ok9zo0Um3ZGQN0lHTRIRstg3UrtNvUeoSVGHq8PMH5+kqN
         InWQx7hR1fi0L3DK+2+nw8/mkC43MOURtQuOsnqJXFUn+isZdQemYraXbyOT20MzmnDx
         99dgw6nIQcFoyHnoS2e7YtMTi7+0LZXWPD2xsCKguHRLDGwd5UJnF7+/1QvSBASl4YgP
         6/m9IgfoQ/GcwfFZgg7UXjfSIj1pOQtd0axqOVaumovVj3KPVxXR5pOsiVwqldj1zqlE
         EKAoJNJ0Z9cRhxPZjKCdR7qQ7sFKkgmCb9M16hpxZOXEiCplQiDjtvApZirnifib4Z0p
         Prww==
X-Forwarded-Encrypted: i=1; AJvYcCW3C5Pp9sV5iqnj6zgDwtKuN66O/FV426G7cnCKNhmbqnlEPvF85xiajTQqpKUvhOoG3SrzprRFvjzNLkswbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9YPJAu+uYCRzpMdRGVXo+WQ7FZU9F1ZrgOdFG3NR2U3hVpVtA
	N3HYpXci+PouMxbyNxfpViqPbpeoj6QoGnuuEq635y2eYCUP4lhCNvvItpBmkiBlxoMgEO8esTn
	bUtfxtwMMZm7KGNalO8PcScZcRx20hf8m8B2DxoYV7ZAhT+api4pkdE5OCL7dXo94
X-Received: by 2002:a17:907:c7e1:b0:a99:4261:e9f7 with SMTP id a640c23a62f3a-a998d25a375mr477018766b.39.1728548837475;
        Thu, 10 Oct 2024 01:27:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUAKw07MJzvThy4yjEVaeeNoz8gaZmYN9Xo/rYhqiuJGDAgJMZyjNwf1vEiSU9VxndGS0pYg==
X-Received: by 2002:a17:907:c7e1:b0:a99:4261:e9f7 with SMTP id a640c23a62f3a-a998d25a375mr477014566b.39.1728548836626;
        Thu, 10 Oct 2024 01:27:16 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80efea4sm54026266b.199.2024.10.10.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:27:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 10:27:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: huangwenyu1998@gmail.com
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio: Make vring_new_virtqueue support for packed
 vring
Message-ID: <jx3pztqixn3fv7ujoxczjgbldtndrwqxzh5eqvpxrbwmw3ljsy@2jtxip4ycewa>
References: <20241009153430.90318-1-huangwenyu1998@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241009153430.90318-1-huangwenyu1998@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Oct 09, 2024 at 11:34:30PM GMT, huangwenyu1998@gmail.com wrote:
>From: Wenyu Huang <huangwenyu1998@gmail.com>
>
>It used for testing in tools/virtio/vringh_test.c.
>If vring_new_virtqueue supports packed vring, we can add support for
>packed vring to vringh and test it.

Are you also working on that changes?

>
>Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
>---
>Changes in v2: Make the commit title and description more clearer.
>Changes in v3: Remove the declaration of __vring_new_virtqueue_split and
>			   __vring_new_virtqueue_packed and move the definition of
>			   these two functions.
> drivers/virtio/virtio_ring.c | 228 +++++++++++++++++++----------------
> 1 file changed, 121 insertions(+), 107 deletions(-)

Some checkpatch warnings/errors to fix:

$ ./scripts/checkpatch.pl -g master..HEAD --codespell
ERROR: trailing whitespace
#307: FILE: drivers/virtio/virtio_ring.c:2862:
+^Istruct vring_virtqueue_split vring_split = {};^I$

WARNING: Missing a blank line after declarations
#313: FILE: drivers/virtio/virtio_ring.c:2866:
+		struct vring_virtqueue_packed vring_packed = {};
+		vring_packed.vring.num = num;

total: 1 errors, 1 warnings, 300 lines checked

Apart from these issues, the rest LGTM.

Thanks,
Stefano

>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index be7309b1e860..91fbfdef2be8 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -223,15 +223,6 @@ struct vring_virtqueue {
> #endif
> };
>
>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>-					       struct vring_virtqueue_split *vring_split,
>-					       struct virtio_device *vdev,
>-					       bool weak_barriers,
>-					       bool context,
>-					       bool (*notify)(struct virtqueue *),
>-					       void (*callback)(struct virtqueue *),
>-					       const char *name,
>-					       struct device *dma_dev);
> static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> static void vring_free(struct virtqueue *_vq);
>
>@@ -1138,6 +1129,66 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
> 	return 0;
> }
>
>+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
>+					       struct vring_virtqueue_split *vring_split,
>+					       struct virtio_device *vdev,
>+					       bool weak_barriers,
>+					       bool context,
>+					       bool (*notify)(struct virtqueue *),
>+					       void (*callback)(struct virtqueue *),
>+					       const char *name,
>+					       struct device *dma_dev)
>+{
>+	struct vring_virtqueue *vq;
>+	int err;
>+
>+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>+	if (!vq)
>+		return NULL;
>+
>+	vq->packed_ring = false;
>+	vq->vq.callback = callback;
>+	vq->vq.vdev = vdev;
>+	vq->vq.name = name;
>+	vq->vq.index = index;
>+	vq->vq.reset = false;
>+	vq->we_own_ring = false;
>+	vq->notify = notify;
>+	vq->weak_barriers = weak_barriers;
>+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>+	vq->broken = true;
>+#else
>+	vq->broken = false;
>+#endif
>+	vq->dma_dev = dma_dev;
>+	vq->use_dma_api = vring_use_dma_api(vdev);
>+	vq->premapped = false;
>+	vq->do_unmap = vq->use_dma_api;
>+
>+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>+		!context;
>+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>+
>+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>+		vq->weak_barriers = false;
>+
>+	err = vring_alloc_state_extra_split(vring_split);
>+	if (err) {
>+		kfree(vq);
>+		return NULL;
>+	}
>+
>+	virtqueue_vring_init_split(vring_split, vq);
>+
>+	virtqueue_init(vq, vring_split->vring.num);
>+	virtqueue_vring_attach_split(vq, vring_split);
>+
>+	spin_lock(&vdev->vqs_list_lock);
>+	list_add_tail(&vq->vq.list, &vdev->vqs);
>+	spin_unlock(&vdev->vqs_list_lock);
>+	return &vq->vq;
>+}
>+
> static struct virtqueue *vring_create_virtqueue_split(
> 	unsigned int index,
> 	unsigned int num,
>@@ -1160,7 +1211,7 @@ static struct virtqueue *vring_create_virtqueue_split(
> 	if (err)
> 		return NULL;
>
>-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
>+	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> 				   context, notify, callback, name, dma_dev);
> 	if (!vq) {
> 		vring_free_split(&vring_split, vdev, dma_dev);
>@@ -2050,36 +2101,29 @@ static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
> 	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
> }
>
>-static struct virtqueue *vring_create_virtqueue_packed(
>-	unsigned int index,
>-	unsigned int num,
>-	unsigned int vring_align,
>-	struct virtio_device *vdev,
>-	bool weak_barriers,
>-	bool may_reduce_num,
>-	bool context,
>-	bool (*notify)(struct virtqueue *),
>-	void (*callback)(struct virtqueue *),
>-	const char *name,
>-	struct device *dma_dev)
>+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>+					       struct vring_virtqueue_packed *vring_packed,
>+					       struct virtio_device *vdev,
>+					       bool weak_barriers,
>+					       bool context,
>+					       bool (*notify)(struct virtqueue *),
>+					       void (*callback)(struct virtqueue *),
>+					       const char *name,
>+					       struct device *dma_dev)
> {
>-	struct vring_virtqueue_packed vring_packed = {};
> 	struct vring_virtqueue *vq;
> 	int err;
>
>-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
>-		goto err_ring;
>-
> 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> 	if (!vq)
>-		goto err_vq;
>+		return NULL;
>
> 	vq->vq.callback = callback;
> 	vq->vq.vdev = vdev;
> 	vq->vq.name = name;
> 	vq->vq.index = index;
> 	vq->vq.reset = false;
>-	vq->we_own_ring = true;
>+	vq->we_own_ring = false;
> 	vq->notify = notify;
> 	vq->weak_barriers = weak_barriers;
> #ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>@@ -2100,26 +2144,52 @@ static struct virtqueue *vring_create_virtqueue_packed(
> 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
> 		vq->weak_barriers = false;
>
>-	err = vring_alloc_state_extra_packed(&vring_packed);
>-	if (err)
>-		goto err_state_extra;
>+	err = vring_alloc_state_extra_packed(vring_packed);
>+	if (err) {
>+		kfree(vq);
>+		return NULL;
>+	}
>
>-	virtqueue_vring_init_packed(&vring_packed, !!callback);
>+	virtqueue_vring_init_packed(vring_packed, !!callback);
>
>-	virtqueue_init(vq, num);
>-	virtqueue_vring_attach_packed(vq, &vring_packed);
>+	virtqueue_init(vq, vring_packed->vring.num);
>+	virtqueue_vring_attach_packed(vq, vring_packed);
>
> 	spin_lock(&vdev->vqs_list_lock);
> 	list_add_tail(&vq->vq.list, &vdev->vqs);
> 	spin_unlock(&vdev->vqs_list_lock);
> 	return &vq->vq;
>+}
>
>-err_state_extra:
>-	kfree(vq);
>-err_vq:
>-	vring_free_packed(&vring_packed, vdev, dma_dev);
>-err_ring:
>-	return NULL;
>+static struct virtqueue *vring_create_virtqueue_packed(
>+	unsigned int index,
>+	unsigned int num,
>+	unsigned int vring_align,
>+	struct virtio_device *vdev,
>+	bool weak_barriers,
>+	bool may_reduce_num,
>+	bool context,
>+	bool (*notify)(struct virtqueue *),
>+	void (*callback)(struct virtqueue *),
>+	const char *name,
>+	struct device *dma_dev)
>+{
>+	struct vring_virtqueue_packed vring_packed = {};
>+	struct virtqueue *vq;
>+
>+	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
>+		return NULL;
>+
>+	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
>+					context, notify, callback, name, dma_dev);
>+	if (!vq) {
>+		vring_free_packed(&vring_packed, vdev, dma_dev);
>+		return NULL;
>+	}
>+
>+	to_vvq(vq)->we_own_ring = true;
>+
>+	return vq;
> }
>
> static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>@@ -2598,69 +2668,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> }
> EXPORT_SYMBOL_GPL(vring_interrupt);
>
>-/* Only available for split ring */
>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>-					       struct vring_virtqueue_split *vring_split,
>-					       struct virtio_device *vdev,
>-					       bool weak_barriers,
>-					       bool context,
>-					       bool (*notify)(struct virtqueue *),
>-					       void (*callback)(struct virtqueue *),
>-					       const char *name,
>-					       struct device *dma_dev)
>-{
>-	struct vring_virtqueue *vq;
>-	int err;
>-
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>-
>-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>-	if (!vq)
>-		return NULL;
>-
>-	vq->packed_ring = false;
>-	vq->vq.callback = callback;
>-	vq->vq.vdev = vdev;
>-	vq->vq.name = name;
>-	vq->vq.index = index;
>-	vq->vq.reset = false;
>-	vq->we_own_ring = false;
>-	vq->notify = notify;
>-	vq->weak_barriers = weak_barriers;
>-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>-	vq->broken = true;
>-#else
>-	vq->broken = false;
>-#endif
>-	vq->dma_dev = dma_dev;
>-	vq->use_dma_api = vring_use_dma_api(vdev);
>-	vq->premapped = false;
>-	vq->do_unmap = vq->use_dma_api;
>
>-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>-		!context;
>-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>-
>-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>-		vq->weak_barriers = false;
>-
>-	err = vring_alloc_state_extra_split(vring_split);
>-	if (err) {
>-		kfree(vq);
>-		return NULL;
>-	}
>-
>-	virtqueue_vring_init_split(vring_split, vq);
>-
>-	virtqueue_init(vq, vring_split->vring.num);
>-	virtqueue_vring_attach_split(vq, vring_split);
>-
>-	spin_lock(&vdev->vqs_list_lock);
>-	list_add_tail(&vq->vq.list, &vdev->vqs);
>-	spin_unlock(&vdev->vqs_list_lock);
>-	return &vq->vq;
>-}
>
> struct virtqueue *vring_create_virtqueue(
> 	unsigned int index,
>@@ -2840,7 +2848,6 @@ int virtqueue_reset(struct virtqueue *_vq,
> }
> EXPORT_SYMBOL_GPL(virtqueue_reset);
>
>-/* Only available for split ring */
> struct virtqueue *vring_new_virtqueue(unsigned int index,
> 				      unsigned int num,
> 				      unsigned int vring_align,
>@@ -2852,13 +2859,20 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
> 				      void (*callback)(struct virtqueue *vq),
> 				      const char *name)
> {
>-	struct vring_virtqueue_split vring_split = {};
>+	struct vring_virtqueue_split vring_split = {};	
>
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
>+		struct vring_virtqueue_packed vring_packed = {};
>+		vring_packed.vring.num = num;
>+		vring_packed.vring.desc = pages;
>+		return __vring_new_virtqueue_packed(index, &vring_packed,
>+						    vdev, weak_barriers,
>+						    context, notify, callback,
>+						    name, vdev->dev.parent);
>+	}
>
> 	vring_init(&vring_split.vring, num, pages, vring_align);
>-	return __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
>+	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> 				     context, notify, callback, name,
> 				     vdev->dev.parent);
> }
>-- 
>2.43.0
>

