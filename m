Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42850CCA482
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 06:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C0AF68416C;
	Thu, 30 Jun 2022 06:35:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C0AF68416C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxVuz6wJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 286Le-zUahCr; Thu, 30 Jun 2022 06:35:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21D128275C;
	Thu, 30 Jun 2022 06:35:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21D128275C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 068D2C002D;
	Thu, 30 Jun 2022 06:35:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6AA3C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:35:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 739E983F70
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:35:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 739E983F70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lht8zTUKlqPC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:35:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 52F218275C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 52F218275C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 06:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656570953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=njLH7GFfaOXROEX4o3ayXFUqakNk2re9lthQMqB92Q8=;
 b=TxVuz6wJlDPJ6SwZhuBGaruh2de0lB7yjGdSgmY9fvSY7WM+/MSGYQ8g3fr8h7w5SLPQe+
 XIIugHYf5cZVmXKuoLwsMGjSWICI6+OnGFEhcm2V7H/o/B/2d1FIVl7mv704HWrJmBTyop
 K4EB4b/+XlsDcSE66vl50xTsu7RT/G0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-QJkKCbzKOOWw10dGKqX28A-1; Thu, 30 Jun 2022 02:35:52 -0400
X-MC-Unique: QJkKCbzKOOWw10dGKqX28A-1
Received: by mail-lf1-f70.google.com with SMTP id
 p2-20020a05651212c200b004814102d512so1748197lfg.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 23:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=njLH7GFfaOXROEX4o3ayXFUqakNk2re9lthQMqB92Q8=;
 b=SJHltW7DjxSZwg7Cv29knkuowgY91KifFi3w0NvMz0W6W+j3klgF5KWe0SMF5fBql1
 f7DIR56gAaEv+Dn0zJ7sf7ebwuRv0sNcARZkyU20UrJW0ZG/36SY+PV/ITsLUjKNWczt
 KFtROsC40CsL/FqMeEWNhlb48AWGedOBcR97OXaqtcQZppSMV1Qt7b+hPNaJWyr+2PFG
 c6jD3XpcDwo3KuOlNzre1fjzfTmSYqUwu06JKvU3rRC4CKpu8i3ZCeX87wL+epLbzbKR
 C4xyFzKDz25nwxsdDbGUBZGMJ0JmkRtwSzgIyliR550PYcoBHR1H3bXn9I5Y5p17Q/Fy
 LVbA==
X-Gm-Message-State: AJIora9dGhWEYJwqGL9cee0pXPre6qjzfY16YrWtrCKTua7fO9HytOJn
 kekOvZr393ln1lPO6X6XBf1Ss1a1q/TX3ojUMwtZ67dZMRUe4b3FH7ZqDT1LpJUwzptmr6Cygj/
 wyEManpsSRcULejVIzkgQm9JjXZt2WqiMRwWfDOCo/nWvdk+iYY1hkrBWjQ==
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr4745092lfb.397.1656570950074; 
 Wed, 29 Jun 2022 23:35:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tJKVtY+Zl0/40XEr/wn6beDS0TB6Ve6wa1Oo7+BpbGVCUvzB09kLNntuaMrZWqNzwTBjf08mKnZiCH+Ir+mBo=
X-Received: by 2002:a05:6512:158d:b0:47f:718c:28b5 with SMTP id
 bp13-20020a056512158d00b0047f718c28b5mr4745069lfb.397.1656570949818; Wed, 29
 Jun 2022 23:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220629065656.54420-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 30 Jun 2022 14:35:38 +0800
Message-ID: <CACGkMEuWK5i4pyvzN306v2ijstFQQbuspNCcNRJrw0kskvcozg@mail.gmail.com>
Subject: Re: [PATCH v11 01/40] virtio: add helper
 virtqueue_get_vring_max_size()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm <kvm@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev <netdev@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

