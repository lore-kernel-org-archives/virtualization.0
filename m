Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8726C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 05:36:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EDC440375;
	Thu,  9 Dec 2021 05:36:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ds-dmO-kqRfR; Thu,  9 Dec 2021 05:36:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A293D400B5;
	Thu,  9 Dec 2021 05:36:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 538B1C001E;
	Thu,  9 Dec 2021 05:36:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0578EC0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D2E5382BF5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:36:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0sIYGYnsawh1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:36:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2DD9C81A4E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 05:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639028184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SRZ1W63RG1+PMAbUJRWG6p7YfzpPpROIJSWzaVccpAc=;
 b=Ens2JN3c+IiN9Vfdi+XPT6LxRDJvZKzXhs9uvVRyei7M1v6L099cK0o+X/XxcaRTMnnWhx
 nwws3rKUv9bXdPlNi3r1fxrgCioJ+7Y07i3hCQEr3k19NEbzQV2ZHOWne3oLpnBKLFufnK
 diamOmLQRz6CXI7JsT34ARkqPpjPCmc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-CxIMODDOPB-7cHAyoDgw2w-1; Thu, 09 Dec 2021 00:36:23 -0500
X-MC-Unique: CxIMODDOPB-7cHAyoDgw2w-1
Received: by mail-lj1-f198.google.com with SMTP id
 t25-20020a2e8e79000000b0021b5c659213so1358230ljk.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 08 Dec 2021 21:36:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SRZ1W63RG1+PMAbUJRWG6p7YfzpPpROIJSWzaVccpAc=;
 b=HBpWlgZSWoSG4dPn22fPgwdA8scLtBx/rhuH2mJNCjlgGjA/ImxDpTnjG2IZGgqbEl
 3i2xpfi2jioSNC0/MYYPC3Yxjpwfl/sz3V8BbsDtQX8JVHFJTaPdYkQORa0xYMV9bh0o
 7CUILkluZqJjd1IGaL2If7esVHuYUF8PI+rnpwTUMKWb9un8M2ilSQu4dd6NmC87v0/8
 9UQSQnJemegeBFeNjf9KfKd2v2u2iPOvZWoS2BhMRZkwamo03h8Upa9U66B9zCsnJSkU
 PunRl/SFntwSf0N47KdxXsGTXynHZSBZMjUAwgR8idhUHnGvSiNbW9dIxWd/a3tEYJx4
 ekYA==
X-Gm-Message-State: AOAM532njueT2dV9z5UBhw2nGbLOlmoJpPP2NhKk12X0GiYWY84/nZHQ
 v+7NpXnyc22TzrV/qmc63L/TxDLMAJe3hppzluxu91aI+qzZbE36VzqSSclRZXdbs6gFZYiuB0u
 qUyTkqQt+GYv8GlNkGJ4xMj/HcpLbB7MyOiW8q2O7Q/rZFu/Y3xUlpATDyg==
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr621971lfm.580.1639028181336;
 Wed, 08 Dec 2021 21:36:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw7QDHxMNBV+JNN/PLRQsB0cTi74Wc8pRkKPwbk0PEQCd/dHZJh6Bo1bGF/HXJVLes0VQ5gJiYWIGDz/U7BlFI=
X-Received: by 2002:ac2:50c6:: with SMTP id h6mr621948lfm.580.1639028181135;
 Wed, 08 Dec 2021 21:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20211208201430.73720-1-elic@nvidia.com>
 <20211208201430.73720-4-elic@nvidia.com>
 <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
In-Reply-To: <5a9d9d83-fbe2-000a-9084-456c2a0ac094@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 9 Dec 2021 13:36:10 +0800
Message-ID: <CACGkMEs2jydoBY8xLqNy_Uvurxft7rGzPon542Gup9DDuAyE=Q@mail.gmail.com>
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

On Thu, Dec 9, 2021 at 8:25 AM Si-Wei Liu <si-wei.liu@oracle.com> wrote:
>
>
>
> On 12/8/2021 12:14 PM, Eli Cohen wrote:
> > Add netlink support to configure the max virtqueue pairs for a device.
> > At least one pair is required. The maximum is dictated by the device.
> >
> > Example:
> >
> > $ vdpa dev add name vdpa-a mgmtdev auxiliary/mlx5_core.sf.1 max_vqp 5
> Not this patch, but I think there should be a mega attribute defined
> ahead to specify the virtio class/type to create vdpa instance with.
> Like the existing ones e.g. mac_addr and mtu, max_vqp is also vdpa net
> specific attribute.

Probably, but this only works for the case when a single parent is
allowed to create different types of devices. It looks to me the
current model to have a per type parent.

Thanks

>
> -Siwei
>
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 -> v1:
> > 1. fix typo
> > 2. move max_vq_pairs to net specific struct
> >
> >   drivers/vdpa/vdpa.c  | 14 +++++++++++++-
> >   include/linux/vdpa.h |  1 +
> >   2 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index c37d384c0f33..3bf016e03512 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -480,7 +480,8 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> >   }
> >
> >   #define VDPA_DEV_NET_ATTRS_MASK ((1 << VDPA_ATTR_DEV_NET_CFG_MACADDR) | \
> > -                              (1 << VDPA_ATTR_DEV_NET_CFG_MTU))
> > +                              (1 << VDPA_ATTR_DEV_NET_CFG_MTU) | \
> > +                              (1 << VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> >
> >   static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> >   {
> > @@ -506,6 +507,17 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> >                       nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MTU]);
> >               config.mask |= (1 << VDPA_ATTR_DEV_NET_CFG_MTU);
> >       }
> > +     if (nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]) {
> > +             config.net.max_vq_pairs =
> > +                     nla_get_u16(nl_attrs[VDPA_ATTR_DEV_NET_CFG_MAX_VQP]);
> > +             if (!config.net.max_vq_pairs) {
> > +                     NL_SET_ERR_MSG_MOD(info->extack,
> > +                                        "At least one pair of VQs is required");
> > +                     err = -EINVAL;
> > +                     goto err;
> > +             }
> > +             config.mask |= BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP);
> > +     }
> >
> >       /* Skip checking capability if user didn't prefer to configure any
> >        * device networking attributes. It is likely that user might have used
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index db24317d61b6..b62032573780 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -99,6 +99,7 @@ struct vdpa_dev_set_config {
> >       struct {
> >               u8 mac[ETH_ALEN];
> >               u16 mtu;
> > +             u16 max_vq_pairs;
> >       } net;
> >       u64 mask;
> >   };
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
