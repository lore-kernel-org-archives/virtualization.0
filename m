Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3588C433FE
	for <virtualization@archiver.kernel.org>; Fri, 25 Mar 2022 10:33:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A076605E9;
	Fri, 25 Mar 2022 10:33:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DurFtD7ADTDK; Fri, 25 Mar 2022 10:33:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DADE16064D;
	Fri, 25 Mar 2022 10:33:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD43C002C;
	Fri, 25 Mar 2022 10:33:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A66A1C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 10:33:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8FEC2402B7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 10:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmocZVbNpwCr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 10:33:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7516B402AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 10:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1648204405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uUkF2L/ieU8/dzFOpFu8lTNQvyxa9XxA5O5e3jJszN0=;
 b=TIp3lCfOAi8r98U6vro7uMJc3vYgNjb8mbbKXSK8tK66GJ1MiA7oVItDlKizMOZ50pDWrq
 sNDbMRx/IXPnKcFvlHpHqAr3smvKch/izizwAzsJa7kU4uZ4RAU2XjYtIKBqd3AjafEfoe
 KNHkyFosh4N4Jqz4ow1wV7u7GizQzqk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-uzg-Yv-pN4a9GF8q4d8Ggg-1; Fri, 25 Mar 2022 06:33:24 -0400
X-MC-Unique: uzg-Yv-pN4a9GF8q4d8Ggg-1
Received: by mail-wr1-f70.google.com with SMTP id
 d17-20020adfc3d1000000b00203e2ff73a6so2564616wrg.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Mar 2022 03:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uUkF2L/ieU8/dzFOpFu8lTNQvyxa9XxA5O5e3jJszN0=;
 b=7vE7vNCbeczRGdqk4kMis0D7RIa7vciM8x15reSTtwi35R7FPzl4JwHtW/sm6Yn4do
 6lF+GN6whNk1zDkFQ9i5h0g5knh1swtTqjl5t/Wz1zvtbUn5Eb9lY9Zes6QRINEGkLig
 Z8Nypv//bq2ZorSXZrZkV7Nva99sYQK7ZnBMTehULvhZjpDlnnuwvCGrIvVzFMfkjqth
 QIgA/YMPWNR+MvwRym8rnYLrD0eB7z2qIDlExS50ew/A6hLivTHktF2lEM1denIy1bBE
 3RBGjJp9e/NEmCB2n3KzLKKBqIqhFcq29BkJRg1+G8xtn+pjVKq4+/xpcYM+YL4hjPo4
 twEQ==
X-Gm-Message-State: AOAM531r5Nd352F9FR2Qh3k4NLPPm6vOSUSHfeKES9cIDqj83MUij3Cl
 QztOFE7pMwynyefSK+1EYJI0aCO3v2SCJYazF78jKl0Y6cNfbJhdgfTytth8K3V2iX98Oj+NoJJ
 xrcT10kYxBisjIQikeWokzjKjI4dc+ohjzFW/LLOWDQ==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id
 p17-20020a5d48d1000000b001e32401f229mr8396532wrs.694.1648204402770; 
 Fri, 25 Mar 2022 03:33:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcr+hav6KOUBCXghNZg1FrDhtBVWF0I8TXIf9p93emm+/dTVZGzc7hZ6TaGgy8VJ781o6LdQ==
X-Received: by 2002:a5d:48d1:0:b0:1e3:2401:f229 with SMTP id
 p17-20020a5d48d1000000b001e32401f229mr8396514wrs.694.1648204402483; 
 Fri, 25 Mar 2022 03:33:22 -0700 (PDT)
Received: from redhat.com ([2.55.151.118]) by smtp.gmail.com with ESMTPSA id
 m11-20020adff38b000000b002058f767c58sm4681896wro.30.2022.03.25.03.33.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Mar 2022 03:33:21 -0700 (PDT)
Date: Fri, 25 Mar 2022 06:33:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
Message-ID: <20220325062719-mutt-send-email-mst@kernel.org>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

On Mon, Mar 14, 2022 at 05:34:55PM +0800, Xuan Zhuo wrote:
> Introduce virtqueue_resize() to implement the resize of vring.
> Based on these, the driver can dynamically adjust the size of the vring.
> For example: ethtool -G.
> 
> virtqueue_resize() implements resize based on the vq reset function. In
> case of failure to allocate a new vring, it will give up resize and use
> the original vring.
> 
> During this process, if the re-enable reset vq fails, the vq can no
> longer be used. Although the probability of this situation is not high.
> 
> The parameter recycle is used to recycle the buffer that is no longer
> used.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 67 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  3 ++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fb0abf9a2f57..b1dde086a8a4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2528,6 +2528,73 @@ struct virtqueue *vring_create_virtqueue(
>  }
>  EXPORT_SYMBOL_GPL(vring_create_virtqueue);
>  
> +/**
> + * virtqueue_resize - resize the vring of vq
> + * @vq: the struct virtqueue we're talking about.
> + * @num: new ring num
> + * @recycle: callback for recycle the useless buffer
> + *
> + * When it is really necessary to create a new vring, it will set the current vq
> + * into the reset state. Then call the passed cb to recycle the buffer that is
> + * no longer used. Only after the new vring is successfully created, the old
> + * vring will be released.
> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * -ENOMEM: create new vring fail. But vq can still work
> + * -EBUSY:  reset/re-enable vq fail. vq may cannot work
> + * -ENOENT: not support resize
> + * -E2BIG/-EINVAL: param num error
> + */
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	struct virtio_device *vdev = vq->vdev;
> +	void *buf;
> +	int err;
> +
> +	if (num > vq->num_max)
> +		return -E2BIG;
> +
> +	if (!num)
> +		return -EINVAL;
> +
> +	if (to_vvq(vq)->packed.vring.num == num)
> +		return 0;
> +
> +	if (!vq->vdev->config->reset_vq)
> +		return -ENOENT;
> +
> +	if (!vq->vdev->config->enable_reset_vq)
> +		return -ENOENT;
> +
> +	err = vq->vdev->config->reset_vq(vq);
> +	if (err) {
> +		if (err != -ENOENT)
> +			err = -EBUSY;
> +		return err;
> +	}
> +
> +	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> +		recycle(vq, buf);


So all this callback can do now is drop all buffers, and I think that is
not great.  Can we store them and invoke the callback after queue is
enabled?


> +
> +	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
> +		err = virtqueue_resize_packed(vq, num);
> +	else
> +		err = virtqueue_resize_split(vq, num);
> +
> +	if (err)
> +		err = -ENOMEM;
> +
> +	if (vq->vdev->config->enable_reset_vq(vq))
> +		return -EBUSY;
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_resize);
> +
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d59adc4be068..c86ff02e0ca0 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -91,6 +91,9 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
>  dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
>  dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>  
> +int virtqueue_resize(struct virtqueue *vq, u32 num,
> +		     void (*recycle)(struct virtqueue *vq, void *buf));
> +
>  /**
>   * virtio_device - representation of a device using virtio
>   * @index: unique position on the virtio bus
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
