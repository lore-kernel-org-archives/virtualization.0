Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F863C433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Nov 2022 04:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 13737813F3;
	Mon, 14 Nov 2022 04:03:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 13737813F3
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RZAKVqds
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sY8encAP6hu1; Mon, 14 Nov 2022 04:03:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E6C88136A;
	Mon, 14 Nov 2022 04:03:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E6C88136A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06E95C0033;
	Mon, 14 Nov 2022 04:03:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70674C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:03:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 47870401B7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:03:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47870401B7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RZAKVqds
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y3cGVdC6Jgbf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:03:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D288F4001F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D288F4001F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Nov 2022 04:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668398589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oq5eZXf0XhukK2gu36VDoVydSFlALZ6mBLTD6YCisaQ=;
 b=RZAKVqdsgvkMM8b0tsL/FSXkChJdr41Cs2npckleteiu4mRVclPCh4ItfLeZRqaqXYhruM
 O15ZZ3X58dFBZVhaqJf4+8H0fFpZ1lW84pDLguJpPm7cJgTrCgQXizVCPk1YJLFatv9aSt
 SA9ImT7nIzRMbpSMGLhBA4WQXjENS6Q=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-274-N-0L3uyKN--Bc-eYD5s-4A-1; Sun, 13 Nov 2022 23:02:59 -0500
X-MC-Unique: N-0L3uyKN--Bc-eYD5s-4A-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-13c6efaa955so4938186fac.11
 for <virtualization@lists.linux-foundation.org>;
 Sun, 13 Nov 2022 20:02:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oq5eZXf0XhukK2gu36VDoVydSFlALZ6mBLTD6YCisaQ=;
 b=XRrr3QcLZQxHJotIGPy31iNh9ckPQndknsqJ4g5oO2qw58dYv/1U6SeAG9L/79D/Fk
 s7El1DpuA8x2cEt6use6xzepmexLZnQXccleUD9Gx/e/Mb9uhGJDjvxH08S2288HaxWG
 jYwemmZlJTP2hXhwr4IrSZatei1EdLkz6TTP2Jz6IYdjtNxjLylA7p7MgViw6hV2C+6n
 Y9s4OOQ8C10eXEN+g2Y7qIUwPNQAX5gfJYXCYixAk0oB/EeQRkO4X6pu76/ovQeew6ci
 5U+c9uUu3c6d+H8xULYVxVJzfOdVXyiJ/UMU4BqbC9WsWslqCCJ4bkNNZMgMPJFQJqvS
 wm0A==
X-Gm-Message-State: ANoB5pmG/D9+u2aMXRdhOSclLFrzcPSTjqhm9de/E8SEhfuOxShXgsCq
 TeNUgsMgXQ7U3qFXZFMEMPWy9P9O7kDNppF7sfyVFBadoF293ffZn3feOjk6Zoua/SSpptafip+
 5J4wNYXEnEUop4zh7WaXR3mkM2y1OrLEMowDOzjKGClIoxCxqnwSKl3wCvA==
X-Received: by 2002:a05:6870:4693:b0:132:7b3:29ac with SMTP id
 a19-20020a056870469300b0013207b329acmr5866561oap.35.1668398578353; 
 Sun, 13 Nov 2022 20:02:58 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xjudomhrvG+/XAwTBGmLMookiQ0Mk6p2vSEBVqpGEMBIhFS9oqAY4w4rOGA3n360voc4bxmeg1XO2H4Y++h0=
X-Received: by 2002:a05:6870:4693:b0:132:7b3:29ac with SMTP id
 a19-20020a056870469300b0013207b329acmr5866535oap.35.1668398577988; Sun, 13
 Nov 2022 20:02:57 -0800 (PST)
MIME-Version: 1.0
References: <20221111153555.1295-1-longpeng2@huawei.com>
In-Reply-To: <20221111153555.1295-1-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Nov 2022 12:02:47 +0800
Message-ID: <CACGkMEuZp4GskMjAvGcNNRTmrmgzg1e4ufzJDekBBQ5BE9Nk=Q@mail.gmail.com>
Subject: Re: [RFC] vdpa: clear the device when opening/releasing it
To: "Longpeng(Mike)" <longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xiehong@huawei.com, lulu@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, yechuan@huawei.com, huangzhichao@huawei.com,
 stefanha@redhat.com, virtualization@lists.linux-foundation.org
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

On Fri, Nov 11, 2022 at 11:36 PM Longpeng(Mike) <longpeng2@huawei.com> wrote:
>
> From: Longpeng <longpeng2@huawei.com>
>
> We should do some deeply cleanup when opening or releasing the device,
> e.g trigger FLR if it is PCIe device.

Why is this needed? We're resetting at the virtio level instead of the
transport level.

Thanks

