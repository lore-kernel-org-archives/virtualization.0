Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CE31D2B0F
	for <virtualization@lists.linux.dev>; Mon,  7 Oct 2024 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305100; cv=none; b=t20ewC99AV/8QnVovBDLlWVB+KmgkWLjR+Imq/zzZK04XYWPKFPwYsfFVNxzmY9TG70bQVDdk0UN7JpELkfM997BtmFGO4J21rEnXfX0rOp/KpY3u+9Qk13w0eEDmZJGNh4L/6VZ7yNjPMRJrmI68+CXqX8QVYNhAVqnMhlMkho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305100; c=relaxed/simple;
	bh=Jgv2iZYEQb+BiQdUaGmFz6ejNiuNYY5pzo9vAft8A0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JM9ukq5MVXtC2YuWdYatCcmlmkY1UOMqBw3FZI/VfJL1/utOVYfrmFdfnjRNfs6hP+FvBHYUF2/2r7mu3VTM55avZwQ/5YE8MRljc4gDYQfoXPMahcWpcu5y2yUt2mzKU8Hn99ImCgCCoRKlRO6bsgZryeLzFndHAdS5uqTDbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZQjBTe29; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQjBTe29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728305097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtZfgDxivEv1/YdNfUXkg0QDnikWSQOwdP6FggffpxU=;
	b=ZQjBTe29Rb4UpVats+swRH1P1Cz7wGKQOHyguJb6v86D58Op/eiV/uW0xxBlG9a1OIdtZi
	E2dXafa2SEUJKgbxNgvWfSWUPT+bUr7cVyG+OB4S/mJXB5Uv/So01AP8tx4r5lMd2AN5G0
	obWWtctcdiv1jjYWd4XuWKY0jGYNrw0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-fent1PDbOe2Iy7ZYbbgQaw-1; Mon, 07 Oct 2024 08:44:56 -0400
X-MC-Unique: fent1PDbOe2Iy7ZYbbgQaw-1
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e1159fb161fso5985782276.1
        for <virtualization@lists.linux.dev>; Mon, 07 Oct 2024 05:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728305096; x=1728909896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtZfgDxivEv1/YdNfUXkg0QDnikWSQOwdP6FggffpxU=;
        b=KZ8Au1qTzu4O3N0ZiQWqEm9PBAfBu5usgvYsbIWhlO1aMvozmMZt3/UPQjHa9jI0uJ
         jtzpsVhaA+R5Ohli5xFRfkR08KSgiQSOy2+e5eTL1J+QNW02vtPHE0Q5vTZLp4Q/UnGA
         5pOy5KTlUj3CJ3UFGqGtgKYpV0RXlriUcS/RwN2vu4pPwx9R75isdI8SCT43NPQRzplu
         A3xN9GZc6JYn/tV3l/xS+5vcP9qWj42CqqxfVvzpWzKsoDB7Mfa4UDsbdaI7cLSvpi8b
         CyrtSr0jz7CX5+Qs8n9zRRWPcGdzPqnPCgLzNTC5wPzVCL736qzjtdEn4e4lZZV0PBbz
         CDag==
X-Forwarded-Encrypted: i=1; AJvYcCWhQYlGk47lngAM+Oa2yApmx7ChT0yjPg5EACivtUQ4d3VAFA8M9a76eyQBNtVZ/sb5gz/wlcmfRwyoKCfmKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDdEIUa6gAk759fOkctDvSJoiweKys6p0yTqoQb5fCk3DAlbIH
	OvzBRDzXHZzb06iFVbeMsnajwjKmdJhbQYdI0rk310Zm/5WExaLUBhSY2mFJmKLJ5jcA21etdpm
	ts+bnPhGbpJNgRBiBeJDO5IGUKn4MAJhQvEobmXx54Oy6s/CoO6RnXQgEmtXAm8jf
X-Received: by 2002:a05:6902:1a4a:b0:e20:291e:7fe1 with SMTP id 3f1490d57ef6-e28936ea426mr8147348276.25.1728305095526;
        Mon, 07 Oct 2024 05:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6mQAQf/zIqjG3RCCUakXz0p/7iRxTyP/szvwCZ6Kw9sRidl4bf5wmRc2+LONqZ2vT7PHh2A==
