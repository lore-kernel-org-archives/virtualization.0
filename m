Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899AAC4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 03:53:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F41A940BC7;
	Fri, 16 Dec 2022 03:53:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F41A940BC7
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SlnAV/gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ceCp4NWMCe90; Fri, 16 Dec 2022 03:53:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 85B8C400D1;
	Fri, 16 Dec 2022 03:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 85B8C400D1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DCF3C0033;
	Fri, 16 Dec 2022 03:52:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9550AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 62E5582136
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:52:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 62E5582136
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SlnAV/gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gmsx_fg7fopr
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:52:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F6FE82135
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F6FE82135
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 03:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671162776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m/mkgsybv+YQLr4xgOo2Mo6CQB2C40n1fNpguX/a6f0=;
 b=SlnAV/gg79VWjB4Uiha7zu+QbVNn9JOu7Qzctd2/BV7J6pmI2ZiMe51NYIbKntSSOmDWB/
 j7W4HVgm2AM7f1oe0xsTpaEqnlNo3K4aSjAoJCHn+qbeIKOgY4tTfdsdXcmChWY0ZIHZ3y
 Mv4L9cvPYeYimUIIWFikz9M2WYyN5NY=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-ZMiglMhFMNGYdvf_Lcob6A-1; Thu, 15 Dec 2022 22:52:52 -0500
X-MC-Unique: ZMiglMhFMNGYdvf_Lcob6A-1
Received: by mail-oi1-f199.google.com with SMTP id
 t25-20020a056808159900b0035ecfd3fa78so371527oiw.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Dec 2022 19:52:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m/mkgsybv+YQLr4xgOo2Mo6CQB2C40n1fNpguX/a6f0=;
 b=YMeUQZPhqq42NWqsB7G+A0Ye2V/MbD02fjXn1Ts46EhfDAuh4wgU+saBJZXn1cQkY3
 Jd3l8X4xceC5aSvqxscylvfih2L/Nvaqm16Xok7oZsetPE+VfsSJkxo48DGgexitithc
 pL+VKxC6vqHcfdqJ1av8vht3Vz62KpninKNHcv8v8cXoozDAEQPae/Nty2VtstvqJq42
 MvB3ngy7nJMHD0wkY3JAamh3os1VtwThx+slOxmxRB3SsSXIupHQOUh0VOOi8iJ+4CaJ
 7aWS7lJ8165nLdLDPxBBPiQDKbl+H3NULyE4pgsNaU+EmA3eV4V2ObjeNM5CetYDBe/c
 iPkw==
X-Gm-Message-State: ANoB5pkPbeZJ+pn0FRd1dPVL390iHGvER4U6RIL4psj4cOUwQ+Dy6nKN
 ohFbgKr2JW8kJIRatCDrk8axe7LIO4VnM8ZZ+nLA1ztkpC0XIlIgZ4ZSYtusAJIipFSBODftpH/
 wGVZ0fu0PCYp7AW95otoT/nJ+3Zx4dJ/bT0bjt1uSV/2uh9HyZLU+J8Ef1g==
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49171573otb.237.1671162772191; 
 Thu, 15 Dec 2022 19:52:52 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LLJFF2vwjKag+M02bzigSi3YJhDrHkH5IBNXsH5IdjpWSKWW5SLTf7TcNnRRFz54+6GmXg7+X2M1gXN7LlEI=
X-Received: by 2002:a05:6830:6505:b0:66c:fb5b:4904 with SMTP id
 cm5-20020a056830650500b0066cfb5b4904mr49171566otb.237.1671162771969; Thu, 15
 Dec 2022 19:52:51 -0800 (PST)
MIME-Version: 1.0
References: <20221205084127.535-1-xieyongji@bytedance.com>
 <20221205084127.535-3-xieyongji@bytedance.com>
In-Reply-To: <20221205084127.535-3-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Dec 2022 11:52:40 +0800
Message-ID: <CACGkMEvJM4g5EAZiuS_-=uAOZ=LZN=KjNtFmVPXdv=arSVyLXg@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] vdpa: Add set/get_vq_affinity callbacks in
 vdpa_config_ops
To: Xie Yongji <xieyongji@bytedance.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
 virtualization@lists.linux-foundation.org, hch@lst.de, mst@redhat.com
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

On Mon, Dec 5, 2022 at 4:43 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> This introduces set/get_vq_affinity callbacks in
> vdpa_config_ops to support interrupt affinity
> management for vdpa device drivers.
>
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

> ---
>  drivers/virtio/virtio_vdpa.c | 28 ++++++++++++++++++++++++++++
>  include/linux/vdpa.h         | 13 +++++++++++++
>  2 files changed, 41 insertions(+)
>
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 9670cc79371d..08084b49e5a1 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -330,6 +330,32 @@ static const char *virtio_vdpa_bus_name(struct virtio_device *vdev)
>         return dev_name(&vdpa->dev);
>  }
>
> +static int virtio_vdpa_set_vq_affinity(struct virtqueue *vq,
> +                                      const struct cpumask *cpu_mask)
> +{
> +       struct virtio_vdpa_device *vd_dev = to_virtio_vdpa_device(vq->vdev);
> +       struct vdpa_device *vdpa = vd_dev->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       unsigned int index = vq->index;
> +
> +       if (ops->set_vq_affinity)
> +               return ops->set_vq_affinity(vdpa, index, cpu_mask);
> +
> +       return 0;
> +}
> +
> +static const struct cpumask *
> +virtio_vdpa_get_vq_affinity(struct virtio_device *vdev, int index)
> +{
> +       struct vdpa_device *vdpa = vd_get_vdpa(vdev);
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +
> +       if (ops->get_vq_affinity)
> +               return ops->get_vq_affinity(vdpa, index);
> +
> +       return NULL;
> +}
> +
>  static const struct virtio_config_ops virtio_vdpa_config_ops = {
>         .get            = virtio_vdpa_get,
>         .set            = virtio_vdpa_set,
> @@ -342,6 +368,8 @@ static const struct virtio_config_ops virtio_vdpa_config_ops = {
>         .get_features   = virtio_vdpa_get_features,
>         .finalize_features = virtio_vdpa_finalize_features,
>         .bus_name       = virtio_vdpa_bus_name,
> +       .set_vq_affinity = virtio_vdpa_set_vq_affinity,
> +       .get_vq_affinity = virtio_vdpa_get_vq_affinity,
>  };
>
>  static void virtio_vdpa_release_dev(struct device *_d)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..0ff6c9363356 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -247,6 +247,15 @@ struct vdpa_map_file {
>   *                             @vdev: vdpa device
>   *                             Returns the iova range supported by
>   *                             the device.
> + * @set_vq_affinity:           Set the irq affinity of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             @cpu_mask: irq affinity mask
> + *                             Returns integer: success (0) or error (< 0)
> + * @get_vq_affinity:           Get the irq affinity of virtqueue (optional)
> + *                             @vdev: vdpa device
> + *                             @idx: virtqueue index
> + *                             Returns the irq affinity mask
>   * @set_group_asid:            Set address space identifier for a
>   *                             virtqueue group (optional)
>   *                             @vdev: vdpa device
> @@ -331,6 +340,10 @@ struct vdpa_config_ops {
>                            const void *buf, unsigned int len);
>         u32 (*get_generation)(struct vdpa_device *vdev);
>         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +       int (*set_vq_affinity)(struct vdpa_device *vdev, u16 idx,
> +                              const struct cpumask *cpu_mask);
> +       const struct cpumask *(*get_vq_affinity)(struct vdpa_device *vdev,
> +                                                u16 idx);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, unsigned int asid,
> --
> 2.20.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
