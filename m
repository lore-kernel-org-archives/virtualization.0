Return-Path: <SRS0=tl6X=PO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63CC3C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:47:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096DC60F0F
	for <virtualization@archiver.kernel.org>; Tue, 26 Oct 2021 02:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 096DC60F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C757F403F0;
	Tue, 26 Oct 2021 02:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCqow4YuzMyf; Tue, 26 Oct 2021 02:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1F636402E2;
	Tue, 26 Oct 2021 02:47:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00DACC0019;
	Tue, 26 Oct 2021 02:47:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59F0BC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4526681004
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ROSoq2HKCW3y
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:47:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 47E6780FFF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Oct 2021 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635216443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Po4v5/vuHw0ycakwi1g8H8leOjYko3DuoBYuaQPmgk=;
 b=P/SMGleRpvZzUyimhOlHTG7/LwXJ/BXlkog283wCymtNbjQqRlt4EvREPts0U2zZ5onYyV
 HZuEm3jmiU6k5296azHvkRd9v08zMGHejXZPEhJuZCLPwa56l8R70HFB2j6h9QEn5czHon
 F6Dtmo/xuJMHS9Aml9tSFKJzmlYm11E=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-E8ng14R7NfuzXbM7zdJRKw-1; Mon, 25 Oct 2021 22:47:21 -0400
X-MC-Unique: E8ng14R7NfuzXbM7zdJRKw-1
Received: by mail-lf1-f72.google.com with SMTP id
 y40-20020a0565123f2800b003fded085638so5738503lfa.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 19:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Po4v5/vuHw0ycakwi1g8H8leOjYko3DuoBYuaQPmgk=;
 b=7bLcIo14SzEwEhf8s5nebbNsAsektbSykNoDiXIbxap+oA5ngsLbWBDkH6IKcdatO/
 /AbNX3vUp8O6uq5+Ft0Q77Qn6QFH5OzSipsEU1S80zqxYLo8PI0xjAoerO73LcA3b+aW
 +U9kppIUAg0yNvH3lFGqSGuAk+tgtvwVNiKgvNSWoDd3KYvngqYZADjhh9oYc6XHsJF0
 X/lDdP5w1ztUf6+HH4CwbBn6kgkarw8ZRpVodOIy+KFCbg+NwzzAKMWNBP3rzaHSd9uW
 DOlUOjtrqZtlh1PqiTnsRKmS1/oxkJOW8yvBogDIIgAALm4vXN0gO/9lSMCmrcAyfTRb
 YxSA==
X-Gm-Message-State: AOAM531IGVxQ/vGgAJsuBHxiQF7fqVGH9tHxY305SVyrMtenEnIKlwBm
 v4aZKtp/RFIUe+dobMKXSfqv6VpPDKZCY2jDe8FdTK1hCxiFeJ2eZ0bKEKdsavv/E/UuUWGBi9O
 7R0jClTzvd/L4TCsI4Zyuu92MGMiSxe3fvPtK8hBxBqYT+NPJtBOwPH2wmQ==
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr2869627lfs.84.1635216439633; 
 Mon, 25 Oct 2021 19:47:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTvmMsWaioT71SKc0UsGQiBe4SfXlGk5yhgT4LMGn2qenXp8lhO0XpehNKLA4LQ4GAvR9lJLkx1/4iux0THeA=
X-Received: by 2002:a05:6512:1291:: with SMTP id
 u17mr2869605lfs.84.1635216439375; 
 Mon, 25 Oct 2021 19:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211025125316.67664-1-parav@nvidia.com>
 <20211025125316.67664-3-parav@nvidia.com>
In-Reply-To: <20211025125316.67664-3-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Oct 2021 10:47:08 +0800
Message-ID: <CACGkMEt+m-vW1k-xsb-E=V0D+zRcBX_Ddp5vf6V-q6V3==aXrA@mail.gmail.com>
Subject: Re: [PATCH linux-next v5 2/8] vdpa: Introduce query of device config
 layout
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
> Introduce a command to query a device config layout.
>
> An example query of network vdpa device:
>
> $ vdpa dev add name bar mgmtdev vdpasim_net
>
> $ vdpa dev config show
> bar: mac 00:35:09:19:48:05 link up link_announce false mtu 1500
>
> $ vdpa dev config show -jp
> {
>     "config": {
>         "bar": {
>             "mac": "00:35:09:19:48:05",
>             "link ": "up",
>             "link_announce ": false,
>             "mtu": 1500,
>         }
>     }
> }
>
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Eli Cohen <elic@nvidia.com>

Acked-by: Jason Wang <jasowang@redhat.com>

