Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53799C7619A
	for <virtualization@archiver.kernel.org>; Sat,  8 Apr 2023 06:37:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B9355420F5;
	Sat,  8 Apr 2023 06:37:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B9355420F5
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSQzBI2d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id modEs5T18fnp; Sat,  8 Apr 2023 06:37:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9054042092;
	Sat,  8 Apr 2023 06:37:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9054042092
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 606B0C0037;
	Sat,  8 Apr 2023 06:37:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F3BAC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 06:37:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62A4784601
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 06:37:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62A4784601
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cSQzBI2d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6UdehNbijqh
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 06:37:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C00EC845FE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C00EC845FE
 for <virtualization@lists.linux-foundation.org>;
 Sat,  8 Apr 2023 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680935864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uLbvCzrYyWJ4Cauc3NPpnqlpzEGzzAiyEy8g6jX+TGo=;
 b=cSQzBI2dObtA4eik19fOwQWUmuBP6vKyz+GF4bD8MiGAqJQ56iJlDQ3DBgKccrdJ8C7q6t
 UwrxqViJzPE+cgNjpE8+LdpAnkFSYMH6GpWItX3Pmbv6feEoaeCYqzs46NNgIx7JAydqOX
 R465CNK7JbgRBcoNpi7hqMeo9UYl1wY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-c_y_qEo0NxC11FhGt-XFvg-1; Sat, 08 Apr 2023 02:37:43 -0400
X-MC-Unique: c_y_qEo0NxC11FhGt-XFvg-1
Received: by mail-wm1-f71.google.com with SMTP id
 n9-20020a05600c4f8900b003ee21220fccso233973wmq.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 07 Apr 2023 23:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680935862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLbvCzrYyWJ4Cauc3NPpnqlpzEGzzAiyEy8g6jX+TGo=;
 b=Bj3ffm9qdTmxaNiUPMrvTH8TOduDAdM3SEnfUcBrxLqGeLrEFY2ld+gcFKcaebTQ5p
 LBAH8QT6osLP5buadM4TPbaRQQP7bopijX8DNBYpcO6N3t9woq4n1pxXRtxYK9nsmTiW
 E22H98MJwNtAdn+GYHkoCCl5244Qd3ZlDvrbrK0BZYMNCuCxZxc9rAgHvvAjiApBwFKK
 NEriohD44vpwHtX+EuGvH0uhmlJPQeZwlp40X8OgPYluor6BcKyDp7j5a4rI/Tt/W8f8
 y2qvOlnWJJwEmjUM+i6ipnkiMRAZatDVlnu3oIqIipUf4Wp/en5J80p6l2sNnHghYwrt
 yeAw==
X-Gm-Message-State: AAQBX9eNSN5tDHzXZUL1U1XsF7avzuO7sOBIahGboe14tqQHAqk+tclA
 UPAovWYrDISK0eqbop1MhSz0qnRvgG6UiesTIRo1yJV4DPaNxVrgAninuYK8emFjSlI2XjNubDx
 OKr35PTiDZA+yWWb2XlJbizcnZreIyEzMBEMnaiH8oA==
X-Received: by 2002:a5d:4304:0:b0:2ef:b8ae:8791 with SMTP id
 h4-20020a5d4304000000b002efb8ae8791mr887704wrq.10.1680935862313; 
 Fri, 07 Apr 2023 23:37:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350auZ+DyjvsiHrrEQ1j44eoMZdb3oVVMF4qUh1LqP7D5b0yW5K3yTbkC+l6CocxuC4/g/8900g==
X-Received: by 2002:a5d:4304:0:b0:2ef:b8ae:8791 with SMTP id
 h4-20020a5d4304000000b002efb8ae8791mr887695wrq.10.1680935861993; 
 Fri, 07 Apr 2023 23:37:41 -0700 (PDT)
Received: from redhat.com ([2.52.20.155]) by smtp.gmail.com with ESMTPSA id
 d1-20020a5d6441000000b002c573778432sm6187411wrw.102.2023.04.07.23.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Apr 2023 23:37:41 -0700 (PDT)
Date: Sat, 8 Apr 2023 02:37:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
Message-ID: <20230408023544-mutt-send-email-mst@kernel.org>
References: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
In-Reply-To: <20230402081034.1021886-1-alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: eperezma@redhat.com, viktor@daynix.com,
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

