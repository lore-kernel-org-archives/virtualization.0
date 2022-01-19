Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2905C433FE
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 06:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 43FC060E91;
	Wed, 19 Jan 2022 06:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hnC9jIVQeV5R; Wed, 19 Jan 2022 06:05:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1F6B607A3;
	Wed, 19 Jan 2022 06:05:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 755F9C0039;
	Wed, 19 Jan 2022 06:05:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DC27C002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4F30403B4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:05:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SG-qrxLywqvo
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:05:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CF7FB40116
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 06:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642572307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2PF19YfY5VAZjq3OrNdimVOjqgbxHWHIcrk5DCTa/5g=;
 b=YZ7c4v4UERX3lF8Jfz2LFhbh3hymuYiNhdHg+V+fcxyc5MhCtSeI+X6QKI7ftRLJMSGuuH
 cUv7TIsgNOBGdTbqZQp129WHdBHQc+wiGkm+CTia7cfkxTPf467y3N4Pe3uzpa9/nFfySM
 UbAFRDyPhliUv3ZEG6y+O5EPkD2nXoE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-224-XAQg03AAMgyPLJ24YN9lRw-1; Wed, 19 Jan 2022 01:05:04 -0500
X-MC-Unique: XAQg03AAMgyPLJ24YN9lRw-1
Received: by mail-lf1-f69.google.com with SMTP id
 x23-20020ac25dd7000000b0042ffb81aaffso836830lfq.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 22:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2PF19YfY5VAZjq3OrNdimVOjqgbxHWHIcrk5DCTa/5g=;
 b=7g4cHCiqoWEId7hOiN3xPkHQPSv16Wvcd4i+AmXXdjLP0o6iNqKgAoXE+JuxdisHIL
 AG3h87qth8B6br+RP5oXcOJq8qEFzc3bUbJEK8IGP9i/nnN9ShP2OWkuMI5LGeMoPADn
 aMYwmB6yYcJzGoB5GUwmwxj+tzV4W5Tgbhb0bVa5a+859xLdp07O5HN0+GHeXMLjQkqo
 YxDfxOGCXm3BQBIlVlctQEaYboMecmCRF/Au7CFLaN26ORhQVmapFiaF5MnBROUS1cCe
 CNC3416oKR9AkGGvCw8rIUb8Y+Sw4H0qOmMzKldCRB4GcAeoMWd8KpTclHgXs6U4EEXh
 bIig==
X-Gm-Message-State: AOAM530I6n9YAmRZHwPhUDJvFlcatr3GSKijgX6DnZ+9YMCZ5Q1w/DuE
 G7HoRGXgKL0e6TMCInO2FOC874kHt0pwKzLwb5n7w5AfV0JqhdnT/sZK80fOpYPTybfBPy8dw7Z
 INnP1Ntjv0iVSpgz6gHu2QjdjUOjt/h29njIY83CmjfpgyU9U1G2gGyFWjA==
X-Received: by 2002:a05:6512:3b0a:: with SMTP id
 f10mr22071056lfv.629.1642572302621; 
 Tue, 18 Jan 2022 22:05:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzYi4xjrOsC4KBhZL03/vWENEGnkTpWqDDDmBr6UeLW5EwyabTbYdCrlO8F11VA/U9qI0OtVH6GyaAgp4EiuoM=
X-Received: by 2002:a05:6512:3b0a:: with SMTP id
 f10mr22071035lfv.629.1642572302349; 
 Tue, 18 Jan 2022 22:05:02 -0800 (PST)
MIME-Version: 1.0
References: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
 <20220119023543.91620-5-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20220119023543.91620-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 19 Jan 2022 14:04:51 +0800
