Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5050BC433EF
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 06:06:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 096668272A;
	Tue, 21 Dec 2021 06:06:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ugN-CpMuuXG1; Tue, 21 Dec 2021 06:06:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 73D598272D;
	Tue, 21 Dec 2021 06:06:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 486A9C001E;
	Tue, 21 Dec 2021 06:06:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F190C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 06:06:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 202CD408DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 06:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aOYqi4jfcM5l
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 06:06:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 327C6408DC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 06:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640066774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fml0hubyLfkMOXoP5KuTXx50WGqCyPwJ+A3A1BhnPd8=;
 b=NO+o+fwIlhdr+XRy/IxZIuNx+/0pqjiswNqW4yu4GxMt9gHkaV0bHYzyEPHm2eyQ+PQniT
 XueWf17kC1N0v5irCCBjpMfB4NP5ZZKqq4nADKeBSXa1vfal83Nhl9tBW7NMDcKQtIPkIs
 28QuZxKTbqP3GPpeakhJlY/BYEvwK8s=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-jsiZXTYtPB2C9NbhkxLDeQ-1; Tue, 21 Dec 2021 01:06:12 -0500
X-MC-Unique: jsiZXTYtPB2C9NbhkxLDeQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 i16-20020a056512319000b00425efb1c65eso2064433lfe.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 22:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fml0hubyLfkMOXoP5KuTXx50WGqCyPwJ+A3A1BhnPd8=;
 b=3F8x9C52SYgKOdv69Y+y14nCtXJRj08QMwjJboN+g22RjMH/F3KR4V5LU3MbxWJeDv
 aZP0umbYkzYS/V9/eUz0XmSgV5l9kDGiDc6Nd4oUC01QrbKIDrFLUha9vRdQeEksy6P+
 rgmN/wzsAJbzEJJw/sffcc3cYQHMofQVkUIMfo2HYNEgEk9UMhHZ0YWkmpvjup6N+rAG
 Ee/vxtP0FXHgpV34a/Fy6cIQP1wXRPbG+u5tqUw8WmRoccT4levnL2DCz9TgioVBA1gl
 395H3imoQ30UohoT+SuBdCSqjsYmPBMi57abMKQzSmCSwt/MB38p3zmoMtTNDLcEOCPq
 IY5Q==
X-Gm-Message-State: AOAM531HIOh49R9SfczzlFvijZL8zEznTI5B/64Sg1A/L6pCGwksG2vx
 BkWH984vIX61rFz769v601Wsnm69pJft8Hfacnf5Ztm/7TIRAPNxiE2K8m2Tnj8vDg5CENlQajR
 uyoJT9E+u+xq57Hd0c9GbOw4AjLo2RaxcsElahO9ny1HHRH6DXoPlxyHLoA==
X-Received: by 2002:ac2:4e43:: with SMTP id f3mr1735769lfr.348.1640066771259; 
 Mon, 20 Dec 2021 22:06:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgtxd9BsGuuEp8lJ1V5jn0Jz7YM7tWyotubIjjDvI4G/FRjvaPHeBtgncnI7GrDR5n99dnFOLXuL29xaVGihA=
X-Received: by 2002:ac2:4e43:: with SMTP id f3mr1735750lfr.348.1640066771037; 
 Mon, 20 Dec 2021 22:06:11 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-11-elic@nvidia.com>
In-Reply-To: <20211219140236.27479-11-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 14:05:59 +0800
Message-ID: <CACGkMEtkLL5hW7ePgmgBzcpdbzMJcpDsoBN=qJPCuNE44DnBOA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] vdpa: Use BIT_ULL for bit operations
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
> All masks in this file are 64 bits. Change BIT to BIT_ULL.
>
> Other occurences use (1 << val) which yields a 32 bit value. Change them
> to use BIT_ULL too.
>

It looks to me the patch was squashed with vendor specific stats
extension unexpectedly.

Thanks

> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c       | 154 ++++++++++++++++++++++++++++++++++++--
>  include/linux/vdpa.h      |  10 +++
>  include/uapi/linux/vdpa.h |   7 ++
>  3 files changed, 166 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 8b929692026e..c92fbfbbdf12 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -554,9 +554,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
>         return msg->len;
>  }
>
> -#define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> -                                (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> -                                (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> +#define VDPA_DEV_NET_ATTRS_MASK (BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> +                                BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> +                                BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
>
>  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
>  {
> @@ -575,12 +575,12 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
>         if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]) {
>                 macaddr = nla_data(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MACADDR]);
>                 memcpy(config.net.mac, macaddr, sizeof(config.net.mac));
> -               config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR);
> +               config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MACADDR);
>         }
>         if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]) {
>                 config.net.mtu =
>                         nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> -               config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> +               config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU);
>         }
>         if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
>                 config.net.max_vq_pairs =
> @@ -879,6 +879,90 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
>         return err;
>  }
>
> +static int vdpa_fill_stats_rec(struct vdpa_device *vdev, struct sk_buff *msg, u16 *index)
> +{
> +       struct vdpa_vq_stats stats;
> +       u16 idx = *index;
> +       int err;
> +
> +       err = vdev->config->get_vq_stats(vdev, index, &stats);
> +       if (err)
> +               return err;
> +
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_QUEUE_INDEX, idx))
> +               return -EMSGSIZE;
> +
> +       if (nla_put_u16(msg, VDPA_ATTR_DEV_QUEUE_CTRL, !!stats.ctrl_vq))
> +               return -EMSGSIZE;
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_RECEIVED_DESC, stats.received_desc,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_VENDOR_COMPLETED_DESC, stats.completed_desc,
> +                             VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
> +
> +       return 0;
> +}
> +
> +static int vdpa_dev_net_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg, u16 index)
> +{
> +       int err;
> +
> +       if (!vdev->config->get_vq_stats)
> +               return -EOPNOTSUPP;
> +
> +       if (index != VDPA_INVAL_QUEUE_INDEX) {
> +               err = vdpa_fill_stats_rec(vdev, msg, &index);
> +               if (err)
> +                       return err;
> +       } else {
> +               index = 0;
> +               do {
> +                       err = vdpa_fill_stats_rec(vdev, msg, &index);
> +                       if (err)
> +                               return err;
> +               } while (index != VDPA_INVAL_QUEUE_INDEX);
> +       }
> +
> +       return 0;
> +}
> +
> +static int vdpa_dev_stats_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
> +                              u32 seq, int flags, u16 index)
> +{
> +       u32 device_id;
> +       void *hdr;
> +       int err;
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
> +       err = vdpa_dev_net_stats_fill(vdev, msg, index);
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
> @@ -960,6 +1044,59 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
> +       if (info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX])
> +               index = nla_get_u16(info->attrs[VDPA_ATTR_DEV_QUEUE_INDEX]);
> +
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
> +       err = vdpa_dev_stats_fill(vdev, msg, info->snd_portid, info->snd_seq, 0, index);
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
> @@ -967,6 +1104,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>         [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U16, 0, 32767),
>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> @@ -1000,6 +1138,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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
> index 72ea8ad7ba21..4eea0c34301f 100644
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
> +
>  struct vdpa_mgmt_dev;
>
>  /**
> @@ -275,6 +281,8 @@ struct vdpa_config_ops {
>                             const struct vdpa_vq_state *state);
>         int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>                             struct vdpa_vq_state *state);
> +       int (*get_vq_stats)(struct vdpa_device *vdev, u16 *idx,
> +                           struct vdpa_vq_stats *stats);
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -451,4 +459,6 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> +
>  #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 27c2a41e4eec..ebc346087435 100644
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
> @@ -45,6 +46,12 @@ enum vdpa_attr {
>
>         VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
>         VDPA_ATTR_DEV_MAX_DEV_VQS,              /* u16 */
> +
> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> +       VDPA_ATTR_DEV_QUEUE_CTRL,               /* u16 */
> +       VDPA_ATTR_DEV_VENDOR_RECEIVED_DESC,     /* u64 */
> +       VDPA_ATTR_DEV_VENDOR_COMPLETED_DESC,    /* u64 */
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
