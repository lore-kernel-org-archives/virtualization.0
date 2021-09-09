Return-Path: <SRS0=8M8J=N7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2210C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:55:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5686E603E9
	for <virtualization@archiver.kernel.org>; Thu,  9 Sep 2021 02:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5686E603E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C29061402;
	Thu,  9 Sep 2021 02:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AEOthcFI7XXz; Thu,  9 Sep 2021 02:55:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B273B6139A;
	Thu,  9 Sep 2021 02:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99050C0011;
	Thu,  9 Sep 2021 02:55:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E27FC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7AD7B61402
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZxtRayNGC7j2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:55:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A989B6139A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Sep 2021 02:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1631156117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bgl87DQRRkijdxiM7oIXHkWBZiVtL27pqax+4qDlhg4=;
 b=WrXABtbl5hLSlW77k+HSvAuixro/jQk9yUSaaRKtzpBQSktedbhxEjhTcTcPH+Aqo+p8pU
 pInFsykvR3om9yrcXJ47JWjCYrqn7aNzmju3Dc8ZarasdcwscPl//DjS3d9KsuCAhY0uFy
 jr+0eXG9QciFVtCVRrkBjoypxxRv7Xs=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-fLcje-yPON6Jnx7C9ZDgcw-1; Wed, 08 Sep 2021 22:55:16 -0400
X-MC-Unique: fLcje-yPON6Jnx7C9ZDgcw-1
Received: by mail-lj1-f200.google.com with SMTP id
 e10-20020a05651c04ca00b001c99c74e564so144236lji.11
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Sep 2021 19:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bgl87DQRRkijdxiM7oIXHkWBZiVtL27pqax+4qDlhg4=;
 b=KlDaoV86uZmle8TZfGngIvoBz9lhdA7D+w02pknfMmxALkx+k+j8PwrQOes10WzmRS
 tTzSmbwdXtMhc4ahoOVEIJWnycpOFTIa5kxWnJKtZ4yJLa1i8w2amZ155mHZbFp7Shcg
 TRpNA/WeNqgutJgAaq6+K/K6LVC2ptX6NBTmCAaKCwjYjMNIy28VJfCJ1i4nJ3P1FwDB
 5wCoxmMpYIjImBQ2KT8AhBGPOMogRGI4DTtLwsGUivC3g/+5ggo40JcLL8fuj6YmYSgC
 pKS2+ihJD6x8rWx1c3Xdpd1aCRSIxVjFgGxqbVoUnqsIkIkcp4LKy4cKHhz9HL4jdLTF
 4H9w==
X-Gm-Message-State: AOAM533B573E0aa0xhaIesCDA4zftPzM4lG6orknQdBhuWEJTyN1JBVQ
 qW/YdkPT1S3Ric+cZuNdCflsQ5hLJKsS5AFMZ2sgitUyXevlnDxet2TxFBMr0dofRhSFh5YILn0
 2MpHevPB/2oVRbtXk/9VHPh30djon93EId26shjBWeDKhp0uc9eWAVdi76g==
X-Received: by 2002:a19:6b18:: with SMTP id d24mr669712lfa.84.1631156114786;
 Wed, 08 Sep 2021 19:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhmyR+U2flIWze7kZBdb2cIbVOuqqDBkVuxY8OgBvAQGkyigpfw4hOpMgE2/3CRySLN5y8S4S+VnLYJ/w1Hb4=
X-Received: by 2002:a19:6b18:: with SMTP id d24mr669702lfa.84.1631156114587;
 Wed, 08 Sep 2021 19:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631101392.git.wuzongyong@linux.alibaba.com>
 <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
In-Reply-To: <ebd83066e3897aae63e4b02f8729a73dd09931c6.1631101392.git.wuzongyong@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Sep 2021 10:55:03 +0800
Message-ID: <CACGkMEtAZg+Nkx_1WJAP2=xQ6o6G9Vd=xYvFmR6YRp8vBg2Tqg@mail.gmail.com>
Subject: Re: [PATCH 5/6] vdpa: add get_vq_num_unchangeable callback in
 vdpa_config_ops
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, Sep 8, 2021 at 8:23 PM Wu Zongyong <wuzongyong@linux.alibaba.com> wrote:
>
> This new callback is used to indicate whether the vring size can be
> change or not. It is useful when we have a legacy virtio pci device as
> the vdpa device for there is no way to negotiate the vring num by the
> specification.