> ---
> changelog:
> v3->v4:
>  - removed config space fields reporting which are not used by mlx5
>    and sim drivers
> ---
>  drivers/vdpa/vdpa.c       | 176 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |   2 +
>  include/uapi/linux/vdpa.h |   6 ++
>  3 files changed, 184 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index d42697699366..973c56fb60b9 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -14,6 +14,8 @@
>  #include <uapi/linux/vdpa.h>
>  #include <net/genetlink.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/virtio_net.h>
> +#include <linux/virtio_ids.h>
>
>  static LIST_HEAD(mdev_head);
>  /* A global mutex that protects vdpa management device and device level operations. */
> @@ -66,6 +68,7 @@ static void vdpa_release_dev(struct device *d)
>                 ops->free(vdev);
>
>         ida_simple_remove(&vdpa_index_ida, vdev->index);
> +       mutex_destroy(&vdev->cf_mutex);
>         kfree(vdev);
>  }
>
> @@ -127,6 +130,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
>         if (err)
>                 goto err_name;
>
> +       mutex_init(&vdev->cf_mutex);
>         device_initialize(&vdev->dev);
>
>         return vdev;
> @@ -309,6 +313,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>  {
>         const struct vdpa_config_ops *ops = vdev->config;
>
> +       mutex_lock(&vdev->cf_mutex);
>         /*
>          * Config accesses aren't supposed to trigger before features are set.
>          * If it does happen we assume a legacy guest.
> @@ -316,6 +321,7 @@ void vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
>         if (!vdev->features_valid)
>                 vdpa_set_features(vdev, 0);
>         ops->get_config(vdev, offset, buf, len);
> +       mutex_unlock(&vdev->cf_mutex);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_get_config);
>
> @@ -329,7 +335,9 @@ EXPORT_SYMBOL_GPL(vdpa_get_config);
>  void vdpa_set_config(struct vdpa_device *vdev, unsigned int offset,
>                      const void *buf, unsigned int length)
>  {
> +       mutex_lock(&vdev->cf_mutex);
>         vdev->config->set_config(vdev, offset, buf, length);
> +       mutex_unlock(&vdev->cf_mutex);
>  }
>  EXPORT_SYMBOL_GPL(vdpa_set_config);
>
> @@ -661,6 +669,168 @@ static int vdpa_nl_cmd_dev_get_dumpit(struct sk_buff *msg, struct netlink_callba
>         return msg->len;
>  }
>
> +static int vdpa_dev_net_mq_config_fill(struct vdpa_device *vdev,
> +                                      struct sk_buff *msg, u64 features,
> +                                      const struct virtio_net_config *config)
> +{
> +       u16 val_u16;
> +
> +       if ((features & (1ULL << VIRTIO_NET_F_MQ)) == 0)
> +               return 0;
> +
> +       val_u16 = le16_to_cpu(config->max_virtqueue_pairs);
> +       return nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MAX_VQP, val_u16);
> +}
> +
> +static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *msg)
> +{
> +       struct virtio_net_config config = {};
> +       u64 features;
> +       u16 val_u16;
> +
> +       vdpa_get_config(vdev, 0, &config, sizeof(config));
> +
> +       if (nla_put(msg, VDPA_ATTR_DEV_NET_CFG_MACADDR, sizeof(config.mac),
> +                   config.mac))
> +               return -EMSGSIZE;
> +
> +       val_u16 = le16_to_cpu(config.status);
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_STATUS, val_u16))
> +               return -EMSGSIZE;
> +
> +       val_u16 = le16_to_cpu(config.mtu);
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_NET_CFG_MTU, val_u16))
> +               return -EMSGSIZE;
> +
> +       features = vdev->config->get_features(vdev);
> +
> +       return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> +}
> +
> +static int
> +vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid, u32 seq,
> +                    int flags, struct netlink_ext_ack *extack)
> +{
> +       u32 device_id;
> +       void *hdr;
> +       int err;
> +
> +       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +                         VDPA_CMD_DEV_CONFIG_GET);
> +       if (!hdr)
> +               return -EMSGSIZE;
> +
> +       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +               err = -EMSGSIZE;
> +               goto msg_err;
> +       }
> +
> +       device_id = vdev->config->get_device_id(vdev);
> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +               err = -EMSGSIZE;
> +               goto msg_err;
> +       }
> +
> +       switch (device_id) {
> +       case VIRTIO_ID_NET:
> +               err = vdpa_dev_net_config_fill(vdev, msg);
> +               break;
> +       default:
> +               err = -EOPNOTSUPP;
> +               break;
> +       }
> +       if (err)
> +               goto msg_err;
> +
> +       genlmsg_end(msg, hdr);
> +       return 0;
> +
> +msg_err:
> +       genlmsg_cancel(msg, hdr);
> +       return err;
> +}
> +
> +static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
> +{
> +       struct vdpa_device *vdev;
> +       struct sk_buff *msg;
> +       const char *devname;
> +       struct device *dev;
> +       int err;
> +
> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +               return -EINVAL;
> +       devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +       msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       mutex_lock(&vdpa_dev_mutex);
> +       dev = bus_find_device(&vdpa_bus, NULL, devname, vdpa_name_match);
> +       if (!dev) {
> +               NL_SET_ERR_MSG_MOD(info->extack, "device not found");
> +               err = -ENODEV;
> +               goto dev_err;
> +       }
> +       vdev = container_of(dev, struct vdpa_device, dev);
> +       if (!vdev->mdev) {
> +               NL_SET_ERR_MSG_MOD(info->extack, "unmanaged vdpa device");
> +               err = -EINVAL;
> +               goto mdev_err;
> +       }
> +       err = vdpa_dev_config_fill(vdev, msg, info->snd_portid, info->snd_seq,
> +                                  0, info->extack);
> +       if (!err)
> +               err = genlmsg_reply(msg, info);
> +
> +mdev_err:
> +       put_device(dev);
> +dev_err:
> +       mutex_unlock(&vdpa_dev_mutex);
> +       if (err)
> +               nlmsg_free(msg);
> +       return err;
> +}
> +
> +static int vdpa_dev_config_dump(struct device *dev, void *data)
> +{
> +       struct vdpa_device *vdev = container_of(dev, struct vdpa_device, dev);
> +       struct vdpa_dev_dump_info *info = data;
> +       int err;
> +
> +       if (!vdev->mdev)
> +               return 0;
> +       if (info->idx < info->start_idx) {
> +               info->idx++;
> +               return 0;
> +       }
> +       err = vdpa_dev_config_fill(vdev, info->msg, NETLINK_CB(info->cb->skb).portid,
> +                                  info->cb->nlh->nlmsg_seq, NLM_F_MULTI,
> +                                  info->cb->extack);
> +       if (err)
> +               return err;
> +
> +       info->idx++;
> +       return 0;
> +}
> +
> +static int
> +vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> +{
> +       struct vdpa_dev_dump_info info;
> +
> +       info.msg = msg;
> +       info.cb = cb;
> +       info.start_idx = cb->args[0];
> +       info.idx = 0;
> +
> +       mutex_lock(&vdpa_dev_mutex);
> +       bus_for_each_dev(&vdpa_bus, NULL, &info, vdpa_dev_config_dump);
> +       mutex_unlock(&vdpa_dev_mutex);
> +       cb->args[0] = info.idx;
> +       return msg->len;
> +}
> +
>  static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>         [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -692,6 +862,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>                 .doit = vdpa_nl_cmd_dev_get_doit,
>                 .dumpit = vdpa_nl_cmd_dev_get_dumpit,
>         },
> +       {
> +               .cmd = VDPA_CMD_DEV_CONFIG_GET,
> +               .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +               .doit = vdpa_nl_cmd_dev_config_get_doit,
> +               .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
> +       },
>  };
>
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 267236aab34c..5cc5e501397f 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -63,6 +63,7 @@ struct vdpa_mgmt_dev;
>   * @dev: underlying device
>   * @dma_dev: the actual device that is performing DMA
>   * @config: the configuration ops for this device.
> + * @cf_mutex: Protects get and set access to configuration layout.
>   * @index: device index
>   * @features_valid: were features initialized? for legacy guests
>   * @use_va: indicate whether virtual address must be used by this device
> @@ -74,6 +75,7 @@ struct vdpa_device {
>         struct device dev;
>         struct device *dma_dev;
>         const struct vdpa_config_ops *config;
> +       struct mutex cf_mutex; /* Protects get/set config */
>         unsigned int index;
>         bool features_valid;
>         bool use_va;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index e3b87879514c..a252f06f9dfd 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -17,6 +17,7 @@ enum vdpa_command {
>         VDPA_CMD_DEV_NEW,
>         VDPA_CMD_DEV_DEL,
>         VDPA_CMD_DEV_GET,               /* can dump */
> +       VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
>  };
>
>  enum vdpa_attr {
> @@ -34,6 +35,11 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_MAX_VQ_SIZE,              /* u16 */
>         VDPA_ATTR_DEV_MIN_VQ_SIZE,              /* u16 */
>
> +       VDPA_ATTR_DEV_NET_CFG_MACADDR,          /* binary */
> +       VDPA_ATTR_DEV_NET_STATUS,               /* u8 */
> +       VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
> +       VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> +
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 2.25.4
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