X-Received: by 2002:a05:6902:1a4a:b0:e20:291e:7fe1 with SMTP id 3f1490d57ef6-e28936ea426mr8147328276.25.1728305094931;
        Mon, 07 Oct 2024 05:44:54 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cba46dfc37sm25328336d6.48.2024.10.07.05.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:44:54 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:44:46 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: huangwenyu1998@gmail.com
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Make vring_new_virtqueue support for packed
 vring
Message-ID: <ejvroia6dxwc57bfk5nqray2aibonwwxwin7lbuhttl374qisl@bvweusdurfqk>
References: <20241005074201.52727-1-huangwenyu1998@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241005074201.52727-1-huangwenyu1998@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Oct 05, 2024 at 03:42:01PM GMT, huangwenyu1998@gmail.com wrote:
>From: Wenyu Huang <huangwenyu1998@gmail.com>
>
>It used for testing in tools/virtio/vringh_test.c.
>If vring_new_virtqueue supports packed vring, we can add support for
>packed vring to vringh and test it.
>
>Signed-off-by: Wenyu Huang <huangwenyu1998@gmail.com>
>---
>Changes in v2: Make the commit title and description more clearer.
> drivers/virtio/virtio_ring.c | 153 +++++++++++++++++++++--------------
> 1 file changed, 92 insertions(+), 61 deletions(-)
>
>diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
>index be7309b1e860..664a0c40ee05 100644
>--- a/drivers/virtio/virtio_ring.c
>+++ b/drivers/virtio/virtio_ring.c
>@@ -223,7 +223,7 @@ struct vring_virtqueue {
> #endif
> };
>
>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> 					       struct vring_virtqueue_split *vring_split,
> 					       struct virtio_device *vdev,
> 					       bool weak_barriers,
>@@ -232,6 +232,15 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> 					       void (*callback)(struct virtqueue *),
> 					       const char *name,
> 					       struct device *dma_dev);
>+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>+					       struct vring_virtqueue_packed *vring_packed,
>+					       struct virtio_device *vdev,
>+					       bool weak_barriers,
>+					       bool context,
>+					       bool (*notify)(struct virtqueue *),
>+					       void (*callback)(struct virtqueue *),
>+					       const char *name,
>+					       struct device *dma_dev);
> static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
> static void vring_free(struct virtqueue *_vq);
>
>@@ -1160,7 +1169,7 @@ static struct virtqueue *vring_create_virtqueue_split(
> 	if (err)
> 		return NULL;
>
>-	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
>+	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
> 				   context, notify, callback, name, dma_dev);
> 	if (!vq) {
> 		vring_free_split(&vring_split, vdev, dma_dev);
>@@ -2064,62 +2073,21 @@ static struct virtqueue *vring_create_virtqueue_packed(
> 	struct device *dma_dev)
> {
> 	struct vring_virtqueue_packed vring_packed = {};
>-	struct vring_virtqueue *vq;
>-	int err;
>+	struct virtqueue *vq;
>
> 	if (vring_alloc_queue_packed(&vring_packed, vdev, num, dma_dev))
>-		goto err_ring;
>-
>-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
>-	if (!vq)
>-		goto err_vq;
>-
>-	vq->vq.callback = callback;
>-	vq->vq.vdev = vdev;
>-	vq->vq.name = name;
>-	vq->vq.index = index;
>-	vq->vq.reset = false;
>-	vq->we_own_ring = true;
>-	vq->notify = notify;
>-	vq->weak_barriers = weak_barriers;
>-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
>-	vq->broken = true;
>-#else
>-	vq->broken = false;
>-#endif
>-	vq->packed_ring = true;
>-	vq->dma_dev = dma_dev;
>-	vq->use_dma_api = vring_use_dma_api(vdev);
>-	vq->premapped = false;
>-	vq->do_unmap = vq->use_dma_api;
>-
>-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
>-		!context;
>-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
>-
>-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
>-		vq->weak_barriers = false;
>-
>-	err = vring_alloc_state_extra_packed(&vring_packed);
>-	if (err)
>-		goto err_state_extra;
>-
>-	virtqueue_vring_init_packed(&vring_packed, !!callback);
>+		return NULL;
>
>-	virtqueue_init(vq, num);
>-	virtqueue_vring_attach_packed(vq, &vring_packed);
>+	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
>+					context, notify, callback, name, dma_dev);
>+	if (!vq) {
>+		vring_free_packed(&vring_packed, vdev, dma_dev);
>+		return NULL;
>+	}
>
>-	spin_lock(&vdev->vqs_list_lock);
>-	list_add_tail(&vq->vq.list, &vdev->vqs);
>-	spin_unlock(&vdev->vqs_list_lock);
>-	return &vq->vq;
>+	to_vvq(vq)->we_own_ring = true;
>
>-err_state_extra:
>-	kfree(vq);
>-err_vq:
>-	vring_free_packed(&vring_packed, vdev, dma_dev);
>-err_ring:
>-	return NULL;
>+	return vq;
> }
>
> static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
>@@ -2599,7 +2567,7 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> EXPORT_SYMBOL_GPL(vring_interrupt);
>
> /* Only available for split ring */
      ^
