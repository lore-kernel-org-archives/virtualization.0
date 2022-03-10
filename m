Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FFC433F5
	for <virtualization@archiver.kernel.org>; Thu, 10 Mar 2022 07:00:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C20860FB9;
	Thu, 10 Mar 2022 07:00:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MZdy5fqz4AVX; Thu, 10 Mar 2022 07:00:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9B79760FB0;
	Thu, 10 Mar 2022 07:00:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65D63C001D;
	Thu, 10 Mar 2022 07:00:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BA82C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA8CD8432B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:00:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZzAizaqF5iSQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:00:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 11F508431C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Mar 2022 07:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646895648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LkMQorCMU7xc93uPK5gJZgn4oA7Bb7VUOpIFgodhLkk=;
 b=Y5HfUX+g8XcOPc95Yl+vYg3fQC4JDRx5uYuLS0evCwbO9Ln8j8CTEYwEBcxp0bLqiJkUr7
 bsGN7wj3SL7IAxRYGnRcISouPBBH471SnuNUA2+3tw0TvkPD+7CfCDfcTRwDd52bSl3Jbk
 /gGQjVyfv/8EUAkxzbOcSEVOapS3by0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-pVpyEPRHOhqUqGG9J4TVEg-1; Thu, 10 Mar 2022 02:00:47 -0500
X-MC-Unique: pVpyEPRHOhqUqGG9J4TVEg-1
Received: by mail-wm1-f71.google.com with SMTP id
 d8-20020a05600c34c800b0037e3cd6225eso1742926wmq.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Mar 2022 23:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LkMQorCMU7xc93uPK5gJZgn4oA7Bb7VUOpIFgodhLkk=;
 b=xuTR+XsDNDXgT8K4wsAVyprxzD1RFUgq2iLSalUFxMt6APNTSOVG0QR7zQeeaNS19w
 77IsojIIv5Nubj4UXFmTWCBLd0XUQJkNlK6Wm/K2g/4LOryVgTydjprN1KQ60Kj56QRY
 +KRv1luARJldXsnM4MvViBpM0kHpUxzu8ZuNm7S5MXPHCPYPcjWZaPgxUo4rRcr72Abp
 fY2Z/Z+R3YHEzchpvwN3w29OGj0Rw1T1FPw/d3ONXxGFYKC0rzVY2kvaHkRV0P6jE1Oq
 UQ0OCSgP6PSFFC8D6TcC2wCXpHtJVok5Gd32PnytOocUGtkPxvSQdcP8ocjX8ckTanUM
 4VEQ==
X-Gm-Message-State: AOAM530XZF0f8jzVan26N7BcisSUFCiVmpB57uSfwysk3lJw/3t6gGCg
 VFhweCeLYNIYnzCs7YSFkrljDdEuP9jwOjWNDLpGbyIRZByDyoG0bPkSQ7ZXQcltxLV/7URrCAN
 IWiR2bxxkYhtZtFNdx2malFbPmASSgyt1Uw1uUOgQoQ==
X-Received: by 2002:a05:6000:1104:b0:1f9:7df6:c864 with SMTP id
 z4-20020a056000110400b001f97df6c864mr2313856wrw.63.1646895645810; 
 Wed, 09 Mar 2022 23:00:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsDaUfg1Dzks5kcvSZTIGN65fjx4oj0qZwLxHiAr1eXZpgoIX0Ngv/xjK7eBdLbtD4hrdZUQ==
X-Received: by 2002:a05:6000:1104:b0:1f9:7df6:c864 with SMTP id
 z4-20020a056000110400b001f97df6c864mr2313828wrw.63.1646895645533; 
 Wed, 09 Mar 2022 23:00:45 -0800 (PST)
Received: from redhat.com ([2.55.24.184]) by smtp.gmail.com with ESMTPSA id
 o7-20020a5d6707000000b001f067c7b47fsm5312811wru.27.2022.03.09.23.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Mar 2022 23:00:44 -0800 (PST)