So I'm not sure it's worth bothering. E.g what if we just fail
VHOST_SET_VRING_NUM it the value doesn't match what hardware has?

Thanks

>
> Signed-off-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> ---
>  drivers/vhost/vdpa.c         | 19 +++++++++++++++++++
>  drivers/virtio/virtio_vdpa.c |  5 ++++-
>  include/linux/vdpa.h         |  4 ++++
>  include/uapi/linux/vhost.h   |  2 ++
>  4 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 9479f7f79217..2204d27d1e5d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -350,6 +350,22 @@ static long vhost_vdpa_get_iova_range(struct vhost_vdpa *v, u32 __user *argp)
>         return 0;
>  }
>
> +static long vhost_vdpa_get_vring_num_unchangeable(struct vhost_vdpa *v,
> +                                                 u32 __user *argp)
> +{
> +       struct vdpa_device *vdpa = v->vdpa;
> +       const struct vdpa_config_ops *ops = vdpa->config;
> +       bool unchangeable = false;
> +
> +       if (ops->get_vq_num_unchangeable)
> +               unchangeable = ops->get_vq_num_unchangeable(vdpa);
> +
> +       if (copy_to_user(argp, &unchangeable, sizeof(unchangeable)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>  static long vhost_vdpa_vring_ioctl(struct vhost_vdpa *v, unsigned int cmd,
>                                    void __user *argp)
>  {
> @@ -487,6 +503,9 @@ static long vhost_vdpa_unlocked_ioctl(struct file *filep,
>         case VHOST_VDPA_GET_IOVA_RANGE:
>                 r = vhost_vdpa_get_iova_range(v, argp);
>                 break;
> +       case VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE:
> +               r = vhost_vdpa_get_vring_num_unchangeable(v, argp);
> +               break;
>         default:
>                 r = vhost_dev_ioctl(&v->vdev, cmd, argp);
>                 if (r == -ENOIOCTLCMD)
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index 72eaef2caeb1..afb47465307a 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -146,6 +146,7 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>         struct vdpa_vq_state state = {0};
>         unsigned long flags;
>         u32 align, num;
> +       bool may_reduce_num = true;
>         int err;
>
>         if (!name)
> @@ -171,8 +172,10 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
>
>         /* Create the vring */
>         align = ops->get_vq_align(vdpa);
> +       if (ops->get_vq_num_unchangeable)
> +               may_reduce_num = !ops->get_vq_num_unchangeable(vdpa);
>         vq = vring_create_virtqueue(index, num, align, vdev,
> -                                   true, true, ctx,
> +                                   true, may_reduce_num, ctx,
>                                     virtio_vdpa_notify, callback, name);
>         if (!vq) {
>                 err = -ENOMEM;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 35648c11e312..f809b7ada00d 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -195,6 +195,9 @@ struct vdpa_iova_range {
>   *                             @vdev: vdpa device
>   *                             Returns the iova range supported by
>   *                             the device.
> + * @get_vq_num_unchangeable    Check if size of virtqueue is unchangeable (optional)
> + *                             @vdev: vdpa device
> + *                             Returns boolean: unchangeable (true) or not (false)
>   * @set_map:                   Set device memory mapping (optional)
>   *                             Needed for device that using device
>   *                             specific DMA translation (on-chip IOMMU)
> @@ -262,6 +265,7 @@ struct vdpa_config_ops {
>                            const void *buf, unsigned int len);
>         u32 (*get_generation)(struct vdpa_device *vdev);
>         struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> +       bool (*get_vq_num_unchangeable)(struct vdpa_device *vdev);
>
>         /* DMA ops */
>         int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
> index c998860d7bbc..184f1f7f8498 100644
> --- a/include/uapi/linux/vhost.h
> +++ b/include/uapi/linux/vhost.h
> @@ -150,4 +150,6 @@
>  /* Get the valid iova range */
>  #define VHOST_VDPA_GET_IOVA_RANGE      _IOR(VHOST_VIRTIO, 0x78, \
>                                              struct vhost_vdpa_iova_range)
> +/* Check if the vring size can be change */
> +#define VHOST_VDPA_GET_VRING_NUM_UNCHANGEABLE _IOR(VHOST_VIRTIO, 0X79, bool)
>  #endif
> --
> 2.31.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
