Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB69C433F5
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 04:51:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 21FB2607B2;
	Thu, 25 Nov 2021 04:51:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DqAvrc3pN4jZ; Thu, 25 Nov 2021 04:51:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8E4E0606B3;
	Thu, 25 Nov 2021 04:51:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6531AC0038;
	Thu, 25 Nov 2021 04:51:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D51DBC000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:50:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFAD582437
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:50:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aIAP-T0sjgl7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:50:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8B1B82443
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 04:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637815857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GotqqE4yyAf1NU6Ga7a1CW+PAtBw/aKr0qaF2z/wnEw=;
 b=cXvmlv8ZCc9Qj+Ztvr+mLMtFpFBFCeQVRCDEUx4MX+vfHyq+e3v9T1i2Dlv+AQeHRthWmA
 /U3F3CYKu8gVF5jd857MKFd6jRPFyzeT1l7tNxwTafiNpoy36jgMAKMMmQ6eZpygfojW8w
 X9amudMapUK9p1UbyNnX8V4K29EQDCI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-3yGI9uIDOmG7kMJS1FvDVw-1; Wed, 24 Nov 2021 23:50:54 -0500
X-MC-Unique: 3yGI9uIDOmG7kMJS1FvDVw-1
Received: by mail-lj1-f199.google.com with SMTP id
 q13-20020a2e750d000000b00218c953d0b8so1507252ljc.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 20:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GotqqE4yyAf1NU6Ga7a1CW+PAtBw/aKr0qaF2z/wnEw=;
 b=KfPE6/NCQgFnSTprrMB9iwSCOCgAV77YCadHNTskcdFlGOI5kH4pHGv1dMll6Phzi3
 DMJK0lPEo3A00MsdIca4rLWuP984g2J3n67XaRca9I/8klcoLRtV7hoQ9ceqZJZYeqfA
 jf+jd/UdUTpT2vDox4GtPAs4874W0WXeJ1GfVNwTxUEMSu8EmrthsChGIt5Aw2HsTY7H
 qqz0pKA3HiQdPaMNvFY7E4YSq9NLsGH4cPg5GaD0wAqe3Pa4Jdgk9iTpMtrX3lzVIW9W
 EbQQARN2GxOlREWa9ym1S1+JCYxX90I6dAYE9Yp2NydbSrYG9rltsuhcJ2BIFHcNM8JY
 G7BA==
X-Gm-Message-State: AOAM530hZ07T984B3zc16AfLQEcNSHrOnHJGs7Sgd1KfZjOCnHmkjYSl
 6KMxHrRB0qI69KJ88EQUgWJnOtOIKhpsw1a/weY0oPGhNZPebH7DL02lWtFaH/lu9cJnJ7Q/7yO
 XPPg0x5f6W4BQq6YQ2NOKdIXN50T/mk/P1iq+1ZH0X9goyr2xZnWtagLYsQ==
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr21633218lfv.629.1637815852626; 
 Wed, 24 Nov 2021 20:50:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXFQ1KsTsptV4m7wONV1oUyTe1qnFkg3tbe1Nkx+SF6gbZ5hdg4T2mwjJe8JVQ5GE6/C+1uY883Y+8nK7l/KA=
X-Received: by 2002:a05:6512:3b2b:: with SMTP id
 f43mr21633186lfv.629.1637815852367; 
 Wed, 24 Nov 2021 20:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20211124165531.42624-1-elic@nvidia.com>
 <20211124165531.42624-2-elic@nvidia.com>
In-Reply-To: <20211124165531.42624-2-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 12:50:41 +0800
Message-ID: <CACGkMEt3W9OOoC0iF2_HLHRFNq20QxSD=s1H3hJhMFQPGiZ-kw@mail.gmail.com>
Subject: Re: [PATH v1 1/2] vdpa: Add support for querying vendor statistics
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, si-wei.liu@oracle.com
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

On Thu, Nov 25, 2021 at 12:56 AM Eli Cohen <elic@nvidia.com> wrote:
>
> Add support for querying virtqueue statistics. Supported statistics are:
>
> received_desc - number of descriptors received for the virtqueue
> completed_desc - number of descriptors completed for the virtqueue
>
> A descriptors using indirect buffers is still counted as 1. In addition,
> N chained descriptors are counted correctly N times as one would expect.
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
> $ vdpa dev vstats show vdpa-a qidx 0
> vdpa-a:
> qidx 0 rx received_desc 256 completed_desc 9
>
> 2. Read statisitics for all the virtqueues
> $ vdpa dev vstats show vdpa-a
> vdpa-a:
> qidx 0 rx received_desc 256 completed_desc 9
> qidx 1 tx received_desc 21 completed_desc 21
> qidx 2 ctrl received_desc 0 completed_desc 0
>
> Signed-off-by: Eli Cohen <elic@nvidia.com>
> ---
> v0 -> v1:
> Emphasize that we're dealing with vendor specific counters.
> Terminate query loop on error
>
>  drivers/vdpa/vdpa.c       | 144 ++++++++++++++++++++++++++++++++++++++
>  include/linux/vdpa.h      |  10 +++
>  include/uapi/linux/vdpa.h |   9 +++
>  3 files changed, 163 insertions(+)
>
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index 7332a74a4b00..da658c80ff2a 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -781,6 +781,90 @@ vdpa_dev_config_fill(struct vdpa_device *vdev, struct sk_buff *msg, u32 portid,
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

I wonder what happens if some other vendor adds their specific stats.
Can we then have very large stats but only few of them is necessary
for a specific vendor? If this is ture, is this better to simply pass
the msg to the parent instead of a structure like stats?

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
> @@ -862,6 +946,59 @@ vdpa_nl_cmd_dev_config_get_dumpit(struct sk_buff *msg, struct netlink_callback *
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
> @@ -869,6 +1006,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
>         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
>         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
>         [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> +       [VDPA_ATTR_DEV_QUEUE_INDEX] = NLA_POLICY_RANGE(NLA_U16, 0, 32767),

It looks to me that the virtio spec allows up to 65535 vqs.

>  };
>
>  static const struct genl_ops vdpa_nl_ops[] = {
> @@ -902,6 +1040,12 @@ static const struct genl_ops vdpa_nl_ops[] = {
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

I'm fine with this but I wonder if it's better to move this to mgmtdev_ops.

>         struct vdpa_notification_area
>         (*get_vq_notification)(struct vdpa_device *vdev, u16 idx);
>         /* vq irq is not expected to be changed once DRIVER_OK is set */
> @@ -443,4 +451,6 @@ struct vdpa_mgmt_dev {
>  int vdpa_mgmtdev_register(struct vdpa_mgmt_dev *mdev);
>  void vdpa_mgmtdev_unregister(struct vdpa_mgmt_dev *mdev);
>
> +#define VDPA_INVAL_QUEUE_INDEX 0xffff

This seems a valid index unless I miss something in the spec.

Thanks

> +
>  #endif /* _LINUX_VDPA_H */
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index a252f06f9dfd..b749d312dd9c 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -18,11 +18,15 @@ enum vdpa_command {
>         VDPA_CMD_DEV_DEL,
>         VDPA_CMD_DEV_GET,               /* can dump */
>         VDPA_CMD_DEV_CONFIG_GET,        /* can dump */
> +       VDPA_CMD_DEV_VSTATS_GET,
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
> +       VDPA_ATTR_DEV_VENDOR_RECEIVED_DESC,     /* u64 */
> +       VDPA_ATTR_DEV_VENDOR_COMPLETED_DESC,    /* u64 */
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