Date: Thu, 10 Mar 2022 02:00:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Message-ID: <20220310015418-mutt-send-email-mst@kernel.org>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 platform-driver-x86@vger.kernel.org, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Tue, Mar 08, 2022 at 08:35:01PM +0800, Xuan Zhuo wrote:
> virtio ring supports reset.
> 
> Queue reset is divided into several stages.
> 
> 1. notify device queue reset
> 2. vring release
> 3. attach new vring
> 4. notify device queue re-enable
> 
> After the first step is completed, the vring reset operation can be
> performed. If the newly set vring num does not change, then just reset
> the vq related value.
> 
> Otherwise, the vring will be released and the vring will be reallocated.
> And the vring will be attached to the vq. If this process fails, the
> function will exit, and the state of the vq will be the vring release
> state. You can call this function again to reallocate the vring.
> 
> In addition, vring_align, may_reduce_num are necessary for reallocating
> vring, so they are retained when creating vq.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index e0422c04c903..148fb1fd3d5a 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -158,6 +158,12 @@ struct vring_virtqueue {
>  			/* DMA address and size information */
>  			dma_addr_t queue_dma_addr;
>  			size_t queue_size_in_bytes;
> +
> +			/* The parameters for creating vrings are reserved for
> +			 * creating new vrings when enabling reset queue.
> +			 */
> +			u32 vring_align;
> +			bool may_reduce_num;
>  		} split;
>  
>  		/* Available for packed ring */
> @@ -217,6 +223,12 @@ struct vring_virtqueue {
>  #endif
>  };
>  
> +static void vring_free(struct virtqueue *vq);
> +static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
> +					 struct virtio_device *vdev);
> +static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
> +					  struct virtio_device *vdev,
> +					  struct vring vring);
>  
>  /*
>   * Helpers.
> @@ -1012,6 +1024,8 @@ static struct virtqueue *vring_create_virtqueue_split(
>  		return NULL;
>  	}
>  
> +	to_vvq(vq)->split.vring_align = vring_align;
> +	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
>  	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
>  	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
>  	to_vvq(vq)->we_own_ring = true;
> @@ -1019,6 +1033,59 @@ static struct virtqueue *vring_create_virtqueue_split(
>  	return vq;
>  }
>  
> +static int virtqueue_reset_vring_split(struct virtqueue *_vq, u32 num)
> +{
> +	struct vring_virtqueue *vq = to_vvq(_vq);
> +	struct virtio_device *vdev = _vq->vdev;
> +	struct vring_split vring;
> +	int err;
> +
> +	if (num > _vq->num_max)
> +		return -E2BIG;
> +
> +	switch (vq->vq.reset) {
> +	case VIRTIO_VQ_RESET_STEP_NONE:
> +		return -ENOENT;
> +
> +	case VIRTIO_VQ_RESET_STEP_VRING_ATTACH:
> +	case VIRTIO_VQ_RESET_STEP_DEVICE:
> +		if (vq->split.vring.num == num || !num)
> +			break;
> +
> +		vring_free(_vq);
> +
> +		fallthrough;
> +
> +	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
> +		if (!num)
> +			num = vq->split.vring.num;
> +
> +		err = vring_create_vring_split(&vring, vdev,
> +					       vq->split.vring_align,
> +					       vq->weak_barriers,
> +					       vq->split.may_reduce_num, num);
> +		if (err)
> +			return -ENOMEM;
> +
> +		err = __vring_virtqueue_attach_split(vq, vdev, vring.vring);
> +		if (err) {
> +			vring_free_queue(vdev, vring.queue_size_in_bytes,
> +					 vring.queue,
> +					 vring.dma_addr);
> +			return -ENOMEM;
> +		}
> +
> +		vq->split.queue_dma_addr = vring.dma_addr;
> +		vq->split.queue_size_in_bytes = vring.queue_size_in_bytes;
> +	}
> +
> +	__vring_virtqueue_init_split(vq, vdev);
> +	vq->we_own_ring = true;
> +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
> +
> +	return 0;
> +}
> +

I kind of dislike this state machine.

Hacks like special-casing num = 0 to mean "reset" are especially
confusing.

And as Jason points out, when we want a resize then yes this currently
implies reset but that is an implementation detail.

There should be a way to just make these cases separate functions
and then use them to compose consistent external APIs.

If we additionally want to track state for debugging then bool flags
seem more appropriate for this, though from experience that is
not always worth the extra code.



>  /*
>   * Packed ring specific functions - *_packed().
> @@ -2317,6 +2384,8 @@ static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
>  static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
>  					 struct virtio_device *vdev)
>  {
> +	vq->vq.reset = VIRTIO_VQ_RESET_STEP_NONE;
> +
>  	vq->packed_ring = false;
>  	vq->we_own_ring = false;
>  	vq->broken = false;
> -- 
> 2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
