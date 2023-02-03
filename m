Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3225C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 18E21429E7;
	Fri,  3 Feb 2023 09:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 18E21429E7
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QyIvnLVZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wUgYv8OVN7t; Fri,  3 Feb 2023 09:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98758429D6;
	Fri,  3 Feb 2023 09:05:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98758429D6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64C16C0032;
	Fri,  3 Feb 2023 09:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D57EBC002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFE80611C0
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFE80611C0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QyIvnLVZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bHnf2CNcveFU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:05:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D812460E84
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D812460E84
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675415149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N9HoyxJH33BYSUp+w3oKvRgLGuA+ZhszcCRdBlbExCI=;
 b=QyIvnLVZWQTYT02QPV17UK/RssdVoUsJOC2mCKLrxPvuy2iLWsyX6mbIB9TfjtLUi+4L0X
 ZdCrj7SYwvAXf/pFNhSpq4ubch9+W1tWIk4k6UE4sKwlhaslqmHMgObxpUI5mR0dWZ/Fv3
 cFHoB67uPOlXFuVqICPloSwhhUXH3SY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-j994IbZqM4myq49galMKLA-1; Fri, 03 Feb 2023 04:05:44 -0500
X-MC-Unique: j994IbZqM4myq49galMKLA-1
Received: by mail-ed1-f70.google.com with SMTP id
 n17-20020a056402061100b004a3f32cc366so3184619edv.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9HoyxJH33BYSUp+w3oKvRgLGuA+ZhszcCRdBlbExCI=;
 b=gmM25838AblVTo8gvflhgP6kUtKaMwqxrgUx5jVbUxRNS+MCoTYeEk3ayDVx9gHjXK
 K16Mnp9OXpdYsXYMO3MDDJENP//JCPXjenBIKG40vjWXxR/FcJJlCHNzATCmYo3gk7bG
 wpwjvc9U+KgcEdYF+0H9FMVUJKmaduCFU0ltdGzrAU9jMjgaDNf36GcafN+McYRanY3l
 WYjW87Cuz2ve0Gdw4zKNjC+O+j05Pr8rAfgEx9nktoPl976P28Od5mJPp9C0cFRkyHX8
 r2WBOWFDgk2mgQ91ONOzTJceV0hFJLCaxdjzDkCjQ+VYc5SSobIs+A+mtFpNoaOi2h08
 iC0g==
X-Gm-Message-State: AO0yUKX1i6zMYCdp6EtkKum6mLR2/GlA2Lvo86mUys3AildlLJzvnw2r
 +CwtTR/aecuzFRWTBHB6xh1kHWtTiRlwDwBp2LC7MmYIMH8PYC4DyAlZ8jXhveDzNmWVPrlK2jG
 rUCF6JzJoMcky7USU1bn3GI0ES9ne+DvIjAHjvpoooQ==
X-Received: by 2002:a17:906:8a5b:b0:7c0:efb9:bc0e with SMTP id
 gx27-20020a1709068a5b00b007c0efb9bc0emr9548693ejc.62.1675415143627; 
 Fri, 03 Feb 2023 01:05:43 -0800 (PST)
X-Google-Smtp-Source: AK7set/70jo8DZJ8ImD+MKXLnZRXs73Nase6/1PLq5yOJq+Ilm4UroMODDIeCGdgHw1DC8iEQ8H+WA==
X-Received: by 2002:a17:906:8a5b:b0:7c0:efb9:bc0e with SMTP id
 gx27-20020a1709068a5b00b007c0efb9bc0emr9548668ejc.62.1675415143456; 
 Fri, 03 Feb 2023 01:05:43 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 s25-20020a170906285900b008867f1905f2sm1076527ejc.39.2023.02.03.01.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:05:42 -0800 (PST)
Date: Fri, 3 Feb 2023 04:05:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 06/33] virtio_ring: introduce virtqueue_reset()
Message-ID: <20230203040041-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-7-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-7-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Thu, Feb 02, 2023 at 07:00:31PM +0800, Xuan Zhuo wrote:
> Introduce virtqueue_reset() to release all buffer inside vq.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++++++++++++
>  include/linux/virtio.h       |  2 ++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e32046fd15a5..7dfce7001f9f 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2735,6 +2735,56 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
>  }
>  EXPORT_SYMBOL_GPL(virtqueue_resize);
>  
> +/**
> + * virtqueue_reset - reset the vring of vq

..., detach and recycle all unused buffers

	after all this is why we are doing this reset, right?

> + * @_vq: the struct virtqueue we're talking about.
> + * @recycle: callback for recycle the useless buffer

not useless :) unused:

	callback to recycle unused buffers

I know we have the same confusion in virtqueue_resize, I will fix
that.

> + *
> + * Caller must ensure we don't call this with other virtqueue operations
> + * at the same time (except where noted).
> + *
> + * Returns zero or a negative error.
> + * 0: success.
> + * -EBUSY: Failed to sync with device, vq may not work properly
> + * -ENOENT: Transport or device not supported
> + * -EPERM: Operation not permitted
> + */
> +int virtqueue_reset(struct virtqueue *_vq,
> +		    void (*recycle)(struct virtqueue *vq, void *buf))
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = vq->vq.vdev;
> +	void *buf;
> +	int err;
> +
> +	if (!vq->we_own_ring)
> +		return -EPERM;
> +
> +	if (!vdev->config->disable_vq_and_reset)
> +		return -ENOENT;
> +
> +	if (!vdev->config->enable_vq_after_reset)
> +		return -ENOENT;
> +
> +	err = vdev->config->disable_vq_and_reset(_vq);
> +	if (err)
> +		return err;
> +
> +	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
> +		recycle(_vq, buf);
> +
> +	if (vq->packed_ring)
> +		virtqueue_reinit_packed(vq);
> +	else
> +		virtqueue_reinit_split(vq);
> +
> +	if (vdev->config->enable_vq_after_reset(_vq))
> +		return -EBUSY;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_reset);
> +
>  /* Only available for split ring */
>  struct virtqueue *vring_new_virtqueue(unsigned int index,
>  				      unsigned int num,
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 3ebb346ebb7c..3ca2edb1aef3 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -105,6 +105,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
>  
>  int virtqueue_resize(struct virtqueue *vq, u32 num,
>  		     void (*recycle)(struct virtqueue *vq, void *buf));
> +int virtqueue_reset(struct virtqueue *vq,
> +		    void (*recycle)(struct virtqueue *vq, void *buf));
>  
>  /**
>   * struct virtio_device - representation of a device using virtio
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
