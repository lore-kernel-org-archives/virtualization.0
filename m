Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EB1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14C2281361;
	Mon, 14 Feb 2022 08:04:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOVdmlKH3_LM; Mon, 14 Feb 2022 08:04:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6BA6081331;
	Mon, 14 Feb 2022 08:04:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 40118C001A;
	Mon, 14 Feb 2022 08:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D1C75C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C049240275
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:04:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wB-dMCyWJ7V6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:04:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 81146401DC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644825851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+9mB7uNyqnegYi10/pcQFNz9Pi8L1ZRNJeHqpsdTaWU=;
 b=hDzHacjqVGLf1YwlwR4y/2eGFavj5d1GwH0ICiR7qLEi04QG/Fe6zHBuKM4J04YSpE4F3u
 4ww6o/Xa7Ncm2xx0zoGctX5OSCQUwYtQTxNgl21CRCWV1F0psEgWGwHh8GH9hpxQhHWx63
 4ifdJqRCmcMW3UkPOZItmcujbeFUVwY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-FFvGNl4EPJ6C8hCfih2d4A-1; Mon, 14 Feb 2022 03:04:10 -0500
X-MC-Unique: FFvGNl4EPJ6C8hCfih2d4A-1
Received: by mail-lf1-f69.google.com with SMTP id
 z37-20020a0565120c2500b004433b7d95d3so1013169lfu.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 00:04:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+9mB7uNyqnegYi10/pcQFNz9Pi8L1ZRNJeHqpsdTaWU=;
 b=7pe9Desn02z+riucFvdgJW3ADx9BS19a16IBjEGwxjY8sgi0xbh18OpEYobELVhrqB
 H4p7no9Lvj+Avsj1VtRYNydxwlG5t/eu5K/stjRZ3alDrZRJFpEk1ZkSIVMsrQu9vClU
 qBaAEtj9cOZFEDefQ6zWXK4Dqwzhu8qSOavluvf7cc3aVbuT5RMJLlCerI1rzH8rql41
 IgBU4LzzQ67xdcAG7FirPcAhXoEMbxHjDIQ4f6NUVlIrWvGokRU5v4Dwya0k9a4jPfD3
 nghFzCM1oqcjA/+htycMoX9ZtMK672THkO3JIpo5FYdnPpuCYb0dLwqwZjRUXYDG5/KV
 7mbw==
X-Gm-Message-State: AOAM533+sNdAdMA/3KZh3i6z4FTe1+Xotniw/THuHVXetUr4popzbFux
 3tG/As8ektOGIWGpv9roQAbthpKG9rz17CE5pmfXkcHa4XyDqVJ30ERvgf6XtUWNQpK6qban3fE
 Rk34VmHcNA5ybAx3zu7yoHGTqI/l8OtmS/l91wLMu7v6spb+oEuVhUWGWOw==
X-Received: by 2002:ac2:4437:: with SMTP id w23mr4169952lfl.481.1644825848577; 
 Mon, 14 Feb 2022 00:04:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy6a8w4xDkcfa1Far85E0Da871IiDA7xevpTlA6WfvzX/y5gv97/4+Jdd7s3H3pHZgdTda07PEl6qwJN1/+yGU=
X-Received: by 2002:ac2:4437:: with SMTP id w23mr4169934lfl.481.1644825848308; 
 Mon, 14 Feb 2022 00:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20220203055633.3677-1-elic@nvidia.com>
 <20220203055633.3677-2-elic@nvidia.com>
In-Reply-To: <20220203055633.3677-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 14 Feb 2022 16:03:56 +0800
Message-ID: <CACGkMEu8d5YbDGTjC5iHMVt+OxB7cSNeZYWjcuy26ATwYSCT6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying vendor statistics
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

