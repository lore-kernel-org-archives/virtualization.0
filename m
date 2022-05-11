Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE93C433F5
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 09:59:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CB1A418A4;
	Wed, 11 May 2022 09:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N_MBlcjZrg_J; Wed, 11 May 2022 09:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id CB408403A7;
	Wed, 11 May 2022 09:59:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88D8BC0032;
	Wed, 11 May 2022 09:59:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 196ECC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:59:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 16CFC8338B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nDSYKMXHjJo7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 57AF083386
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652263139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+FfW+5+mV9G3R406B7MYW3KSbtguNpvUzxhTqvODpUM=;
 b=i7AHL28yZF42FbP5jnp01na4mlG8ncfR/3/BLM6D+evLqZX/l8i5w7nu0xchZ/dH/j+SbE
 xgApDytTVi7I/h+1cGJ2xWrZErWvNTZYqVJzzVva6bHaBWq/DeyAk+uKBlxMQkt++przm+
 cg9v8WvxoZyVqKkbohRwhKod1OHdoDs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-381-vgJd2b6YPDma-taZxIw3vw-1; Wed, 11 May 2022 05:58:56 -0400
X-MC-Unique: vgJd2b6YPDma-taZxIw3vw-1
Received: by mail-wm1-f72.google.com with SMTP id
 bi5-20020a05600c3d8500b0039489e1d18dso2604847wmb.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 02:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+FfW+5+mV9G3R406B7MYW3KSbtguNpvUzxhTqvODpUM=;
 b=YjDxNLPvsQzLN0BulauB7sRHkBxN8ob1MA83br6u/ln/HdSP+Qdr3IBXrIHQmX0udI
 k/6PE4FmZn46Uz/1nszbLO2eY/W2+vkddYXfSBR7RfWVhky+ffcumLbZj/ZUb5hnxg4g
 KgSwVNNd8HJz8ImCvhEAHJHDU+EGyIQvWwweqlgrDI3Og/dZpS2+jRH2/jtDaPmh5ooB
 NzaeP7aS0wRr6iRf3mdjzgJd4De/2y+5cMRxgPRYlXmRduXQIopAJq40EC77Cq271tcR
 geFDAzG4nahLRq99BriErZELXcOcgM5EhvPFhmnU1UPCU2DMrjwuJ7Z8kH8OjOOrKw4e
 dbEQ==
X-Gm-Message-State: AOAM531z2AvAhw14s4PugX7Atqae0yivxFkkbBkqQmHUX6gqmioxuT3k
 d7LFj0/WKfrrO9t6w6mVcr9pbrTkzdb+yPlyRlrmn+AMoDe0rkhlkq0HATxjLxeXFf/GzJvVTab
 jZfBrzhDB5mrJxwzGMEFO+Kqn30N/Syqj9VmwbO4j/w==
X-Received: by 2002:a5d:4252:0:b0:20c:6ffc:77b1 with SMTP id
 s18-20020a5d4252000000b0020c6ffc77b1mr21611674wrr.483.1652263134983; 
 Wed, 11 May 2022 02:58:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy4NKG8oWbkw7DrLO4G0kGqLd8SWY59yELzw8BfqPhBBDOczYpic50262Syt6xWWlxXlPvgQ==
X-Received: by 2002:a5d:4252:0:b0:20c:6ffc:77b1 with SMTP id
 s18-20020a5d4252000000b0020c6ffc77b1mr21611657wrr.483.1652263134635; 
 Wed, 11 May 2022 02:58:54 -0700 (PDT)
Received: from redhat.com ([2a10:8004:5a99:0:647:dca8:57e:1626])
 by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b003942a244f40sm5437292wms.25.2022.05.11.02.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 02:58:54 -0700 (PDT)
Date: Wed, 11 May 2022 05:58:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
Message-ID: <20220511055517-mutt-send-email-mst@kernel.org>
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, Eli Cohen <elic@nvidia.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

On Wed, May 11, 2022 at 05:34:25PM +0800, Jason Wang wrote:
> On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
> >
> > Following the recommendation in virio spec 1.1, a device offering
> > VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> >
> > Print a warning if this recommendation is not met.
> >
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> I wonder why it's a must?


It's a SHOULD in the spec.  I guess 1280 is to allow IPv6.

> > ---
> >  drivers/vdpa/vdpa.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > index 91f4c13c7c7c..961168fe9094 100644
> > --- a/drivers/vdpa/vdpa.c
> > +++ b/drivers/vdpa/vdpa.c
> > @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> >
> > +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> > +#define VIRTIO_MIN_PREFERRED_MTU 1280
> > +
> >  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> >  {
> >         struct vdpa_dev_set_config config = {};
> > @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> >                 err = PTR_ERR(mdev);
> >                 goto err;
> >         }
> > +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> > +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> > +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> 
> Should be <= ?
> 
> Thanks



> > +               pr_warn("MTU is below recommended value\n");
> >         if ((config.mask & mdev->config_attr_mask) != config.mask) {
> >                 NL_SET_ERR_MSG_MOD(info->extack,
> >                                    "All provided attributes are not supported");
> > @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> >         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> >         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> >         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
> >  };
> >
> >  static const struct genl_ops vdpa_nl_ops[] = {
> > --
> > 2.35.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
