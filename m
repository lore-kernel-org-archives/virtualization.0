Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA55C433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 05:48:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6230C8272D;
	Tue, 21 Dec 2021 05:48:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iZqth7yAFpCd; Tue, 21 Dec 2021 05:48:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6EEA881AAD;
	Tue, 21 Dec 2021 05:48:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC50C001E;
	Tue, 21 Dec 2021 05:48:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4EA9C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:48:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C458F8272A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TImHnzLKm9jW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:48:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1787981AAD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 05:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640065709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZvOlPbNTjKYIXfMM3mQ5/fn6kX51ogUC44L1D2nGfg=;
 b=euFPmH+KswxeUrVjHtd859U6hyg8rm7hqi2N6GIAHQVPgsYvL3Rphj8VkGq3kFds6BzzWH
 Av35ywCCj1XQ0X9B2c2mAMeNsYf5Db5AMu7QWabLuDcaQIpLjfSA+CrKMpqPDf1uNQrx6e
 c68XEq6TvuycM5OIilbkicVHQ93XWMI=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-3dLFafnvPtO-UrfxY1aYjw-1; Tue, 21 Dec 2021 00:48:27 -0500
X-MC-Unique: 3dLFafnvPtO-UrfxY1aYjw-1
Received: by mail-lf1-f72.google.com with SMTP id
 h7-20020ac24da7000000b0042521f16f1fso5699199lfe.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 21:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aZvOlPbNTjKYIXfMM3mQ5/fn6kX51ogUC44L1D2nGfg=;
 b=7LS5QqcXXEkyX639LHTIPAG6r0Xq/lqBOeBQZ73rJTQtBhf9plTLwCAv7iyBW30dcM
 /mFOJmr+SfcxgXBgcqEOnomSZbq21PwN0N+909AUV7zLhv290Z7U/RukRImdIebNKZWP
 6fgxsSkWHWtVpHiLmgyC4y5SVq1cJryMUMSmcRjp7nyezMfweyhxu2l+a2auvuv1lDT2
 AhjMBi7ng3C90EGLKQwMoID7x8W/6nWCF6iEdc5QIkEVvqkkFxU3cHF7xn8pA7WvO15/
 ZU+KxTAfFHuO+WjPpfWwr1TvawKVTS5Kwt27Tx+tlXXNRgT5eyHmRgSA4oMIRbf/ty9k
 bfEg==
X-Gm-Message-State: AOAM530gC82wW6IvZ4svn0JDNJujnysUzuZtGqoOcVJ1nwPW2z+A98us
 zfGOpln4ZNKVXNM+EGMcNi9URggzklwyXmDWHJ2XfQQuygry0S8guFzaAgpGDa8i0PdDKU48mAh
 T4VHkcZDiBAQPAr6Evw7LkWjK5p6I7M6ero4mWkZJCtMwnq5sEbH8p9Oc9w==
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr1670744lfm.580.1640065706222; 
 Mon, 20 Dec 2021 21:48:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJfHmOqmMYTfZs79ar5jfBstfJdCm9i5fAtnFSPiI3CWn7bKPjoeeZDbUfeaTwvtfgAhhbYJMlol94yrlr8Go=
X-Received: by 2002:ac2:52a3:: with SMTP id r3mr1670728lfm.580.1640065705902; 
 Mon, 20 Dec 2021 21:48:25 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-2-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 13:48:14 +0800
Message-ID: <CACGkMEtBs4iDEEzg6Xii8yZybScnHaK3tJBaEYkZZ-CJLL9Ddw@mail.gmail.com>
Subject: Re: [PATCH v3 01/10] vdpa: Provide interface to read driver features
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>
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

