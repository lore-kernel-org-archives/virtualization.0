Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D424C433EF
	for <virtualization@archiver.kernel.org>; Wed, 15 Jun 2022 09:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93BDB61027;
	Wed, 15 Jun 2022 09:08:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wXZZiREqjwJZ; Wed, 15 Jun 2022 09:08:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 25B0A60E02;
	Wed, 15 Jun 2022 09:08:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5CC7C0039;
	Wed, 15 Jun 2022 09:08:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94D8CC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 09:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 702FD6101F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 09:08:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ikFin-66E_JS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 09:08:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DC4560E02
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655284094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H1qyoIyqkMNQI+S02pzuSubrV352cv4mXg3Xnxxmlio=;
 b=P2E4JXDDK+Acy0x0qTRIEOL0ulI2KT4bYydxxS+oS7aYr6ecT0mExdlX3neMA+u8cImS4n
 532//sXQXhYJt4DHvBbKzL43BzFjCvtZHd06KZnIYGIxQEv7PKWxsj1djt741H/7GH68fZ
 OW1qNXy+XI6IK5S8WuESVcwL8YfQV2s=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-e6oit-GjNLysN64AHdFAmQ-1; Wed, 15 Jun 2022 05:08:13 -0400
X-MC-Unique: e6oit-GjNLysN64AHdFAmQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 p36-20020a05651213a400b004779d806c13so5780107lfa.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 02:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H1qyoIyqkMNQI+S02pzuSubrV352cv4mXg3Xnxxmlio=;
 b=USItAyA4KxtwoLj4645w4hZsTZDYCWw0eZXtOB8x7m1VEJ+C+jmO/lFySDJ0WVa0yR
 2qAPw8JVwuguMx1DdPINgVBBqIjM1+svOnHkSOLgJHZ2CCom33J7+ciuLcy2dJLOT57o
 6T4lmgWC2eQH0VHCwxbzTHU45AUqP4/vyrHMSoEi09scbpuabSq+perBX2JTOWWYCxHD
 7wTipqRMR1aNsFBvrVlkUAPIiOVD8rpuPO9Acwp+F5pJWZ5uEGSmqyISCmC/vm18p2k/
 NBGOkHPO87QSlNfMxOeeKPFawy5kNzIc+Pmk1teSTM3in/YfPWraWMrTwF+QOxy3JHpI
 xlvQ==
X-Gm-Message-State: AJIora8R5tmVnA8rgjM5k5yy5Z+rmbnkoOCZKuAG9K7TTXg5Byp7OVYl
 i4LFLsDLbZlht7mRTzzlw0Xdxi105EBl5b44U/04Szo8wrm9RqIZz0ECYMQdkHjFOOkxdg+cPmM
 m2C0WXtdEOznNlikeZuG2YeuBRUuGFxO+gU5aqMfc0sTKKCFYHXy7cdnUDw==
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr5597085lfb.238.1655284091963; 
 Wed, 15 Jun 2022 02:08:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sdcY0BCkVpAfp5loVWHw6SE4XVJpJT5wTo/EymrlU71YQE+R1dR2fzN0ZxNeqeH1CEYK3RqceGiPyV+0N9Nl4=
X-Received: by 2002:a05:6512:1047:b0:479:7805:5f with SMTP id
 c7-20020a056512104700b004797805005fmr5597065lfb.238.1655284091655; Wed, 15
 Jun 2022 02:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195223.473966-1-parav@nvidia.com>
In-Reply-To: <20220613195223.473966-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 15 Jun 2022 17:08:00 +0800
Message-ID: <CACGkMEt-m5D2pzAHoVqEU+EF49YXhT6gbb9QG+i3=qDm63j23g@mail.gmail.com>
Subject: Re: [PATCH v1] vduse: Tie vduse mgmtdev and its device
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Yongji Xie <xieyongji@bytedance.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 mst <mst@redhat.com>,
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

