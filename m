Return-Path: <SRS0=gSim=QG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B3EC433F5
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 02:42:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782CC6187F
	for <virtualization@archiver.kernel.org>; Fri, 19 Nov 2021 02:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 782CC6187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1969381B99;
	Fri, 19 Nov 2021 02:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZ82aM4WBxmN; Fri, 19 Nov 2021 02:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8055181A65;
	Fri, 19 Nov 2021 02:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5343FC002E;
	Fri, 19 Nov 2021 02:42:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 171D5C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 02:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2258409A4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 02:42:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_GvVfoQN46b
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 02:42:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DEA7340632
 for <virtualization@lists.linux-foundation.org>;
 Fri, 19 Nov 2021 02:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637289724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NhGxSO1mVa9X+WvawnjORJ+xWZlqi/DZwChErxQzTeM=;
 b=JQBZyPY0HKya2UFv6T4/ZzhI8UM1QOniNpmObJoypdY9/bgBFR3DCsM7YTou1w2BcQW4ya
 qSbquFcw1HRKLN7vvJvLztiOB23EwmFifG+BZTHiYE9ukpfwGAiEmh6HAvkuCrwQk1tl07
 o5C7jJDQ/OseEbMZOb2Q0GejJ+0zG5I=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-8t9Nn7PFPla52BTxJOeWwg-1; Thu, 18 Nov 2021 21:42:03 -0500
X-MC-Unique: 8t9Nn7PFPla52BTxJOeWwg-1
Received: by mail-lf1-f72.google.com with SMTP id
 q26-20020ac2515a000000b0040adfeb8132so5513059lfd.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 18:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NhGxSO1mVa9X+WvawnjORJ+xWZlqi/DZwChErxQzTeM=;
 b=xXkwxSiA/Fob/l/4ooA8/eIt2Q/MT1d0v7HvufEsT41Ca5v0gPeqM188spYoU/AO0z
 90egg92zTHTOqCnc8Fg8ExeZVgHiN2iFommQoCtjc4++nGjpBUW5shML1xoqkKdCzG60
 mF+32FUVtDTCSbwQXR8HnCl9Vecqqjbkz9kPZLpQy+nA39ZqKWbINBBZAvDIU2hSZ1DZ
 M6yz+pCi2vISPEvhiu8mvJCG8p7mAWQ7lNR2w11iT15LdDHRYPoGyxPDgIZjWCW1bXQ7
 bObjN1Hy99/HPtlt72J10nNPzUJJl2r57Qg+1D7hb13/fpK73xXkN2QRUstSfbhQYhkj
 ubPg==
X-Gm-Message-State: AOAM531cMkZY4ddaR7sFwfFtv4vvcJVHBMjrM9yIehpi3Bpn+1q/uOvF
 uNogYGELr5hX81Hgy2Zy15A/Q3VMLkQZ4z+iTZ7UG1/AsDhG9+AHc2n1hAfx57UWse0iRdVBWnh
 m7dK60uRW6TX6Kgrsrs02tnyKtq5Vh1RhTBMiEvFW169Ec1EQXqg/fghWOQ==
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr22406987ljq.420.1637289722069; 
 Thu, 18 Nov 2021 18:42:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyuGs17hmABqNc3tqyQvKRmVp1iJ2xtsy7jl+7TrWojRPAqye5K3JCSRWRLRfSh+Oys2n1b2fA7HEzkltbUKI=
X-Received: by 2002:a2e:2ac1:: with SMTP id
 q184mr22406953ljq.420.1637289721815; 
 Thu, 18 Nov 2021 18:42:01 -0800 (PST)
MIME-Version: 1.0
References: <20211118055741.239639-1-elic@nvidia.com>
 <20211118055741.239639-2-elic@nvidia.com>
In-Reply-To: <20211118055741.239639-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 19 Nov 2021 10:41:50 +0800
Message-ID: <CACGkMEsDHKCTSHtLBp3Pr0wntgYzsSBNjCNjQjGkmk2iap80rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa: Add support for querying statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>
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