On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Provide an interface to read the negotiated features. This is needed
> when building the netlink message in vdpa_dev_net_config_fill().
>
> Also fix the implementation of vdpa_dev_net_config_fill() to use the
> negotiated features instead of the device features.
>
> To make APIs clearer, make the following name changes to struct
> vdpa_config_ops so they better describe their operations:
>
> get_features -> get_device_features
> set_features -> set_driver_features
>
> Finally, add get_driver_features to return the negotiated features and
> add implementation to all the upstream drivers.
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
>  drivers/vdpa/alibaba/eni_vdpa.c    | 16 ++++++++++++----
>  drivers/vdpa/ifcvf/ifcvf_main.c    | 16 ++++++++++++----
>  drivers/vdpa/mlx5/net/mlx5_vnet.c  | 16 ++++++++++++----
>  drivers/vdpa/vdpa.c                |  2 +-
>  drivers/vdpa/vdpa_sim/vdpa_sim.c   | 21 +++++++++++++++------
>  drivers/vdpa/vdpa_user/vduse_dev.c | 16 ++++++++++++----
>  drivers/vdpa/virtio_pci/vp_vdpa.c  | 16 ++++++++++++----
>  drivers/vhost/vdpa.c               |  2 +-
>  drivers/virtio/virtio_vdpa.c       |  2 +-
>  include/linux/vdpa.h               | 14 +++++++++-----
>  10 files changed, 87 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/vdpa/alibaba/eni_vdpa.c b/drivers/vdpa/alibaba/eni_vdpa.c
> index fe1b83b5f80d..f480d54f308c 100644
> --- a/drivers/vdpa/alibaba/eni_vdpa.c
> +++ b/drivers/vdpa/alibaba/eni_vdpa.c
> @@ -58,7 +58,7 @@ static struct virtio_pci_legacy_device *vdpa_to_ldev(struct vdpa_device *vdpa)
>         return &eni_vdpa->ldev;
>  }
>
> -static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
> +static u64 eni_vdpa_get_device_features(struct vdpa_device *vdpa)
>  {
>         struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>         u64 features = vp_legacy_get_features(ldev);
> @@ -69,7 +69,7 @@ static u64 eni_vdpa_get_features(struct vdpa_device *vdpa)
>         return features;
>  }
>
> -static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +static int eni_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>  {
>         struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
>
> @@ -84,6 +84,13 @@ static int eni_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>         return 0;
>  }
>
> +static u64 eni_vdpa_get_driver_features(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> +
> +       return vp_legacy_get_driver_features(ldev);
> +}
> +
>  static u8 eni_vdpa_get_status(struct vdpa_device *vdpa)
>  {
>         struct virtio_pci_legacy_device *ldev = vdpa_to_ldev(vdpa);
> @@ -401,8 +408,9 @@ static void eni_vdpa_set_config_cb(struct vdpa_device *vdpa,
>  }
>
>  static const struct vdpa_config_ops eni_vdpa_ops = {
> -       .get_features   = eni_vdpa_get_features,
> -       .set_features   = eni_vdpa_set_features,
> +       .get_device_features = eni_vdpa_get_device_features,
> +       .set_driver_features = eni_vdpa_set_driver_features,
> +       .get_driver_features = eni_vdpa_get_driver_features,
>         .get_status     = eni_vdpa_get_status,
>         .set_status     = eni_vdpa_set_status,
>         .reset          = eni_vdpa_reset,
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index 92ba7126e5d6..d1a6b5ab543c 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -169,7 +169,7 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
>         return &adapter->vf;
>  }
>
> -static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
> +static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
>  {
>         struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
>         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> @@ -187,7 +187,7 @@ static u64 ifcvf_vdpa_get_features(struct vdpa_device *vdpa_dev)
>         return features;
>  }
>
> -static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
> +static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 features)
>  {
>         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
>         int ret;
> @@ -201,6 +201,13 @@ static int ifcvf_vdpa_set_features(struct vdpa_device *vdpa_dev, u64 features)
>         return 0;
>  }
>
> +static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
> +{
> +       struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> +
> +       return vf->req_features;
> +}
> +
>  static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
>  {
>         struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
> @@ -426,8 +433,9 @@ static struct vdpa_notification_area ifcvf_get_vq_notification(struct vdpa_devic
>   * implemented set_map()/dma_map()/dma_unmap()
>   */
>  static const struct vdpa_config_ops ifc_vdpa_ops = {
> -       .get_features   = ifcvf_vdpa_get_features,
> -       .set_features   = ifcvf_vdpa_set_features,
> +       .get_device_features = ifcvf_vdpa_get_device_features,
> +       .set_driver_features = ifcvf_vdpa_set_driver_features,
> +       .get_driver_features = ifcvf_vdpa_get_driver_features,
>         .get_status     = ifcvf_vdpa_get_status,
>         .set_status     = ifcvf_vdpa_set_status,
>         .reset          = ifcvf_vdpa_reset,
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index d8e69340a25a..14b972360a1a 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -1880,7 +1880,7 @@ static u64 mlx_to_vritio_features(u16 dev_features)
>         return result;
>  }
>
> -static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> +static u64 mlx5_vdpa_get_device_features(struct vdpa_device *vdev)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> @@ -1973,7 +1973,7 @@ static void update_cvq_info(struct mlx5_vdpa_dev *mvdev)
>         }
>  }
>
> -static int mlx5_vdpa_set_features(struct vdpa_device *vdev, u64 features)
> +static int mlx5_vdpa_set_driver_features(struct vdpa_device *vdev, u64 features)
>  {
>         struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>         struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> @@ -2340,6 +2340,13 @@ static int mlx5_get_vq_irq(struct vdpa_device *vdv, u16 idx)
>         return -EOPNOTSUPP;
>  }
>
> +static u64 mlx5_vdpa_get_driver_features(struct vdpa_device *vdev)
> +{
> +       struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> +
> +       return mvdev->actual_features;
> +}
> +
>  static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .set_vq_address = mlx5_vdpa_set_vq_address,
>         .set_vq_num = mlx5_vdpa_set_vq_num,
> @@ -2352,8 +2359,9 @@ static const struct vdpa_config_ops mlx5_vdpa_ops = {
>         .get_vq_notification = mlx5_get_vq_notification,
>         .get_vq_irq = mlx5_get_vq_irq,
>         .get_vq_align = mlx5_vdpa_get_vq_align,
> -       .get_features = mlx5_vdpa_get_features,
> -       .set_features = mlx5_vdpa_set_features,
> +       .get_device_features = mlx5_vdpa_get_device_features,
> +       .set_driver_features = mlx5_vdpa_set_driver_features,
> +       .get_driver_features = mlx5_vdpa_get_driver_features,
>         .set_config_cb = mlx5_vdpa_set_config_cb,
>         .get_vq_num_max = mlx5_vdpa_get_vq_num_max,
>         .get_device_id = mlx5_vdpa_get_device_id,
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 59d0b8bbb79c..42d71d60d5dc 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -808,7 +808,7 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
>         if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
>                 return -EMSGSIZE;
>
> -       features = vdev->config->get_features(vdev);
> +       features = vdev->config->get_driver_features(vdev);
>
>         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
>  }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 41b0cd17fcba..ddbe142af09a 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -399,14 +399,14 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>         return VDPASIM_QUEUE_ALIGN;
>  }
>
> -static u64 vdpasim_get_features(struct vdpa_device *vdpa)
> +static u64 vdpasim_get_device_features(struct vdpa_device *vdpa)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
>         return vdpasim->dev_attr.supported_features;
>  }
>
> -static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> +static int vdpasim_set_driver_features(struct vdpa_device *vdpa, u64 features)
>  {
>         struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> @@ -419,6 +419,13 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>         return 0;
>  }
>
> +static u64 vdpasim_get_driver_features(struct vdpa_device *vdpa)
> +{
> +       struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +
> +       return vdpasim->features;
> +}
> +
>  static void vdpasim_set_config_cb(struct vdpa_device *vdpa,
>                                   struct vdpa_callback *cb)
>  {
> @@ -613,8 +620,9 @@ static const struct vdpa_config_ops vdpasim_config_ops = {
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
>         .get_vq_align           = vdpasim_get_vq_align,
> -       .get_features           = vdpasim_get_features,
> -       .set_features           = vdpasim_set_features,
> +       .get_device_features    = vdpasim_get_device_features,
> +       .set_driver_features    = vdpasim_set_driver_features,
> +       .get_driver_features    = vdpasim_get_driver_features,
>         .set_config_cb          = vdpasim_set_config_cb,
>         .get_vq_num_max         = vdpasim_get_vq_num_max,
>         .get_device_id          = vdpasim_get_device_id,
> @@ -642,8 +650,9 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>         .set_vq_state           = vdpasim_set_vq_state,
>         .get_vq_state           = vdpasim_get_vq_state,
>         .get_vq_align           = vdpasim_get_vq_align,
> -       .get_features           = vdpasim_get_features,
> -       .set_features           = vdpasim_set_features,
> +       .get_device_features    = vdpasim_get_device_features,
> +       .set_driver_features    = vdpasim_set_driver_features,
> +       .get_driver_features    = vdpasim_get_driver_features,
>         .set_config_cb          = vdpasim_set_config_cb,
>         .get_vq_num_max         = vdpasim_get_vq_num_max,
>         .get_device_id          = vdpasim_get_device_id,
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f3cc7dde39af..f85d1a08ed87 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -573,14 +573,14 @@ static u32 vduse_vdpa_get_vq_align(struct vdpa_device *vdpa)
>         return dev->vq_align;
>  }
>
> -static u64 vduse_vdpa_get_features(struct vdpa_device *vdpa)
> +static u64 vduse_vdpa_get_device_features(struct vdpa_device *vdpa)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>
>         return dev->device_features;
>  }
>
> -static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +static int vduse_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>  {
>         struct vduse_dev *dev = vdpa_to_vduse(vdpa);
>
> @@ -588,6 +588,13 @@ static int vduse_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>         return 0;
>  }
>
> +static u64 vduse_vdpa_get_driver_features(struct vdpa_device *vdpa)
> +{
> +       struct vduse_dev *dev = vdpa_to_vduse(vdpa);
> +
> +       return dev->driver_features;
> +}
> +
>  static void vduse_vdpa_set_config_cb(struct vdpa_device *vdpa,
>                                   struct vdpa_callback *cb)
>  {
> @@ -721,8 +728,9 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>         .set_vq_state           = vduse_vdpa_set_vq_state,
>         .get_vq_state           = vduse_vdpa_get_vq_state,
>         .get_vq_align           = vduse_vdpa_get_vq_align,
> -       .get_features           = vduse_vdpa_get_features,
> -       .set_features           = vduse_vdpa_set_features,
> +       .get_device_features    = vduse_vdpa_get_device_features,
> +       .set_driver_features    = vduse_vdpa_set_driver_features,
> +       .get_driver_features    = vduse_vdpa_get_driver_features,
>         .set_config_cb          = vduse_vdpa_set_config_cb,
>         .get_vq_num_max         = vduse_vdpa_get_vq_num_max,
>         .get_device_id          = vduse_vdpa_get_device_id,
> diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
> index e3ff7875e123..a57e381e830b 100644
> --- a/drivers/vdpa/virtio_pci/vp_vdpa.c
> +++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
> @@ -53,14 +53,14 @@ static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
>         return &vp_vdpa->mdev;
>  }
>
> -static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> +static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>
>         return vp_modern_get_features(mdev);
>  }
>
> -static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
>  {
>         struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
>
> @@ -69,6 +69,13 @@ static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
>         return 0;
>  }
>
> +static u64 vp_vdpa_get_driver_features(struct vdpa_device *vdpa)
> +{
> +       struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> +
> +       return vp_modern_get_driver_features(mdev);
> +}
> +
>  static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
>  {
>         struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
> @@ -415,8 +422,9 @@ vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
>  }
>
>  static const struct vdpa_config_ops vp_vdpa_ops = {
> -       .get_features   = vp_vdpa_get_features,
> -       .set_features   = vp_vdpa_set_features,
> +       .get_device_features = vp_vdpa_get_device_features,
> +       .set_driver_features = vp_vdpa_set_driver_features,
> +       .get_driver_features = vp_vdpa_get_driver_features,
>         .get_status     = vp_vdpa_get_status,
>         .set_status     = vp_vdpa_set_status,
>         .reset          = vp_vdpa_reset,
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ed2aabf07e74..ebaa373e9b82 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -262,7 +262,7 @@ static long vhost_vdpa_get_features(struct vhost_vdpa *v, u64 __user *featurep)
>         const struct vdpa_config_ops *ops = vdpa->config;
>         u64 features;
>
> -       features = ops->get_features(vdpa);
> +       features = ops->get_device_features(vdpa);
>
>         if (copy_to_user(featurep, &features, sizeof(features)))
>                 return -EFAULT;
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index f85f860bc10b..a84b04ba3195 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -308,7 +308,7 @@ static u64 virtio_vdpa_get_features(struct virtio_device *vdev)
>         struct vdpa_device *vdpa = vd_get_vdpa(vdev);
>         const struct vdpa_config_ops *ops = vdpa->config;
>
> -       return ops->get_features(vdpa);
> +       return ops->get_device_features(vdpa);
>  }
>
>  static int virtio_vdpa_finalize_features(struct virtio_device *vdev)
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2b7db96bb7d3..9cc4291a79b3 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -171,14 +171,17 @@ struct vdpa_map_file {
>   *                             for the device
>   *                             @vdev: vdpa device
>   *                             Returns virtqueue algin requirement
> - * @get_features:              Get virtio features supported by the device
> + * @get_device_features:       Get virtio features supported by the device
>   *                             @vdev: vdpa device
>   *                             Returns the virtio features support by the
>   *                             device
> - * @set_features:              Set virtio features supported by the driver
> + * @set_driver_features:       Set virtio features supported by the driver
>   *                             @vdev: vdpa device
>   *                             @features: feature support by the driver
>   *                             Returns integer: success (0) or error (< 0)
> + * @get_driver_features:       Get the virtio driver features in action
> + *                             @vdev: vdpa device
> + *                             Returns the virtio features accepted
>   * @set_config_cb:             Set the config interrupt callback
>   *                             @vdev: vdpa device
>   *                             @cb: virtio-vdev interrupt callback structure
> @@ -278,8 +281,9 @@ struct vdpa_config_ops {
>
>         /* Device ops */
>         u32 (*get_vq_align)(struct vdpa_device *vdev);
> -       u64 (*get_features)(struct vdpa_device *vdev);
> -       int (*set_features)(struct vdpa_device *vdev, u64 features);
> +       u64 (*get_device_features)(struct vdpa_device *vdev);
> +       int (*set_driver_features)(struct vdpa_device *vdev, u64 features);
> +       u64 (*get_driver_features)(struct vdpa_device *vdev);
>         void (*set_config_cb)(struct vdpa_device *vdev,
>                               struct vdpa_callback *cb);
>         u16 (*get_vq_num_max)(struct vdpa_device *vdev);
> @@ -397,7 +401,7 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
>         const struct vdpa_config_ops *ops = vdev->config;
>
>         vdev->features_valid = true;
> -       return ops->set_features(vdev, features);
> +       return ops->set_driver_features(vdev, features);
>  }
>
>  void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
