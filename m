Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C58C433EF
	for <virtualization@archiver.kernel.org>; Fri, 10 Dec 2021 02:30:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 95F5440BB4;
	Fri, 10 Dec 2021 02:30:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLluPZVvW8qm; Fri, 10 Dec 2021 02:30:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B93E740B9B;
	Fri, 10 Dec 2021 02:30:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E066C002F;
	Fri, 10 Dec 2021 02:30:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C5F4C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A3C740BB1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SwhV1ftKH-sa
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0FD1140B9B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Dec 2021 02:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639103397;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qu3sOoA6zxLAgPitEl/vXJ1/+MprbWEt0OPJ2rrNg10=;
 b=bv7wZCkYkAJFZWFwiVjdozC7WvrHU/8eoM1nnb1BeTn3IznStm/tF/qTfSQu6PkmUXXjMY
 w0g8R1Sz/DLz7viRMH9ZnrvJ4XwQs/OUewiIW5z6blBDvA3WtY+E32JLjDhvzOYPhjMpPZ
 geiZdwVM831KE9oK4SZ+bM6cWZvbMrc=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-XmGxSgj-Nxa968O53MDvZQ-1; Thu, 09 Dec 2021 21:29:55 -0500
X-MC-Unique: XmGxSgj-Nxa968O53MDvZQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 24-20020ac25f58000000b0041799ebf529so3503135lfz.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 18:29:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qu3sOoA6zxLAgPitEl/vXJ1/+MprbWEt0OPJ2rrNg10=;
 b=Rnjmt4NQeQS1qZ9Zp5JWR6fuC94b6Z2NTfDTSM+AsACGBL+C/j8iX4NwOXiTuKly39
 X5bIUXgXr+rymnv/+Z7q+AgqfO3wQqsETY/kDaskFf+T+jaDw56YO3wXD5qYE2p5RZcW
 6UdE4yTnlPlIIMdwXcv8sMxeqDap9lEHeYgcrsYXeTdnS9aV0v5hHSqSbzCvgJnEXyD5
 TS33XjbGczCzBLAlBUdXdGLlzKF+jO6nIOkX3rJ2d7KGofE6pFSw4YAENcFDW03K3r9r
 3LN9Wf314blERcRpFIVNTQsvqyFahINnhiwqyDUtyjf1/nk7WKCytQZdmuYKb5VoL105
 PEUQ==
X-Gm-Message-State: AOAM530Xt9WYWwVxBFVdk+VYmJLADUU28rpmJozJLh33UUhGa6Z9Dl9F
 v9K3qZ/8VkIDnfGPK3d+il3nCoVL1stk4R50pI5CZMZwq1KWh1au9dPo1po4B0mt5cdA6p0xQzT
 IcdoseWakKqbUqgENDNShEw37i53jK/ntsjMb2XshRLTV60BQo4GbATs0LQ==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr9778168lfe.84.1639103394397; 
 Thu, 09 Dec 2021 18:29:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxL6lVwUyTnG+JuWDNvQtTxXNrMPQ7JKrj/MIErt3Uqv8qybQ7/aXmdfZlgiQFsodcyoXNgxBlanzmVdR0jN7Y=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr9778146lfe.84.1639103394154; 
 Thu, 09 Dec 2021 18:29:54 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-4-elic@nvidia.com>
 <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
 <CACGkMEs2jydoBY8xLqNy_Uvurxft7rGzPon542Gup9DDuAyE=Q@mail.gmail.com>
 <9978f096-b0d4-1926-839c-fcaab28f7e44@oracle.com>
In-Reply-To: <9978f096-b0d4-1926-839c-fcaab28f7e44@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Dec 2021 10:29:43 +0800
Message-ID: <CACGkMEuUjf9gqBFiD7vzVaxn5vMxP+xbD5V7DGAjKj9TwmWKZg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] vdpa: Allow to configure max data virtqueues
To: Si-Wei Liu <si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, mst <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 eperezma <eperezma@redhat.com>, Eli Cohen <elic@nvidia.com>
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

