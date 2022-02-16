Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFA8C433F5
	for <virtualization@archiver.kernel.org>; Wed, 16 Feb 2022 04:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98F4760BE3;
	Wed, 16 Feb 2022 04:14:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lURqXHjBSnR5; Wed, 16 Feb 2022 04:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3FD0860BD9;
	Wed, 16 Feb 2022 04:14:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 185F0C001A;
	Wed, 16 Feb 2022 04:14:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C3BC4C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A170141632
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N34tjicLLALj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCC1E4162F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Feb 2022 04:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644984889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DC/9cJ1rnmLdF2qNbTho1YXwyhPBz3aGkzgrZwTS3o8=;
 b=LtT+3sDk4/Oj+gzceW/n74VtyYRCdI4G35xjbbbou7W8C2gKa6lJ34gsft3nH32nauIQOX
 V9sfpHWqF9y3w39annhV0R+7lAn5tFwCcSlVrgr6FWvvJGQ+xA+Ox9WSmskzm5Q+YSdLAo
 FBhuTruNEkC+uXv59m24HCXgVc0JwzU=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-KNbnxgu8MNuYLwEot5TeSA-1; Tue, 15 Feb 2022 23:14:48 -0500
X-MC-Unique: KNbnxgu8MNuYLwEot5TeSA-1
Received: by mail-lj1-f198.google.com with SMTP id
 e16-20020a2ea550000000b00246029bd00bso435554ljn.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Feb 2022 20:14:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=DC/9cJ1rnmLdF2qNbTho1YXwyhPBz3aGkzgrZwTS3o8=;
 b=urauNsEGXhqNP9b53ZEBig8Q0tcRedlafBQ/Xl7VQ6I/5vl4eK/DbDR0Lou6R5JxSJ
 sje1/qhrApkuQ+ov9J86zRLMqHw4+VBdVFb3Vaf02e8IgwoGjj1WviFtghr0RA8kDfKs
 3pvzchNYgRd3GkJxUEIcYP2EVs3e3zDuvE3dQaANsPv4tVVzz6BF8gs7PFWJjrPTQOeZ
 kskO6iawfUEfVlHhWWxBBlVnn8nGderEPFjvcDUfotKoVR9bM2qlSSpemg3GWzScTthY
 lDKbiQlALtfnrsvQuxld/9PfT8QYdRBcfeN6ltVowyL+W/XV9NWVsNMlnyKjqvgQ8V0y
 29Gw==
X-Gm-Message-State: AOAM530u0n6A5jn1VoF8sUJnEYCim1MJxhck5BRjfVspNZYbyzy1d/dC
 CT1BFROFFIOdj6cNefs2nB7fLm8+J4ac6n3VjUyiJkaxfYSHXq3nAIgcr0sbYGlINIQXBf05Jl1
 VCTuQkzAuoNFnUvnVh3dQrMEhgV0D9iQBsYs06syt4tZFPyOwo1IUNA+Hyw==
X-Received: by 2002:a2e:b748:0:b0:245:fcd6:c4a3 with SMTP id
 k8-20020a2eb748000000b00245fcd6c4a3mr697752ljo.362.1644984887135; 
 Tue, 15 Feb 2022 20:14:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgeUs3QA39CjiR99ZEeCfiGPEBhNSb5QEYePt31lVdV4ggOPIjPfM5qmPh3/hI8KyMESfuk+OJIcQQZtdXga4=
X-Received: by 2002:a2e:b748:0:b0:245:fcd6:c4a3 with SMTP id
 k8-20020a2eb748000000b00245fcd6c4a3mr697738ljo.362.1644984886923; Tue, 15 Feb
 2022 20:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
 <20220214081416.117695-9-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220214081416.117695-9-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 12:14:36 +0800
Message-ID: <CACGkMEttDpjYZcsT7Eh0Nm50R27nTBOLDFwBaSKsJ+OL1x26vg@mail.gmail.com>
Subject: Re: [PATCH v5 08/22] virtio_ring: queue_reset: add
 vring_release_virtqueue()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Mon, Feb 14, 2022 at 4:14 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Added vring_release_virtqueue() to release the ring of the vq.
>
> In this process, vq is removed from the vdev->vqs queue. And the memory
> of the ring is released
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 18 +++++++++++++++++-
>  include/linux/virtio.h       | 12 ++++++++++++
>  2 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index c5dd17c7dd4a..b37753bdbbc4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1730,6 +1730,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
>         vq->vq.vdev = vdev;
>         vq->vq.num_free = num;
>         vq->vq.index = index;
> +       vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;

So we don't have a similar check for detach_unused_buf(), I guess it
should be sufficient to document the API requirement. Otherwise we
probably need some barriers/ordering which are not worthwhile just for
figuring out bad API usage.

>         vq->we_own_ring = true;
>         vq->notify = notify;
>         vq->weak_barriers = weak_barriers;
> @@ -2218,6 +2219,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
>         vq->vq.vdev = vdev;
>         vq->vq.num_free = vring.num;
>         vq->vq.index = index;
> +       vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;
>         vq->we_own_ring = false;
>         vq->notify = notify;
>         vq->weak_barriers = weak_barriers;
> @@ -2397,11 +2399,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
>  {
>         struct vring_virtqueue *vq = to_vvq(_vq);
>
> -       __vring_del_virtqueue(vq);
> +       if (_vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
> +               __vring_del_virtqueue(vq);
>         kfree(vq);
>  }
>  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
>
> +void vring_release_virtqueue(struct virtqueue *_vq)
> +{

If we agree on that we need a allocation routine, we probably need to
rename this as vring_free_virtqueue()

Thanks

> +       struct vring_virtqueue *vq = to_vvq(_vq);
> +
> +       if (_vq->reset != VIRTQUEUE_RESET_STAGE_DEVICE)
> +               return;
> +
> +       __vring_del_virtqueue(vq);
> +
> +       _vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
> +}
> +EXPORT_SYMBOL_GPL(vring_release_virtqueue);
> +
>  /* Manipulates transport-specific feature bits. */
>  void vring_transport_features(struct virtio_device *vdev)
>  {
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index 72292a62cd90..cdb2a551257c 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -10,6 +10,12 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/gfp.h>
>
> +enum virtqueue_reset_stage {
> +       VIRTQUEUE_RESET_STAGE_NONE,
> +       VIRTQUEUE_RESET_STAGE_DEVICE,
> +       VIRTQUEUE_RESET_STAGE_RELEASE,
> +};
> +
>  /**
>   * virtqueue - a queue to register buffers for sending or receiving.
>   * @list: the chain of virtqueues for this device
> @@ -32,6 +38,7 @@ struct virtqueue {
>         unsigned int index;
>         unsigned int num_free;
>         void *priv;
> +       enum virtqueue_reset_stage reset;
>  };
>
>  int virtqueue_add_outbuf(struct virtqueue *vq,
> @@ -196,4 +203,9 @@ void unregister_virtio_driver(struct virtio_driver *drv);
>  #define module_virtio_driver(__virtio_driver) \
>         module_driver(__virtio_driver, register_virtio_driver, \
>                         unregister_virtio_driver)
> +/*
> + * Resets a virtqueue. Just frees the ring, not free vq.
> + * This function must be called after reset_vq().
> + */
> +void vring_release_virtqueue(struct virtqueue *vq);
>  #endif /* _LINUX_VIRTIO_H */
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