On Thu, Feb 3, 2022 at 1:56 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Allows to read vendor statistics of vdpa device. The specific statistics
> data is received by the upstream driver in the form of an attribute
> name/attribute value pairs.
>
> An example of statistics for mlx5_vdpa device are:
>
> received_desc - number of descriptors received by the virtqueue
> completed_desc - number of descriptors completed by the virtqueue
>
> A descriptors using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists.
>
> Examples:
> 1. Read statistics for the virtqueue at index 1
>
> $ vdpa dev vstats show vdpa-a qidx 1
> vdpa-a:
> qtype tx qidx 1 received_desc 4583367 completed_desc 4583367
>
> 2. Read statistics for the virtqueue at index 32
> $ vdpa dev vstats show vdpa-a qidx 32
> vdpa-a:
> qtype cvq qidx 32 received_desc 0 completed_desc 0
>
> 3. Read statisitics for the virtqueue at index 0 with json output
> $ vdpa -j dev vstats show vdpa-a qidx 0
> {"vstats":{"vdpa-a":{
> "qtype":"rx","qidx":0,"name":"received_desc","value":490205,"name":"completed_desc","value":489964}}}
>
> 4. Read statistics for the virtqueue at index 0 with preety json output
> $ vdpa -jp dev vstats show vdpa-a qidx 0
> {
>     "vstats": {
>         "vdpa-a": {
>
>             "qtype": "rx",
>             "qidx": 0,

I wonder if it's better not to use abbreviations in at least json outputs.

>             "name": "received_desc",
>             "value": 490205,
>             "name": "completed_desc",
>             "value": 489964

Are those counters going back to zero during a vDPA reset?

>         }
>     }
> }
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c       | 128 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  10 +++
>  include/uapi/linux/vdpa.h |   7 +++
>  3 files changed, 145 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 9846c9de4bfa..84c9c488cfcf 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -909,6 +909,73 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>         return err;
>  }

Note related to this patch, but I think it's better to split out
netlink logic into a dedicated c file (e.g netlink.c in drivers/vdpa)

>
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg,
> +                              struct genl_info *info, u16 index)
> +{
> +       int err;
> +
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_QUEUE_INDEX, index))
> +               return -EMSGSIZE;
> +
> +       err = vdev->config->get_vq_stats(vdev, index, msg, info->extack);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int vdpa_dev_net_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +                                  struct genl_info *info, u16 index)

This function looks not specific to net, I guess other types of device
can use this as well? (Especially consider we put device id in the
skb)

