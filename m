Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182E5C433EF
	for <virtualization@archiver.kernel.org>; Wed,  8 Jun 2022 08:14:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1B0240B7A;
	Wed,  8 Jun 2022 08:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qVloaSu1uM-0; Wed,  8 Jun 2022 08:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C27440B6D;
	Wed,  8 Jun 2022 08:14:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E74F8C0039;
	Wed,  8 Jun 2022 08:14:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 152FAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 046B7419CC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:14:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGtiktoFe86v
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCB71415FC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Jun 2022 08:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1654676086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1e5tD9PXzjV3+S+uI6hDOQFK0Opxb+SNgCa3LEsZqe8=;
 b=QR7nHc2PO4OfxQj5CR81OFj6VuPFNtmmsYmnMp2HUEaektgHCkHqhn360Fmt84YlgJP7Mr
 aAePq/PbWacS2FDUt54t4lIKrFdCMCwIRdkAlnfLX/gZPA5FP2EbyjUCtMCz8U+wWfrsn1
 EHf8ube9yUMgeGUYowmSBk3BNQqdEpE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-MOzfYfDyPMiJQGA38toE0w-1; Wed, 08 Jun 2022 04:14:45 -0400
X-MC-Unique: MOzfYfDyPMiJQGA38toE0w-1
Received: by mail-lf1-f69.google.com with SMTP id
 u7-20020a05651206c700b00479723664a9so1544728lff.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Jun 2022 01:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1e5tD9PXzjV3+S+uI6hDOQFK0Opxb+SNgCa3LEsZqe8=;
 b=sBqotTlW9SaMPFEOcpfkxshZXnZPTwOmPzw71oNBUbUX3tOjeLMfedql46XRwon48L
 czrU0udnT136SYf9nau6Inxdc1PIjLwC0raFiEDs4BV92iG/xw2z4Xdy5ZWIefwUpY2X
 YGA/U0i7L7oprigys0gnmtKfWv4LOK0W24Ph1P6WOllcrIgDi37V7QfvEHkXZr78oAV8
 zeEj3YJAln9AucJjTZ6BpGKy/TOlxCjsuf4G9kQTBDBKK79U74Sp6jfdY1t5wCSdCujH
 V2Fr6brclIBEzeB9RGUrqWUsRXpjpF+PnFvHCic+ObtQcoc9kYjKcNBVuhVQWj8nb14G
 qC4A==
X-Gm-Message-State: AOAM530egl2RHcagA9gHb9sxG9DVjDhGH+O69ORVz8ZISlqlIhDHiIV1
 MtMU755GKVRP35/UGVd6O7W0r0mSDR3JNcTbcpaiUBYI1QMscufQScGl2uomEum2uaFbtgyhEha
 TX7Pcw5mTFPaK3xe6PUwoX3H7UZBQMQX+R2XN6IvSzxC1FzTkLFnLXDnY/g==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54621250ljf.243.1654676083978; 
 Wed, 08 Jun 2022 01:14:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJOxxSMrbtrTLofBGIwZnPJwuN96zsC+6yUe+kAzCdIU5VLqefF45AdRHmWtf3v49sWuUXCqibNWV7P+HNoAA=
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id
 b5-20020a2ebc05000000b0024b212d7521mr54621233ljf.243.1654676083698; Wed, 08
 Jun 2022 01:14:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220603103356.26564-1-gautam.dawar@amd.com>
In-Reply-To: <20220603103356.26564-1-gautam.dawar@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 8 Jun 2022 16:14:32 +0800
Message-ID: <CACGkMEs38ycmAaDc48_rt5BeBHq4tzKH39gj=KczYFQC16ns5Q@mail.gmail.com>
Subject: Re: [PATCH] vdpa: allow vdpa dev_del management operation to return
 failure
To: Gautam Dawar <gautam.dawar@amd.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, Wan Jiabing <wanjiabing@vivo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-net-drivers@amd.com,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Xie Yongji <xieyongji@bytedance.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 hanand@amd.com, Dan Carpenter <dan.carpenter@oracle.com>
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

Hi Gautam:

On Fri, Jun 3, 2022 at 6:34 PM Gautam Dawar <gautam.dawar@amd.com> wrote:
>
> Currently, the vdpa_nl_cmd_dev_del_set_doit() implementation allows
> returning a value to depict the operation status but the return type
> of dev_del() callback is void. So, any error while deleting the vdpa
> device in the vdpa parent driver can't be returned to the management
> layer.

I wonder under which cognition we can hit an error in dev_del()?

Thanks