On Tue, Jun 14, 2022 at 3:52 AM Parav Pandit <parav@nvidia.com> wrote:
>
> vduse devices are not backed by any real devices such as PCI. Hence it
> doesn't have any parent device linked to it.
>
> Kernel driver model in [1] suggests to avoid an empty device
> release callback.
>
> Hence tie the mgmtdevice object's life cycle to an allocate dummy struct
> device instead of static one.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/core-api/kobject.rst?h=v5.18-rc7#n284
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> changelog:
> v0->v1:
> - removed typo in device name of "-la"
> ---
>  drivers/vdpa/vdpa_user/vduse_dev.c | 60 ++++++++++++++++++------------
>  1 file changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 776ad7496f53..3bc27de58f46 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1476,16 +1476,12 @@ static char *vduse_devnode(struct device *dev, umode_t *mode)
>         return kasprintf(GFP_KERNEL, "vduse/%s", dev_name(dev));
>  }
>
> -static void vduse_mgmtdev_release(struct device *dev)
> -{
> -}
> -
> -static struct device vduse_mgmtdev = {
> -       .init_name = "vduse",
> -       .release = vduse_mgmtdev_release,
> +struct vduse_mgmt_dev {
> +       struct vdpa_mgmt_dev mgmt_dev;
> +       struct device dev;
>  };
>
> -static struct vdpa_mgmt_dev mgmt_dev;
> +static struct vduse_mgmt_dev *vduse_mgmt;
>
>  static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  {
> @@ -1510,7 +1506,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>         }
>         set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
>         vdev->vdpa.dma_dev = &vdev->vdpa.dev;
> -       vdev->vdpa.mdev = &mgmt_dev;
> +       vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
>
>         return 0;
>  }
> @@ -1556,34 +1552,52 @@ static struct virtio_device_id id_table[] = {
>         { 0 },
>  };
>
> -static struct vdpa_mgmt_dev mgmt_dev = {
> -       .device = &vduse_mgmtdev,
> -       .id_table = id_table,
> -       .ops = &vdpa_dev_mgmtdev_ops,
> -};
> +static void vduse_mgmtdev_release(struct device *dev)
> +{
> +       struct vduse_mgmt_dev *mgmt_dev;
> +
> +       mgmt_dev = container_of(dev, struct vduse_mgmt_dev, dev);
> +       kfree(mgmt_dev);
> +}
>
>  static int vduse_mgmtdev_init(void)
>  {
>         int ret;
>
> -       ret = device_register(&vduse_mgmtdev);
> -       if (ret)
> +       vduse_mgmt = kzalloc(sizeof(*vduse_mgmt), GFP_KERNEL);
> +       if (!vduse_mgmt)
> +               return -ENOMEM;
> +
> +       ret = dev_set_name(&vduse_mgmt->dev, "vduse");
> +       if (ret) {
> +               kfree(vduse_mgmt);
>                 return ret;
> +       }
>
> -       ret = vdpa_mgmtdev_register(&mgmt_dev);
> +       vduse_mgmt->dev.release = vduse_mgmtdev_release;
> +
> +       ret = device_register(&vduse_mgmt->dev);
>         if (ret)
> -               goto err;
> +               goto dev_reg_err;
>
> -       return 0;
> -err:
> -       device_unregister(&vduse_mgmtdev);
> +       vduse_mgmt->mgmt_dev.id_table = id_table;
> +       vduse_mgmt->mgmt_dev.ops = &vdpa_dev_mgmtdev_ops;
> +       vduse_mgmt->mgmt_dev.device = &vduse_mgmt->dev;
> +       ret = vdpa_mgmtdev_register(&vduse_mgmt->mgmt_dev);
> +       if (ret)
> +               device_unregister(&vduse_mgmt->dev);
> +
> +       return ret;
> +
> +dev_reg_err:
> +       put_device(&vduse_mgmt->dev);
>         return ret;
>  }
>
>  static void vduse_mgmtdev_exit(void)
>  {
> -       vdpa_mgmtdev_unregister(&mgmt_dev);
> -       device_unregister(&vduse_mgmtdev);
> +       vdpa_mgmtdev_unregister(&vduse_mgmt->mgmt_dev);
> +       device_unregister(&vduse_mgmt->dev);
>  }
>
>  static int vduse_init(void)
> --
> 2.26.2
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