> +{
> +       int err;
> +
> +       if (!vdev->config->get_vq_stats)
> +               return -EOPNOTSUPP;
> +
> +       err = vdpa_fill_stats_rec(vdev, msg, info, index);
> +       if (err)
> +               return err;
> +
> +       return 0;
> +}
> +
> +static int vdpa_dev_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg,
> +                              struct genl_info *info, u16 index)
> +{

Considering there will be standard virtio stats to be supported in the
future, I'd like to name this as vdpa_dev_vendor_stats_fill().

> +       u32 device_id;
> +       void *hdr;
> +       int err;
> +       u32 portid = info->snd_portid;
> +       u32 seq = info->snd_seq;
> +       u32 flags = 0;
> +
> +       hdr = genlmsg_put(msg, portid, seq, &vdpa_nl_family, flags,
> +                         VDPA_CMD_DEV_VSTATS_GET);
> +       if (!hdr)
> +               return -EMSGSIZE;
> +
> +       if (nla_put_string(msg, VDPA_ATTR_DEV_NAME, dev_name(&vdev->dev))) {
> +               err = -EMSGSIZE;
> +               goto undo_msg;
> +       }
> +
> +       device_id = vdev->config->get_device_id(vdev);
> +       if (nla_put_u32(msg, VDPA_ATTR_DEV_ID, device_id)) {
> +               err = -EMSGSIZE;
> +               goto undo_msg;
> +       }
> +
> +       err = vdpa_dev_net_stats_fill(vdev, msg, info, index);
> +
> +       genlmsg_end(msg, hdr);
> +
> +       return err;
> +
> +undo_msg:
> +       genlmsg_cancel(msg, hdr);
> +       return err;
> +}
> +
>  static int vdpa_nl_cmd_dev_config_get_doit(struct sk_buff *skb, struct genl_info *info)
>  {
>         struct vdpa_device *vdev;
> @@ -990,6 +1057,60 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
>         return msg->len;
>  }
>
> +static int vdpa_nl_cmd_dev_stats_get_doit(struct sk_buff *skb,
> +                                         struct genl_info *info)
> +{
> +       struct vdpa_device *vdev;
> +       struct sk_buff *msg;
> +       const char *devname;
> +       struct device *dev;
> +       u16 index = -1;
> +       int err;
> +
> +       if (!info->attrs[VDPA_ATTR_DEV_NAME])
> +               return -EINVAL;
> +
> +       if (!info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +               return -EINVAL;
> +
> +       devname = nla_data(info->attrs[VDPA_ATTR_DEV_NAME]);
> +       msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
> +       if (!msg)
> +               return -ENOMEM;
> +
> +       index = nla_get_u16(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
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
> +       err = vdpa_dev_stats_fill(vdev, msg, info, index);
> +       if (!err)
> +               err = genlmsg_reply(msg, info);
> +
> +       put_device(dev);
> +       mutex_unlock(&vdpa_dev_mutex);
> +
> +       if (err)
> +               nlmsg_free(msg);
> +
> +       return err;
> +
> +mdev_err:
> +       put_device(dev);
> +dev_err:
> +       mutex_unlock(&vdpa_dev_mutex);
> +       return err;
> +}
> +
>  static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_MGMTDEV_BUS_NAME] = { .type = NLA_NUL_STRING },
>         [VDPA_ATTR_MGMTDEV_DEV_NAME] = { .type = NLA_STRING },
> @@ -997,6 +1118,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>         [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U16, 0, 32767),

Any reason for choosing 32767 here, spec allows up to 0-65535 as queue index.

>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> @@ -1030,6 +1152,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>                 .doit = vdpa_nl_cmd_dev_config_get_doit,
>                 .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>         },
> +       {
> +               .cmd = VDPA_CMD_DEV_VSTATS_GET,
> +               .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> +               .flags = GENL_ADMIN_PERM,
> +       },
>  };
>
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 2de442ececae..a9b3d7005f69 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -58,6 +58,12 @@ struct vdpa_vq_state {
>         };
>  };
>
> +struct vdpa_vq_stats {
> +       u64 received_desc;
> +       u64 completed_desc;
> +       bool ctrl_vq;
> +};

This seems to be a vendor specific stats, any chance to move it to the
mlx5 directory?

> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -275,6 +281,8 @@ struct vdpa_config_ops {
>                             const struct vdpa_vq_state *state);
>         int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>                             struct vdpa_vq_state *state);
> +       int (*get_vq_stats)(struct vdpa_device *vdev, u16 idx, struct sk_buff *msg,
> +                           struct netlink_ext_ack *extack);

I think it's better to rename this as get_vendor_vq_stats().

Thanks

>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -466,4 +474,6 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> +
>  #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 1061d8d2d09d..c5f229a41dc2 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,6 +18,7 @@ enum vdpa_command {
>         VDPA_CMD_DEV_DEL,
>         VDPA_CMD_DEV_GET,               /* can dump */
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> +       VDPA_CMD_DEV_VSTATS_GET,
>  };
>
>  enum vdpa_attr {
> @@ -46,6 +47,12 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MGMTDEV_MAX_VQS,          /* u32 */
>         VDPA_ATTR_DEV_SUPPORTED_FEATURES,       /* u64 */
> +
> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> +       VDPA_ATTR_DEV_QUEUE_TYPE,               /* string */
> +       VDPA_ATTR_DEV_VENDOR_ATTR_NAME,         /* string */
> +       VDPA_ATTR_DEV_VENDOR_ATTR_VALUE,        /* u64 */
> +
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 2.34.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