> This patch changes the return type of dev_del() callback to int to
> allow returning an error code in case of failure.
>
> Signed-off-by: Gautam Dawar <gautam.dawar@amd.com>
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
>  drivers/vdpa/vdpa.c                  | 11 ++++++++---
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
>  include/linux/vdpa.h                 |  5 +++--
>  7 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 4366320fb68d..6a967935478b 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -800,13 +800,14 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         return ret;
>  }
>
> -static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
> +static int ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
>  {
>         struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>
>         ifcvf_mgmt_dev = container_of(mdev, struct ifcvf_vdpa_mgmt_dev, mdev);
>         _vdpa_unregister_device(dev);
>         ifcvf_mgmt_dev->adapter = NULL;
> +       return 0;
>  }
>
>  static const struct vdpa_mgmtdev_ops ifcvf_vdpa_mgmt_dev_ops = {
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index e0de44000d92..b06204c2f3e8 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2775,7 +2775,7 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
>         return err;
>  }
>
> -static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
> +static int mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *dev)
>  {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(dev);
> @@ -2788,6 +2788,7 @@ static void mlx5_vdpa_dev_del(struct vdpa_mgmt_dev *v_mdev, struct vdpa_device *
>         destroy_workqueue(wq);
>         _vdpa_unregister_device(dev);
>         mgtdev->ndev = NULL;
> +       return 0;
>  }
>
>  static const struct vdpa_mgmtdev_ops mdev_ops = {
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 2b75c00b1005..65dc8bf2f37f 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -363,10 +363,11 @@ static int vdpa_match_remove(struct device *dev, void *data)
>  {
>         struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
>         struct vdpa_mgmt_dev *mdev = vdev->mdev;
> +       int err = 0;
>
>         if (mdev == data)
> -               mdev->ops->dev_del(mdev, vdev);
> -       return 0;
> +               err = mdev->ops->dev_del(mdev, vdev);
> +       return err;
>  }
>
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev)
> @@ -673,7 +674,11 @@ static int vdpa_nl_cmd_dev_del_set_doit(struct sk_buff *skb, struct genl_info *i
>                 goto mdev_err;
>         }
>         mdev = vdev->mdev;
> -       mdev->ops->dev_del(mdev, vdev);
> +       err = mdev->ops->dev_del(mdev, vdev);
> +       if (err) {
> +               NL_SET_ERR_MSG_MOD(info->extack, "ops->dev_del failed");
> +               goto dev_err;
> +       }
>  mdev_err:
>         put_device(dev);
>  dev_err:
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 42d401d43911..443d4b94268f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -280,12 +280,13 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         return ret;
>  }
>
> -static void vdpasim_blk_dev_del(struct vdpa_mgmt_dev *mdev,
> +static int vdpasim_blk_dev_del(struct vdpa_mgmt_dev *mdev,
>                                 struct vdpa_device *dev)
>  {
>         struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
>
>         _vdpa_unregister_device(&simdev->vdpa);
> +       return 0;
>  }
>
>  static const struct vdpa_mgmtdev_ops vdpasim_blk_mgmtdev_ops = {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index d5324f6fd8c7..9e5a5ad34e65 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -167,12 +167,13 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         return ret;
>  }
>
> -static void vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
> +static int vdpasim_net_dev_del(struct vdpa_mgmt_dev *mdev,
>                                 struct vdpa_device *dev)
>  {
>         struct vdpasim *simdev = container_of(dev, struct vdpasim, vdpa);
>
>         _vdpa_unregister_device(&simdev->vdpa);
> +       return 0;
>  }
>
>  static const struct vdpa_mgmtdev_ops vdpasim_net_mgmtdev_ops = {
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f85d1a08ed87..33ff45e70ff7 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1540,9 +1540,10 @@ static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
>         return 0;
>  }
>
> -static void vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
> +static int vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
>  {
>         _vdpa_unregister_device(dev);
> +       return 0;
>  }
>
>  static const struct vdpa_mgmtdev_ops vdpa_dev_mgmtdev_ops = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 8943a209202e..e547c9dfdfce 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -443,12 +443,13 @@ void vdpa_set_status(struct vdpa_device *vdev, u8 status);
>   *          @mdev: parent device to use for device removal
>   *          @dev: vdpa device to remove
>   *          Driver need to remove the specified device by calling
> - *          _vdpa_unregister_device().
> + *          _vdpa_unregister_device(). Driver must return 0
> + *          on success or appropriate error code in failure case.
>   */
>  struct vdpa_mgmtdev_ops {
>         int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
>                        const struct vdpa_dev_set_config *config);
> -       void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
> +       int (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
>  };
>
>  /**
> --
> 2.30.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
