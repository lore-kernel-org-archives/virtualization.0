Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7537FC433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:48:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2497060238
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2497060238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EECFA81006;
	Tue, 26 Oct 2021 02:48:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xcUZXiCelX06; Tue, 26 Oct 2021 02:48:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6900580FFF;
	Tue, 26 Oct 2021 02:48:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41084C0019;
	Tue, 26 Oct 2021 02:48:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D52EC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7FB87608B7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mmi9LZ2-BUUa
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:48:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 83B35608AE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635216491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWkS4uJ7s3e3GZbcs+/iDh4vHlHehL1WtKbFYMlbLts=;
 b=GD92MvKdYvto5BTr5HSSD6zsPlpD/cGC2n2VpF1FzU242Cb07oqqpm+O1ECd84qCJt3M8L
 H9eF89837rNCja1bRYxpSZ50CtFRc5WDLeHkRbb42M5/iJxYFmG9m+fLe3j20r4nF4iUZt
 KdOscVuJgTa0Lwt+Vcb9vNuyqGMFDyY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-SjlMFOfaMYuRso66weppxA-1; Mon, 25 Oct 2021 22:48:10 -0400
X-MC-Unique: SjlMFOfaMYuRso66weppxA-1
Received: by mail-lj1-f200.google.com with SMTP id
 l22-20020a2e8696000000b0021174f030e5so1914977lji.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 19:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dWkS4uJ7s3e3GZbcs+/iDh4vHlHehL1WtKbFYMlbLts=;
 b=PrQlaovOKhimD+M5TwEZKi3H5sOft1Bmx4YVV9H/OUIbfb/Aubbl3d+NHYIK74z5Qp
 45ogRsUurPw58KO2eGR/A6/+G7rYKNSrUO1EL0fU80Cl8X/WJP8FmNz4KC4FGP2FlGz2
 H6Tndovc1LXKc+TVv+F2LFOtI8zMfhmh1PZgM1evWLN9hMUl46GG77SYHK7xj97LqtEy
 c/yCqffNDBfRtjN3dHfcn/qJCxb99X3+wyxnw4EJF2InNF3BCTArJbeulLgLb2CuZgfd
 27PHGI3wtpEsuz7D0/lAUTO0jC04JK8foxKnuWT+wiq9aKyjKU8Lj2o5Mrk52uRNpYnU
 KgjA==
X-Gm-Message-State: AOAM5339S0pH/a6D/5jHzWNs0pz+N/Wr3VwvfV6ULitGYczolBpkIcz+
 n/rpuIjNHEo1a4BxUe+n3IHEPqzWlfBa84a3oZxhYVHt3yO43ltUDz6LG6sC45BFznLHSJ0stOa
 EtJEeBu9mZAV/OkF7BvwqGDdfPTt8cNpDUROmfCpNPlR0/ZDqLDXcEwxOtw==
X-Received: by 2002:a2e:5344:: with SMTP id t4mr23052580ljd.362.1635216488072; 
 Mon, 25 Oct 2021 19:48:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVuwLbyUT/Ot9BnP7PdLYavd1CM21naobOwCxFzvOqVOqIcke3C6BoDp0rnFQMwTneikvMwlR69c8KQnVDONA=
X-Received: by 2002:a2e:5344:: with SMTP id t4mr23052553ljd.362.1635216487759; 
 Mon, 25 Oct 2021 19:48:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-5-parav@nvidia.com>
In-Reply-To: <20211025125316.67664-5-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 10:47:56 +0800
Message-ID: <CACGkMEuHgo2dexw8AenD-o29XgOxiUry2s7+isGbfjntPs9QLA@mail.gmail.com>
Subject: Re: [PATCH linux-next v5 4/8] vdpa: Enable user to set mac and mtu of
 vdpa device
To: Parav Pandit <parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Eli Cohen <elic@nvidia.com>, mst <mst@redhat.com>,
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