>
> Signed-off-by: Longpeng <longpeng2@huawei.com>
> ---
>  drivers/vdpa/alibaba/eni_vdpa.c    | 2 +-
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c | 2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 2 +-
>  drivers/vhost/vdpa.c               | 4 ++--
>  drivers/virtio/virtio_vdpa.c       | 2 +-
>  include/linux/vdpa.h               | 7 ++++---
>  9 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index 5a09a09cca70..07215b174dd6 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -226,7 +226,7 @@ static void eni_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>                 eni_vdpa_free_irq(eni_vdpa);
>  }
>
> -static int eni_vdpa_reset(struct vdpa_device *vdpa)
> +static int eni_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct eni_vdpa *eni_vdpa = vdpa_to_eni(vdpa);
>         struct virtio_pci_legacy_device *ldev = &eni_vdpa->ldev;
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044c6442..b9a6ac18f358 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -496,7 +496,7 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
>         ifcvf_set_status(vf, status);
>  }
>
> -static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
> +static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev, bool clear)
>  {
>         struct ifcvf_adapter *adapter;
>         struct ifcvf_hw *vf;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 90913365def4..6f06f9c464a3 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2560,7 +2560,7 @@ static void init_group_to_asid_map(struct mlx5_vdpa_dev *mvdev)
>                 mvdev->group2asid[i] = 0;
>  }
>
> -static int mlx5_vdpa_reset(struct vdpa_device *vdev)
> +static int mlx5_vdpa_reset(struct vdpa_device *vdev, bool clear)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b071f0d842fb..7438a89ce939 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -504,7 +504,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
>         spin_unlock(&vdpasim->lock);
>  }
>
> -static int vdpasim_reset(struct vdpa_device *vdpa)
> +static int vdpasim_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 35dceee3ed56..e5fee28233c0 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -691,7 +691,7 @@ static void vduse_vdpa_set_config(struct vdpa_device *vdpa, unsigned int offset,
>         /* Now we only support read-only configuration space */
>  }
>
> -static int vduse_vdpa_reset(struct vdpa_device *vdpa)
> +static int vduse_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>         int ret = vduse_dev_set_status(dev, 0);
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index d35fac5cde11..3db25b622a57 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -226,7 +226,7 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
>         vp_modern_set_status(mdev, status);
>  }
>
> -static int vp_vdpa_reset(struct vdpa_device *vdpa)
> +static int vp_vdpa_reset(struct vdpa_device *vdpa, bool clear)
>  {
>         struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
>         struct virtio_pci_modern_device *mdev = vp_vdpa_to_mdev(vp_vdpa);
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 166044642fd5..fdda08cd7e7a 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -212,7 +212,7 @@ static int vhost_vdpa_reset(struct vhost_vdpa *v)
>
>         v->in_batch = 0;
>
> -       return vdpa_reset(vdpa);
> +       return vdpa_reset(vdpa, true);
>  }
>
>  static long vhost_vdpa_get_device_id(struct vhost_vdpa *v, u8 __user *argp)
> @@ -269,7 +269,7 @@ static long vhost_vdpa_set_status(struct vhost_vdpa *v, u8 __user *statusp)
>                         vhost_vdpa_unsetup_vq_irq(v, i);
>
>         if (status == 0) {
> -               ret = vdpa_reset(vdpa);
> +               ret = vdpa_reset(vdpa, false);
>                 if (ret)
>                         return ret;
>         } else
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 9670cc79371d..8f6ae689547e 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -99,7 +99,7 @@ static void virtio_vdpa_reset(struct virtio_device *vdev)
>  {
>         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>
> -       vdpa_reset(vdpa);
> +       vdpa_reset(vdpa, false);
>  }
>
>  static bool virtio_vdpa_notify(struct virtqueue *vq)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 6d0f5e4e82c2..a0b917743b66 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -218,6 +218,7 @@ struct vdpa_map_file {
>   *                             @status: virtio device status
>   * @reset:                     Reset device
>   *                             @vdev: vdpa device
> + *                             @clear: need device/function level clear or not, e.g pcie_flr.
>   *                             Returns integer: success (0) or error (< 0)
>   * @suspend:                   Suspend or resume the device (optional)
>   *                             @vdev: vdpa device
> @@ -322,7 +323,7 @@ struct vdpa_config_ops {
>         u32 (*get_vendor_id)(struct vdpa_device *vdev);
>         u8 (*get_status)(struct vdpa_device *vdev);
>         void (*set_status)(struct vdpa_device *vdev, u8 status);
> -       int (*reset)(struct vdpa_device *vdev);
> +       int (*reset)(struct vdpa_device *vdev, bool clear);
>         int (*suspend)(struct vdpa_device *vdev);
>         size_t (*get_config_size)(struct vdpa_device *vdev);
>         void (*get_config)(struct vdpa_device *vdev, unsigned int offset,
> @@ -427,14 +428,14 @@ static inline struct device *vdpa_get_dma_dev(struct vdpa_device *vdev)
>         return vdev->dma_dev;
>  }
>
> -static inline int vdpa_reset(struct vdpa_device *vdev)
> +static inline int vdpa_reset(struct vdpa_device *vdev, bool clear)
>  {
>         const struct vdpa_config_ops *ops = vdev->config;
>         int ret;
>
>         down_write(&vdev->cf_lock);
>         vdev->features_valid = false;
> -       ret = ops->reset(vdev);
> +       ret = ops->reset(vdev, clear);
>         up_write(&vdev->cf_lock);
>         return ret;
>  }
> --
> 2.23.0
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