This comment is not needed anymore.

>-static struct virtqueue *__vring_new_virtqueue(unsigned int index,
>+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
> 					       struct vring_virtqueue_split *vring_split,
> 					       struct virtio_device *vdev,
> 					       bool weak_barriers,
>@@ -2612,9 +2580,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> 	struct vring_virtqueue *vq;
> 	int err;
>
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>-
> 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
> 	if (!vq)
> 		return NULL;
>@@ -2662,6 +2627,66 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
> 	return &vq->vq;
> }
>
>+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
>+					       struct vring_virtqueue_packed *vring_packed,
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
>+	vq->packed_ring = true;
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
>+	err = vring_alloc_state_extra_packed(vring_packed);
>+	if (err) {
>+		kfree(vq);
>+		return NULL;
>+	}
>+
>+	virtqueue_vring_init_packed(vring_packed, !!callback);
>+
>+	virtqueue_init(vq, vring_packed->vring.num);
>+	virtqueue_vring_attach_packed(vq, vring_packed);
>+
>+	spin_lock(&vdev->vqs_list_lock);
>+	list_add_tail(&vq->vq.list, &vdev->vqs);
>+	spin_unlock(&vdev->vqs_list_lock);
>+	return &vq->vq;
>+}
>+
> struct virtqueue *vring_create_virtqueue(
> 	unsigned int index,
> 	unsigned int num,
>@@ -2840,7 +2865,6 @@ int virtqueue_reset(struct virtqueue *_vq,
> }
> EXPORT_SYMBOL_GPL(virtqueue_reset);
>
>-/* Only available for split ring */
> struct virtqueue *vring_new_virtqueue(unsigned int index,
> 				      unsigned int num,
> 				      unsigned int vring_align,
>@@ -2853,12 +2877,19 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
> 				      const char *name)
> {
> 	struct vring_virtqueue_split vring_split = {};
>+	struct vring_virtqueue_packed vring_packed = {};

nit: we can move this declaration ...

>
>-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
>-		return NULL;
>+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {

... here, since we use it only in this branch.

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

Since it looks like we have 2 sections in virtio_ring.c for split and
packed API, what about moving the 2 new functions?

In this way we can also remove the definition on top of the file, I mean
to apply the following changes to your patch:

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 664a0c40ee05..9f67a98b0914 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -223,24 +223,6 @@ struct vring_virtqueue {
  #endif
  };

-static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev);
-static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
-					       struct vring_virtqueue_packed *vring_packed,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev);
  static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
  static void vring_free(struct virtqueue *_vq);

@@ -1147,6 +1129,66 @@ static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
  	return 0;
  }

+static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
+					       struct vring_virtqueue_split *vring_split,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name,
+					       struct device *dma_dev)
+{
+	struct vring_virtqueue *vq;
+	int err;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	vq->packed_ring = false;
+	vq->vq.callback = callback;
+	vq->vq.vdev = vdev;
+	vq->vq.name = name;
+	vq->vq.index = index;
+	vq->vq.reset = false;
+	vq->we_own_ring = false;
+	vq->notify = notify;
+	vq->weak_barriers = weak_barriers;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	vq->broken = true;
+#else
+	vq->broken = false;
+#endif
+	vq->dma_dev = dma_dev;
+	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->premapped = false;
+	vq->do_unmap = vq->use_dma_api;
+
+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+		!context;
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
+	err = vring_alloc_state_extra_split(vring_split);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	virtqueue_vring_init_split(vring_split, vq);
+
+	virtqueue_init(vq, vring_split->vring.num);
+	virtqueue_vring_attach_split(vq, vring_split);
+
+	spin_lock(&vdev->vqs_list_lock);
+	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
+	return &vq->vq;
+}
+
  static struct virtqueue *vring_create_virtqueue_split(
  	unsigned int index,
  	unsigned int num,
@@ -2059,6 +2101,66 @@ static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
  	virtqueue_vring_init_packed(&vq->packed, !!vq->vq.callback);
  }