On Mon, Oct 25, 2021 at 8:53 PM Parav Pandit <parav@nvidia.com> wrote:
>
> $ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
> $ vdpa dev config show
> bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>
> $ vdpa dev config show -jp
> {
>     "config": {
>         "bar": {
>             "mac": "00:11:22:33:44:55",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 9000,
>         }
>     }
> }
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> changelog:
> v4->v5:
>  - added comment for checking device capabilities
> v3->v4:
>  - provide config attributes during device addition time
> ---
>  drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
>  drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
>  drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
>  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
>  drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
>  include/linux/vdpa.h                 | 17 ++++++++++++-
>  7 files changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
> index dcd648e1f7e7..6dc75ca70b37 100644
> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
> @@ -499,7 +499,8 @@ static u32 get_dev_type(struct pci_dev *pdev)
>         return dev_type;
>  }
>
> -static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> +static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> +                             const struct vdpa_dev_set_config *config)
>  {
>         struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
>         struct ifcvf_adapter *adapter;
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index b5bd1a553256..6bbdc0ece707 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -2482,7 +2482,8 @@ static int event_handler(struct notifier_block *nb, unsigned long event, void *p
>         return ret;
>  }
>
> -static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> +static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
> +                            const struct vdpa_dev_set_config *add_config)
>  {
>         struct mlx5_vdpa_mgmtdev *mgtdev = container_of(v_mdev, struct mlx5_vdpa_mgmtdev, mgtdev);
>         struct virtio_net_config *config;
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 973c56fb60b9..a1168a7fa8b8 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -14,7 +14,6 @@
>  #include <uapi/linux/vdpa.h>
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
> -#include <linux/virtio_net.h>
>  #include <linux/virtio_ids.h>
>
>  static LIST_HEAD(mdev_head);
> @@ -480,9 +479,15 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>         return msg->len;
>  }
>
> +#define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> +                                (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> +
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> +       struct vdpa_dev_set_config config = {};
> +       struct nlattr **nl_attrs = info->attrs;
>         struct vdpa_mgmt_dev *mdev;
> +       const u8 *macaddr;
>         const char *name;
>         int err = 0;
>
> @@ -491,6 +496,26 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>
>         name = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
>
> +       if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
> +               macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
> +               memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> +               config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +       }
> +       if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
> +               config.net.mtu =
> +                       nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> +               config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> +       }
> +
> +       /* Skip checking capability if user didn't prefer to configure any
> +        * device networking attributes. It is likely that user might have used
> +        * a device specific method to configure such attributes or using device
> +        * default attributes.
> +        */
> +       if ((config.mask & VDPA_DEV_NET_ATTRS_MASK) &&
> +           !netlink_capable(skb, CAP_NET_ADMIN))
> +               return -EPERM;
> +
>         mutex_lock(&vdpa_dev_mutex);
>         mdev = vdpa_mgmtdev_get_from_attr(info->attrs);
>         if (IS_ERR(mdev)) {
> @@ -498,8 +523,14 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>                 err = PTR_ERR(mdev);
>                 goto err;
>         }
> +       if ((config.mask & mdev->config_attr_mask) != config.mask) {
> +               NL_SET_ERR_MSG_MOD(info->extack,
> +                                  "All provided attributes are not supported");
> +               err = -EOPNOTSUPP;
> +               goto err;
> +       }
>
> -       err = mdev->ops->dev_add(mdev, name);
> +       err = mdev->ops->dev_add(mdev, name, &config);
>  err:
>         mutex_unlock(&vdpa_dev_mutex);
>         return err;
> @@ -835,6 +866,9 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>         [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
>         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> +       [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> +       /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index a790903f243e..42d401d43911 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -248,7 +248,8 @@ static struct device vdpasim_blk_mgmtdev = {
>         .release = vdpasim_blk_mgmtdev_release,
>  };
>
> -static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> +static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> +                              const struct vdpa_dev_set_config *config)
>  {
>         struct vdpasim_dev_attr dev_attr = {};
>         struct vdpasim *simdev;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index a1ab6163f7d1..d681e423e64f 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -126,7 +126,8 @@ static struct device vdpasim_net_mgmtdev = {
>         .release = vdpasim_net_mgmtdev_release,
>  };
>
> -static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> +static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> +                              const struct vdpa_dev_set_config *config)
>  {
>         struct vdpasim_dev_attr dev_attr = {};
>         struct vdpasim *simdev;
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 841667a896dd..c9204c62f339 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1503,7 +1503,8 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>         return 0;
>  }
>
> -static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name)
> +static int vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> +                       const struct vdpa_dev_set_config *config)
>  {
>         struct vduse_dev *dev;
>         int ret;
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index fafb7202482c..bf9ddf743e2f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -6,6 +6,8 @@
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/vhost_iotlb.h>
> +#include <linux/virtio_net.h>
> +#include <linux/if_ether.h>
>
>  /**
>   * struct vdpa_calllback - vDPA callback definition.
> @@ -93,6 +95,14 @@ struct vdpa_iova_range {
>         u64 last;
>  };
>
> +struct vdpa_dev_set_config {
> +       struct {
> +               u8 mac[ETH_ALEN];
> +               u16 mtu;
> +       } net;
> +       u64 mask;
> +};
> +
>  /**
>   * Corresponding file area for device memory mapping
>   * @file: vma->vm_file for the mapping
> @@ -397,6 +407,7 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>   * @dev_add: Add a vdpa device using alloc and register
>   *          @mdev: parent device to use for device addition
>   *          @name: name of the new vdpa device
> + *          @config: config attributes to apply to the device under creation
>   *          Driver need to add a new device using _vdpa_register_device()
>   *          after fully initializing the vdpa device. Driver must return 0
>   *          on success or appropriate error code.
> @@ -407,7 +418,8 @@ void vdpa_set_config(struct vdpa_device *dev, unsigned int offset,
>   *          _vdpa_unregister_device().
>   */
>  struct vdpa_mgmtdev_ops {
> -       int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name);
> +       int (*dev_add)(struct vdpa_mgmt_dev *mdev, const char *name,
> +                      const struct vdpa_dev_set_config *config);
>         void (*dev_del)(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev);
>  };
>
> @@ -416,12 +428,15 @@ struct vdpa_mgmtdev_ops {
>   * @device: Management parent device
>   * @ops: operations supported by management device
>   * @id_table: Pointer to device id table of supported ids
> + * @config_attr_mask: bit mask of attributes of type enum vdpa_attr that
> + *                   management devie support during dev_add callback
>   * @list: list entry
>   */
>  struct vdpa_mgmt_dev {
>         struct device *device;
>         const struct vdpa_mgmtdev_ops *ops;
>         const struct virtio_device_id *id_table;
> +       u64 config_attr_mask;
>         struct list_head list;
>  };
>
> --
> 2.25.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