Message-ID: <CACGkMEsm15wuiscGYi2DJEU_9po7J_sUvX5FAW=eC-hv5u1ocQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] virtio: queue_reset: pci: extract some functions for
 subsequent patches
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Wed, Jan 19, 2022 at 10:35 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> Add a vq_enable_vq_msix() function to enable a vq alone.
>
> Move irq's processing logic into vp_del_vq(), so that this function can
> handle a vq's del operation independently.
>
> In the subsequent patches that supports queue reset, I have the
> need to delete/enable a vq separately.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_pci_common.c | 86 +++++++++++++++++++-----------
>  1 file changed, 54 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index fdbde1db5ec5..5afe207ce28a 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -248,6 +248,17 @@ static void vp_del_vq(struct virtqueue *vq)
>         struct virtio_pci_vq_info *info = vp_dev->vqs[vq->index];
>         unsigned long flags;
>
> +       if (vp_dev->per_vq_vectors) {
> +               int v = vp_dev->vqs[vq->index]->msix_vector;
> +
> +               if (v != VIRTIO_MSI_NO_VECTOR) {
> +                       int irq = pci_irq_vector(vp_dev->pci_dev, v);
> +
> +                       irq_set_affinity_hint(irq, NULL);
> +                       free_irq(irq, vq);
> +               }
> +       }
> +
>         spin_lock_irqsave(&vp_dev->lock, flags);
>         list_del(&info->node);
>         spin_unlock_irqrestore(&vp_dev->lock, flags);
> @@ -263,19 +274,9 @@ void vp_del_vqs(struct virtio_device *vdev)
>         struct virtqueue *vq, *n;
>         int i;
>
> -       list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
> -               if (vp_dev->per_vq_vectors) {
> -                       int v = vp_dev->vqs[vq->index]->msix_vector;
> -
> -                       if (v != VIRTIO_MSI_NO_VECTOR) {
> -                               int irq = pci_irq_vector(vp_dev->pci_dev, v);
> -
> -                               irq_set_affinity_hint(irq, NULL);
> -                               free_irq(irq, vq);
> -                       }
> -               }
> +       list_for_each_entry_safe(vq, n, &vdev->vqs, list)
>                 vp_del_vq(vq);
> -       }

I think we need a better subject of the patch and it's better to even
split the patch into two.

This part could be "move the per queue irq logic from vp_del_vqs to vp_del_vq".

> +
>         vp_dev->per_vq_vectors = false;
>
>         if (vp_dev->intx_enabled) {
> @@ -310,6 +311,40 @@ void vp_del_vqs(struct virtio_device *vdev)
>         vp_dev->vqs = NULL;
>  }
>
> +static struct virtqueue *vp_enable_vq_msix(struct virtio_device *vdev,
> +                                          int queue_index,
> +                                          vq_callback_t *callback,
> +                                          const char * const name,
> +                                          bool ctx,
> +                                          u16 msix_vec)
> +{
> +       struct virtio_pci_device *vp_dev = to_vp_device(vdev);
> +       struct virtqueue *vq;
> +       int err;
> +
> +       vq = vp_setup_vq(vdev, queue_index, callback, name, ctx, msix_vec);
> +       if (IS_ERR(vq))
> +               return vq;
> +
> +       if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> +               return vq;
> +
> +       /* allocate per-vq irq if available and necessary */
> +       snprintf(vp_dev->msix_names[msix_vec],
> +                sizeof *vp_dev->msix_names,
> +                "%s-%s", dev_name(&vp_dev->vdev.dev), name);
> +
> +       err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> +                         vring_interrupt, IRQF_NO_AUTOEN,
> +                         vp_dev->msix_names[msix_vec], vq);
> +       if (err) {
> +               vp_del_vq(vq);
> +               return ERR_PTR(err);
> +       }
> +
> +       return vq;
> +}

And this deserves a separate patch as well.

Thanks

> +
>  static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>                 struct virtqueue *vqs[], vq_callback_t *callbacks[],
>                 const char * const names[], bool per_vq_vectors,
> @@ -319,6 +354,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>         struct virtio_pci_device *vp_dev = to_vp_device(vdev);
>         u16 msix_vec;
>         int i, err, nvectors, allocated_vectors, queue_idx = 0;
> +       struct virtqueue *vq;
>
>         vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -354,28 +390,14 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
>                         msix_vec = allocated_vectors++;
>                 else
>                         msix_vec = VP_MSIX_VQ_VECTOR;
> -               vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
> -                                    ctx ? ctx[i] : false,
> -                                    msix_vec);
> -               if (IS_ERR(vqs[i])) {
> -                       err = PTR_ERR(vqs[i]);
> -                       goto error_find;
> -               }
>
> -               if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
> -                       continue;
> -
> -               /* allocate per-vq irq if available and necessary */
> -               snprintf(vp_dev->msix_names[msix_vec],
> -                        sizeof *vp_dev->msix_names,
> -                        "%s-%s",
> -                        dev_name(&vp_dev->vdev.dev), names[i]);
> -               err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
> -                                 vring_interrupt, IRQF_NO_AUTOEN,
> -                                 vp_dev->msix_names[msix_vec],
> -                                 vqs[i]);
> -               if (err)
> +               vq = vp_enable_vq_msix(vdev, queue_idx++, callbacks[i],
> +                                      names[i], ctx ? ctx[i] : false, msix_vec);
> +               if (IS_ERR(vq)) {
> +                       err = PTR_ERR(vq);
>                         goto error_find;
> +               }
> +               vqs[i] = vq;
>         }
>         return 0;
>
> --
> 2.31.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