On Wed, Jun 29, 2022 at 2:57 PM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Record the maximum queue num supported by the device.
>
> virtio-net can display the maximum (supported by hardware) ring size in
> ethtool -g eth0.
>
> When the subsequent patch implements vring reset, it can judge whether
> the ring size passed by the driver is legal based on this.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c             |  1 +
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  2 ++
>  drivers/remoteproc/remoteproc_virtio.c   |  2 ++
>  drivers/s390/virtio/virtio_ccw.c         |  3 +++
>  drivers/virtio/virtio_mmio.c             |  2 ++
>  drivers/virtio/virtio_pci_legacy.c       |  2 ++
>  drivers/virtio/virtio_pci_modern.c       |  2 ++
>  drivers/virtio/virtio_ring.c             | 14 ++++++++++++++
>  drivers/virtio/virtio_vdpa.c             |  2 ++
>  include/linux/virtio.h                   |  2 ++
>  10 files changed, 32 insertions(+)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 82ff3785bf69..e719af8bdf56 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -958,6 +958,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
>                 goto error_create;
>         }
>         vq->priv = info;
> +       vq->num_max = num;
>         num = virtqueue_get_vring_size(vq);
>
>         if (vu_dev->protocol_features &
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 38800e86ed8a..1ae3c56b66b0 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -959,6 +959,8 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
>                         goto error;
>                 }
>
> +               vq->num_max = vring->num;
> +
>                 vqs[i] = vq;
>                 vring->vq = vq;
>                 vq->priv = vring;
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index d43d74733f0a..0f7706e23eb9 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -125,6 +125,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
>                 return ERR_PTR(-ENOMEM);
>         }
>
> +       vq->num_max = num;
> +
>         rvring->vq = vq;
>         vq->priv = rvring;
>
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> index 161d3b141f0d..6b86d0280d6b 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -530,6 +530,9 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
>                 err = -ENOMEM;
>                 goto out_err;
>         }
> +
> +       vq->num_max = info->num;
> +
>         /* it may have been reduced */
>         info->num = virtqueue_get_vring_size(vq);
>
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 083ff1eb743d..a20d5a6b5819 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -403,6 +403,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
>                 goto error_new_virtqueue;
>         }
>
> +       vq->num_max = num;
> +
>         /* Activate the queue */
>         writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
>         if (vm_dev->version == 1) {
> diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
> index a5e5721145c7..2257f1b3d8ae 100644
> --- a/drivers/virtio/virtio_pci_legacy.c
> +++ b/drivers/virtio/virtio_pci_legacy.c
> @@ -135,6 +135,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         if (!vq)
>                 return ERR_PTR(-ENOMEM);
>
> +       vq->num_max = num;
> +
>         q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
>         if (q_pfn >> 32) {
>                 dev_err(&vp_dev->pci_dev->dev,
> diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> index 623906b4996c..e7e0b8c850f6 100644
> --- a/drivers/virtio/virtio_pci_modern.c
> +++ b/drivers/virtio/virtio_pci_modern.c
> @@ -218,6 +218,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
>         if (!vq)
>                 return ERR_PTR(-ENOMEM);
>
> +       vq->num_max = num;
> +
>         /* activate the queue */
>         vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
>         vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index a5ec724c01d8..4cac600856ad 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -2385,6 +2385,20 @@ void vring_transport_features(struct virtio_device *vdev)
>  }
>  EXPORT_SYMBOL_GPL(vring_transport_features);
>
> +/**
> + * virtqueue_get_vring_max_size - return the max size of the virtqueue's vring
> + * @_vq: the struct virtqueue containing the vring of interest.
> + *
> + * Returns the max size of the vring.
> + *
> + * Unlike other operations, this need not be serialized.
> + */
> +unsigned int virtqueue_get_vring_max_size(struct virtqueue *_vq)
> +{
> +       return _vq->num_max;
> +}
> +EXPORT_SYMBOL_GPL(virtqueue_get_vring_max_size);
> +
>  /**
>   * virtqueue_get_vring_size - return the size of the virtqueue's vring
>   * @_vq: the struct virtqueue containing the vring of interest.
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index c40f7deb6b5a..9670cc79371d 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -183,6 +183,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>                 goto error_new_virtqueue;
>         }
>
> +       vq->num_max = max_num;
> +
>         /* Setup virtqueue callback */
>         cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
>         cb.private = info;
> diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> index d8fdf170637c..a82620032e43 100644
> --- a/include/linux/virtio.h
> +++ b/include/linux/virtio.h
> @@ -31,6 +31,7 @@ struct virtqueue {
>         struct virtio_device *vdev;
>         unsigned int index;
>         unsigned int num_free;
> +       unsigned int num_max;

A question, since we export virtqueue to drivers, this means they can
access vq->num_max directly.

So we probably don't need a helper here.

Thanks

>         void *priv;
>  };
>
> @@ -80,6 +81,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
>
>  void *virtqueue_detach_unused_buf(struct virtqueue *vq);
>
> +unsigned int virtqueue_get_vring_max_size(struct virtqueue *vq);
>  unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
>
>  bool virtqueue_is_broken(struct virtqueue *vq);
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
