Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25DFC4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Oct 2022 05:21:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5EC0C60C21;
	Thu, 20 Oct 2022 05:21:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EC0C60C21
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c3egPLaV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CA_hKzPMWXKy; Thu, 20 Oct 2022 05:21:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C530B60C18;
	Thu, 20 Oct 2022 05:21:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C530B60C18
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CDF0C0032;
	Thu, 20 Oct 2022 05:21:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6ED74C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:21:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4020A419E4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:21:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4020A419E4
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c3egPLaV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FsLk-TIOI4IV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:21:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA18A41832
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EA18A41832
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Oct 2022 05:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1666243270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cMRnDVkkHrRATkyUUGvXO7i/mb4rsqNqRwJLsH3u3Y0=;
 b=c3egPLaVslc5DnJF6jilsj6zz8fiXD3GDmtmKui6Ye6V/2UvPDCixprOC/kmqgxOEwKY+W
 humGtel1ePdyDfdx8RedcR3HHPKJiDb8VZkjiERdEWCe0s4AL5T04mY0HSkyL6Pdnz7yhP
 MgN5SjXOMi/GWm6ulAxGmxTTUD39NSQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-583-rdHVnFKTNQCx0lxd8ciZNA-1; Thu, 20 Oct 2022 01:21:09 -0400
X-MC-Unique: rdHVnFKTNQCx0lxd8ciZNA-1
Received: by mail-oi1-f200.google.com with SMTP id
 j8-20020a056808118800b00354b7e75b46so8394978oil.16
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Oct 2022 22:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cMRnDVkkHrRATkyUUGvXO7i/mb4rsqNqRwJLsH3u3Y0=;
 b=CGRWqxXoUasqaJksnSyxceVh8fk6FwoYd1QBMSHyYpDdeUcOBzUVXls+YMxNCfQ9l6
 NKPDGT9gO5GFK1uZ0UbYdGnHgi1b1ZaaepwbP4qR6voA1kdsB2BhutpxeV9ubF9rfraS
 ZiAWOzYM6nMNZLp6MgJS6HiQn/7P4txX933JiPx21lz8rEkWgnGOwWxf7iLvs1zOoTbx
 LTSe98YsUjf+CNi0Y5qBAwVelMUAHyoTbzWMg2t7tMjoX0bP+p3tQ1U4fXhXN3R9ZPDY
 FwtESGqq05AN/NBhw2HONx84QE+gf/moNZQFggQJ4DESzilWaS0mnzm3Vagrlmu8nJ2v
 3X8Q==
X-Gm-Message-State: ACrzQf2gNx2XJGxkcf6rU5q62e+fdsUdl5u7ryh+ugLmWSmn6ETVvu7I
 p2wA4NID5hnDMQu2b6W4udQcyCAFd3ACx5ggSX3mPcGebPgCVsPruhb/Pz//88U6oAcZPCm3W6Y
 MECmUOSrnNg6EKohPZzmN5zMmplfGFXHyMZkGo7EX5FegIaFVGy2B6EW77w==
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr23554989oad.35.1666243268867; 
 Wed, 19 Oct 2022 22:21:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5WFeAg8gtVjAHKHu2BXh++BG3P1CkS/fEqwi4vYMcKgIdXA3/UkcZKvM4yHhp0p0fkJYgaA9UvDjkLaRclsHA=
X-Received: by 2002:a05:6870:c1d3:b0:136:c4f6:53af with SMTP id
 i19-20020a056870c1d300b00136c4f653afmr23554975oad.35.1666243268627; Wed, 19
 Oct 2022 22:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <1666137032-28192-1-git-send-email-si-wei.liu@oracle.com>
 <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1666137032-28192-3-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Oct 2022 13:20:57 +0800
Message-ID: <CACGkMEuT7O1xLrB9=eYHAtuHYdwbNXxqtC+Mh4qkWSkLM+QTjg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] vdpa: pass initial config to
 _vdpa_register_device()
To: Si-Wei Liu <si-wei.liu@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Wed, Oct 19, 2022 at 8:56 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
> Just as _vdpa_register_device taking @nvqs as the number of queues

I wonder if it's better to embed nvqs in the config structure.

> to feed userspace inquery via vdpa_dev_fill(), we can follow the
> same to stash config attributes in struct vdpa_device at the time
> of vdpa registration.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  2 +-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  2 +-
>  drivers/vdpa/vdpa.c                  | 15 +++++++++++----
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  2 +-
>  drivers/vdpa/virtio_pci/vp_vdpa.c    |  3 ++-
>  include/linux/vdpa.h                 |  3 ++-
>  8 files changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index f9c0044..c54ab2c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -771,7 +771,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         else
>                 ret = dev_set_name(&vdpa_dev->dev, "vdpa%u", vdpa_dev->index);
>
> -       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring);
> +       ret = _vdpa_register_device(&adapter->vdpa, vf->nr_vring, config);
>         if (ret) {
>                 put_device(&adapter->vdpa.dev);
>                 IFCVF_ERR(pdev, "Failed to register to vDPA bus");
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 9091336..376082e 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -3206,7 +3206,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         mlx5_notifier_register(mdev, &ndev->nb);
>         ndev->nb_registered = true;
>         mvdev->vdev.mdev = &mgtdev->mgtdev;
> -       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1);
> +       err = _vdpa_register_device(&mvdev->vdev, max_vqs + 1, add_config);
>         if (err)
>                 goto err_reg;
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index febdc99..566c1c6 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -215,11 +215,16 @@ static int vdpa_name_match(struct device *dev, const void *data)
>         return (strcmp(dev_name(&vdev->dev), data) == 0);
>  }
>
> -static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs)
> +static int __vdpa_register_device(struct vdpa_device *vdev, u32 nvqs,
> +                                 const struct vdpa_dev_set_config *cfg)
>  {
>         struct device *dev;
>
>         vdev->nvqs = nvqs;
> +       if (cfg)
> +               vdev->vdev_cfg = *cfg;
> +       else
> +               vdev->vdev_cfg.mask = 0ULL;

I think it would be nice if we can convert eni to use netlink then we
don't need any workaround like this.

Thanks

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