+static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
+					       struct vring_virtqueue_packed *vring_packed,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name,
+					       struct device *dma_dev)
+{
+	struct vring_virtqueue *vq;
+	int err;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	vq->vq.callback = callback;
+	vq->vq.vdev = vdev;
+	vq->vq.name = name;
+	vq->vq.index = index;
+	vq->vq.reset = false;
+	vq->we_own_ring = false;
+	vq->notify = notify;
+	vq->weak_barriers = weak_barriers;
+#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
+	vq->broken = true;
+#else
+	vq->broken = false;
+#endif
+	vq->packed_ring = true;
+	vq->dma_dev = dma_dev;
+	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->premapped = false;
+	vq->do_unmap = vq->use_dma_api;
+
+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+		!context;
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
+	err = vring_alloc_state_extra_packed(vring_packed);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	virtqueue_vring_init_packed(vring_packed, !!callback);
+
+	virtqueue_init(vq, vring_packed->vring.num);
+	virtqueue_vring_attach_packed(vq, vring_packed);
+
+	spin_lock(&vdev->vqs_list_lock);
+	list_add_tail(&vq->vq.list, &vdev->vqs);
+	spin_unlock(&vdev->vqs_list_lock);
+	return &vq->vq;
+}
+
  static struct virtqueue *vring_create_virtqueue_packed(
  	unsigned int index,
  	unsigned int num,
@@ -2566,127 +2668,6 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
  }
  EXPORT_SYMBOL_GPL(vring_interrupt);

-/* Only available for split ring */
-static struct virtqueue *__vring_new_virtqueue_split(unsigned int index,
-					       struct vring_virtqueue_split *vring_split,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev)
-{
-	struct vring_virtqueue *vq;
-	int err;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		return NULL;
-
-	vq->packed_ring = false;
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
-	vq->vq.index = index;
-	vq->vq.reset = false;
-	vq->we_own_ring = false;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
-	vq->broken = false;
-#endif
-	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
-
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	err = vring_alloc_state_extra_split(vring_split);
-	if (err) {
-		kfree(vq);
-		return NULL;
-	}
-
-	virtqueue_vring_init_split(vring_split, vq);
-
-	virtqueue_init(vq, vring_split->vring.num);
-	virtqueue_vring_attach_split(vq, vring_split);
-
-	spin_lock(&vdev->vqs_list_lock);
-	list_add_tail(&vq->vq.list, &vdev->vqs);
-	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
-}
-
-static struct virtqueue *__vring_new_virtqueue_packed(unsigned int index,
-					       struct vring_virtqueue_packed *vring_packed,
-					       struct virtio_device *vdev,
-					       bool weak_barriers,
-					       bool context,
-					       bool (*notify)(struct virtqueue *),
-					       void (*callback)(struct virtqueue *),
-					       const char *name,
-					       struct device *dma_dev)
-{
-	struct vring_virtqueue *vq;
-	int err;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		return NULL;
-
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
-	vq->vq.index = index;
-	vq->vq.reset = false;
-	vq->we_own_ring = false;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
-#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
-	vq->broken = true;
-#else
-	vq->broken = false;
-#endif
-	vq->packed_ring = true;
-	vq->dma_dev = dma_dev;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-	vq->premapped = false;
-	vq->do_unmap = vq->use_dma_api;
-
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	err = vring_alloc_state_extra_packed(vring_packed);
-	if (err) {
-		kfree(vq);
-		return NULL;
-	}
-
-	virtqueue_vring_init_packed(vring_packed, !!callback);
-
-	virtqueue_init(vq, vring_packed->vring.num);
-	virtqueue_vring_attach_packed(vq, vring_packed);
-
-	spin_lock(&vdev->vqs_list_lock);
-	list_add_tail(&vq->vq.list, &vdev->vqs);
-	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
-}
-
  struct virtqueue *vring_create_virtqueue(
  	unsigned int index,
  	unsigned int num,


Thanks,
Stefano