On Thu, Nov 18, 2021 at 1:58 PM Eli Cohen <elic@nvidia.com> wrote:
>
> Add support for querying virtqueue statistics. Supported statistics are:
>
> Received_desc - number of descriptors received for the virtqueue
> completed_desc - number of descriptors completed for the virtqueue
>
> A new callback was added to vdpa_config_ops which provides the means for
> the vdpa driver to return statistics results.
>
> The interface allows for reading all the supported virtqueues, including
> the control virtqueue if it exists, by returning the next queue index to
> query.
>
> Examples:
> 1. Read statisitics for the virtqueue at index 1
> $ vdpa dev stats show vdpa-a index 1
> vdpa-a:
> index 1 tx received_desc 21 completed_desc 21
>
> 2. Read statisitics for all the virtqueues
> vdpa dev stats show vdpa-a
> vdpa-a:
> index 0 rx received_desc 256 completed_desc 12
> index 1 tx received_desc 21 completed_desc 21
> index 2 ctrl received_desc 0 completed_desc 0

Adding Adrian and Laurent.

It's quite useful but I think it's vendor specific statistics.  I
wonder if it's better to use "vendor" prefix in the protocol, then we
use this instead:

vdpa dev vendor-stats show vdpa-a

Or if we want to make it standard is exposing virtio index better?

qid 0 last_avail_idx X avail_idx Y last_used_idx M used_idx N

Thanks

>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
>  drivers/vdpa/vdpa.c       | 141 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  10 +++
>  include/uapi/linux/vdpa.h |   9 +++
>  3 files changed, 160 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..54bcb140af74 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -781,6 +781,87 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
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
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_RECEIVED_DESC, stats.received_desc, VDPA_ATTR_PAD))
> +               return -EMSGSIZE;
> +
> +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_COMPLETED_DESC, stats.completed_desc,
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
> +       if (index != (u16)-1) {
> +               err = vdpa_fill_stats_rec(vdev, msg, &index);
> +               if (err)
> +                       return err;
> +       } else {
> +               index = 0;
> +               do {
> +                       err = vdpa_fill_stats_rec(vdev, msg, &index);
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
> +                         VDPA_CMD_DEV_STATS_GET);
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
> @@ -862,6 +943,59 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
> @@ -869,6 +1003,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>         [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U16, 0, 32767),
>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> @@ -902,6 +1037,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
>                 .doit = vdpa_nl_cmd_dev_config_get_doit,
>                 .dumpit = vdpa_nl_cmd_dev_config_get_dumpit,
>         },
> +       {
> +               .cmd = VDPA_CMD_DEV_STATS_GET,
> +               .validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
> +               .doit = vdpa_nl_cmd_dev_stats_get_doit,
> +               .flags = GENL_ADMIN_PERM,
> +       },
>  };
>
>  static struct genl_family vdpa_nl_family __ro_after_init = {
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index c3011ccda430..1df19a87a9cb 100644
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
> @@ -269,6 +275,8 @@ struct vdpa_config_ops {
>                             const struct vdpa_vq_state *state);
>         int (*get_vq_state)(struct vdpa_device *vdev, u16 idx,
>                             struct vdpa_vq_state *state);
> +       int (*get_vq_stats)(struct vdpa_device *vdev, u16 *idx,
> +                           struct vdpa_vq_stats *stats);
>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -443,4 +451,6 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff
> +
>  #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..be7deeae139a 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,11 +18,15 @@ enum vdpa_command {
>         VDPA_CMD_DEV_DEL,
>         VDPA_CMD_DEV_GET,               /* can dump */
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> +       VDPA_CMD_DEV_STATS_GET,
>  };
>
>  enum vdpa_attr {
>         VDPA_ATTR_UNSPEC,
>
> +       /* Pad attribute for 64b alignment */
> +       VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> +
>         /* bus name (optional) + dev name together make the parent device handle */
>         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
>         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
> @@ -40,6 +44,11 @@ enum vdpa_attr {
>         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
>         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
>
> +       VDPA_ATTR_DEV_QUEUE_INDEX,              /* u16 */
> +       VDPA_ATTR_DEV_QUEUE_CTRL,               /* u16 */
> +       VDPA_ATTR_DEV_RECEIVED_DESC,            /* u64 */
> +       VDPA_ATTR_DEV_COMPLETED_DESC,           /* u64 */
> +
>         /* new attributes must be added above here */
>         VDPA_ATTR_MAX,
>  };
> --
> 2.33.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