On Sun, Apr 02, 2023 at 11:10:34AM +0300, Alvaro Karsz wrote:
> Add VIRTIO_F_NOTIFICATION_DATA support for vDPA transport.
> If this feature is negotiated, the driver passes extra data when kicking
> a virtqueue.
> 
> A device that offers this feature needs to implement the
> kick_vq_with_data callback.
> 
> kick_vq_with_data receives the vDPA device and data.
> data includes the vqn, next_off and next_wrap for packed virtqueues.
> 
> This patch follows a patch [1] by Viktor Prutyanov which adds support
> for the MMIO, channel I/O and modern PCI transports.
> 
> This patch needs to be applied on top of Viktor's patch.
> 
> [1] https://lore.kernel.org/lkml/20230324195029.2410503-1-viktor@daynix.com/
> 
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Hmm so I conclude that drivers without kick_vq_with_data
should not accept VIRTIO_F_NOTIFICATION_DATA then?


> ---
>  drivers/virtio/virtio_vdpa.c | 20 ++++++++++++++++++--
>  include/linux/vdpa.h         |  6 ++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index d7f5af62dda..bdaf30f7fbf 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -112,6 +112,17 @@ static bool virtio_vdpa_notify(struct virtqueue *vq)
>  	return true;
>  }
>  
> +static bool virtio_vdpa_notify_with_data(struct virtqueue *vq)
> +{
> +	struct vdpa_device *vdpa = vd_get_vdpa(vq->vdev);
> +	const struct vdpa_config_ops *ops = vdpa->config;
> +	u32 data = vring_notification_data(vq);
> +
> +	ops->kick_vq_with_data(vdpa, data);
> +
> +	return true;
> +}
> +
>  static irqreturn_t virtio_vdpa_config_cb(void *private)
>  {
>  	struct virtio_vdpa_device *vd_dev = private;
> @@ -138,6 +149,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	struct device *dma_dev;
>  	const struct vdpa_config_ops *ops = vdpa->config;
>  	struct virtio_vdpa_vq_info *info;
> +	bool (*notify)(struct virtqueue *vq);
>  	struct vdpa_callback cb;
>  	struct virtqueue *vq;
>  	u64 desc_addr, driver_addr, device_addr;
> @@ -154,6 +166,11 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  	if (index >= vdpa->nvqs)
>  		return ERR_PTR(-ENOENT);
>  
> +	if (__virtio_test_bit(vdev, VIRTIO_F_NOTIFICATION_DATA))
> +		notify = virtio_vdpa_notify_with_data;
> +	else
> +		notify = virtio_vdpa_notify;
> +
>  	/* Queue shouldn't already be set up. */
>  	if (ops->get_vq_ready(vdpa, index))
>  		return ERR_PTR(-ENOENT);
> @@ -183,8 +200,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>  		dma_dev = vdpa_get_dma_dev(vdpa);
>  	vq = vring_create_virtqueue_dma(index, max_num, align, vdev,
>  					true, may_reduce_num, ctx,
> -					virtio_vdpa_notify, callback,
> -					name, dma_dev);
> +					notify, callback, name, dma_dev);
>  	if (!vq) {
>  		err = -ENOMEM;
>  		goto error_new_virtqueue;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 43f59ef10cc..a83bb0501c5 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -143,6 +143,11 @@ struct vdpa_map_file {
>   * @kick_vq:			Kick the virtqueue
>   *				@vdev: vdpa device
>   *				@idx: virtqueue index
> + * @kick_vq_with_data:		Kick the virtqueue and supply extra data
> + *				(only if VIRTIO_F_NOTIFICATION_DATA is negotiated)
> + *				@vdev: vdpa device
> + *				@data: includes vqn, next_off and next_wrap for
> + *				packed virtqueues
>   * @set_vq_cb:			Set the interrupt callback function for
>   *				a virtqueue
>   *				@vdev: vdpa device
> @@ -300,6 +305,7 @@ struct vdpa_config_ops {
>  			      u64 device_area);
>  	void (*set_vq_num)(struct vdpa_device *vdev, u16 idx, u32 num);
>  	void (*kick_vq)(struct vdpa_device *vdev, u16 idx);
> +	void (*kick_vq_with_data)(struct vdpa_device *vdev, u32 data);
>  	void (*set_vq_cb)(struct vdpa_device *vdev, u16 idx,
>  			  struct vdpa_callback *cb);
>  	void (*set_vq_ready)(struct vdpa_device *vdev, u16 idx, bool ready);
> -- 
> 2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