On Fri, Dec 10, 2021 at 5:51 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 12/8/2021 9:36 PM, Jason Wang wrote:
> > On Thu, Dec 9, 2021 at 8:25 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
> >>
> >>
> >> On 12/8/2021 12:14 PM, Eli Cohen wrote:
> >>> Add netlink support to configure the max virtqueue pairs for a device.
> >>> At least one pair is required. The maximum is dictated by the device.
> >>>
> >>> Example:
> >>>
> >>> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
> >> Not this patch, but I think there should be a mega attribute defined
> >> ahead to specify the virtio class/type to create vdpa instance with.
> >> Like the existing ones e.g. mac_addr and mtu, max_vqp is also vdpa net
> >> specific attribute.
> > Probably, but this only works for the case when a single parent is
> > allowed to create different types of devices. It looks to me the
> > current model to have a per type parent.
> Yes, that is the current situation and implementation, although the
> model does allow multi-type parent through
> VDPA_ATTR_MGMTDEV_SUPPORTED_CLASSES.

Right, so I agree with you, we need to specify the class first.

> Regardless, even though with
> single-type parent, so far on vdpa creation there's no validation done
> yet against which class/type the parent can support. The max-vqp is
> essentially vdpa network device only, but command line users don't have
> a means to infer it is structured this way, and/or which vdpa parent may
> support this config attribute. That said, were the command line usage
> structured like below, I would have less worry.
>
> $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 net.max_vqp 5

It might be easier to specify class as a dedicated parameter, since we
may want to specify mtu and mac.

Thanks

>
> Alternatively, if the goal is to keep the attribute flat, we may show
> the mapping for the parent capability and the supported class:
>
> $ vdpa mgmtdev capab show
> pci/0000:41:00.2:
>    class: net
>       mac: off
>       mtu: on
>       max_mtu: 9000
>       max_vqp: 1
> auxiliary/mlx5_core.sf.1:
>    class: net
>       mac: on
>       mtu: off
>       max_mtu: 1500
>       max_vqp: 256
>
> Thanks,
> -Siwei
>
> >
> > Thanks
> >
> >> -Siwei
> >>
> >>> Signed-off-by: Eli Cohen <elic@nvidia.com>
> >>> ---
> >>> v0 -> v1:
> >>> 1. fix typo
> >>> 2. move max_vq_pairs to net specific struct
> >>>
> >>>    drivers/vdpa/vdpa.c  | 14 +++++++++++++-
> >>>    include/linux/vdpa.h |  1 +
> >>>    2 files changed, 14 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> >>> index c37d384c0f33..3bf016e03512 100644
> >>> --- a/drivers/vdpa/vdpa.c
> >>> +++ b/drivers/vdpa/vdpa.c
> >>> @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> >>>    }
> >>>
> >>>    #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> >>> -                              (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> >>> +                              (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> >>> +                              (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> >>>
> >>>    static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> >>>    {
> >>> @@ -506,6 +507,17 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> >>>                        nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> >>>                config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> >>>        }
> >>> +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> >>> +             config.net.max_vq_pairs =
> >>> +                     nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> >>> +             if (!config.net.max_vq_pairs) {
> >>> +                     NL_SET_ERR_MSG_MOD(info->extack,
> >>> +                                        "At least one pair of VQs is required");
> >>> +                     err = -EINVAL;
> >>> +                     goto err;
> >>> +             }
> >>> +             config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> >>> +     }
> >>>
> >>>        /* Skip checking capability if user didn't prefer to configure any
> >>>         * device networking attributes. It is likely that user might have used
> >>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> >>> index db24317d61b6..b62032573780 100644
> >>> --- a/include/linux/vdpa.h
> >>> +++ b/include/linux/vdpa.h
> >>> @@ -99,6 +99,7 @@ struct vdpa_dev_set_config {
> >>>        struct {
> >>>                u8 mac[ETH_ALEN];
> >>>                u16 mtu;
> >>> +             u16 max_vq_pairs;
> >>>        } net;
> >>>        u64 mask;
> >>>    };
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
