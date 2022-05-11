Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FCEDC433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 10:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D84DD81ABB;
	Wed, 11 May 2022 10:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HenETyFkAknu; Wed, 11 May 2022 10:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C13581754;
	Wed, 11 May 2022 10:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DEA9C0039;
	Wed, 11 May 2022 10:17:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BA9BC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B206610B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wngCkSPRtbAX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:17:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AD45C610B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652264265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wx81tlJYzO9I2LSOtYxQuG9pIbqu4YEcCflIBnljDbw=;
 b=SnstTz6Zhcwq+hfATfWNwlRHnBLKo8gJA2RSVPGcSC2ry1LYNVtSwtzZDCjWzgEltkJigE
 Hxrzix6CRkTvHir3oLVRMx/S4WCs/j3TsOo7M2XoIz7ezF9dFHMWy4wxCGN8zIkiA697dR
 08JlHSH8ZBT8feft6rK6TbHnqEgpQT4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-GFFUcuuPMnCbSgIAnUTG9g-1; Wed, 11 May 2022 06:17:42 -0400
X-MC-Unique: GFFUcuuPMnCbSgIAnUTG9g-1
Received: by mail-lj1-f198.google.com with SMTP id
 y7-20020a2e95c7000000b0024f29bcd594so566344ljh.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 03:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Wx81tlJYzO9I2LSOtYxQuG9pIbqu4YEcCflIBnljDbw=;
 b=e2u4/Fh2nABBbCRsi5YOlBHtoPfUUS2KMZ/laxKNrwZbc/nRtkcacG4sGdsHhubTGe
 fe0EJckVXSzHUfIqXCRrKyoAJ3RmaMYzaX66OkVv1PhcOgqU0MTMKD3dyQYUMZgn6Wnj
 jy2f82LIDiLCpM0cWS+n5FthZjw1JmttUSIRCqCkANazo4YwnX84Kb1B3qYTu10XBkjh
 /Df9rlavRMLWf1fMm8dPsi4Nn7nmNEJbPzEVaRklr95TqQ0sv1sfXIM/OwRzfSBSgwfZ
 GbDlKbJ6D89smB82YyjeENu2T0FIaeDPxDzr5gBzklSRvPX+6Y1WK5HJoqW9qx79p1Bs
 Abfg==
X-Gm-Message-State: AOAM533o8NhB8TSWrwHYqPd8EDQDWyfZn43Ikc0gBeVXP2hcn4l/bqvp
 wKT1w1f4mFyLh9VlB4m6Hke3IS62cMqR6iSFVzi5nfPCj++ixsnH6kU2apBrnw8FC7ej/r6KJma
 Iw/0V8wGq2kCIAWYO57dccYrqNsAcZew8yF651gJyfSu83PX0LWYZbNtIqQ==
X-Received: by 2002:ac2:5f7c:0:b0:472:631e:b443 with SMTP id
 c28-20020ac25f7c000000b00472631eb443mr19249474lfc.376.1652264260957; 
 Wed, 11 May 2022 03:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6s5PADUFZu+j8/vnDQxLW0vNWCpzuS5F6JenYeIUvoxG4H/afD3ZPXC+On/SOMZTz+51G8oW9BWXkBH3Kazk=
X-Received: by 2002:ac2:5f7c:0:b0:472:631e:b443 with SMTP id
 c28-20020ac25f7c000000b00472631eb443mr19249463lfc.376.1652264260762; Wed, 11
 May 2022 03:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
 <20220511055517-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220511055517-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 18:17:29 +0800
Message-ID: <CACGkMEsDOCnQCxDf=8orCxx+38JgdmYZDUVAnUvbSg-af7wEQQ@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

On Wed, May 11, 2022 at 5:59 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, May 11, 2022 at 05:34:25PM +0800, Jason Wang wrote:
> > On Wed, May 11, 2022 at 4:48 PM Eli Cohen <elic@nvidia.com> wrote:
> > >
> > > Following the recommendation in virio spec 1.1, a device offering
> > > VIRTIO_NET_F_MTU should set the mtu to at least 1280 bytes.
> > >
> > > Print a warning if this recommendation is not met.
> > >
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> >
> > I wonder why it's a must?
>
>
> It's a SHOULD in the spec.  I guess 1280 is to allow IPv6.

Right, I see this.

Thanks

>
> > > ---
> > >  drivers/vdpa/vdpa.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index 91f4c13c7c7c..961168fe9094 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -583,6 +583,9 @@ vdpa_nl_cmd_mgmtdev_get_dumpit(struct sk_buff *msg, struct netlink_callback *cb)
> > >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU)     | \
> > >                                  BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MAX_VQP))
> > >
> > > +/* Recommended virtio spec 1.1 section 5.1.4.1 */
> > > +#define VIRTIO_MIN_PREFERRED_MTU 1280
> > > +
> > >  static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *info)
> > >  {
> > >         struct vdpa_dev_set_config config = {};
> > > @@ -634,6 +637,10 @@ static int vdpa_nl_cmd_dev_add_set_doit(struct sk_buff *skb, struct genl_info *i
> > >                 err = PTR_ERR(mdev);
> > >                 goto err;
> > >         }
> > > +       if ((mdev->supported_features & BIT_ULL(VIRTIO_NET_F_MTU)) &&
> > > +           (config.mask & BIT_ULL(VDPA_ATTR_DEV_NET_CFG_MTU) &&
> > > +           config.net.mtu < VIRTIO_MIN_PREFERRED_MTU))
> >
> > Should be <= ?
> >
> > Thanks
>
>
>
> > > +               pr_warn("MTU is below recommended value\n");
> > >         if ((config.mask & mdev->config_attr_mask) != config.mask) {
> > >                 NL_SET_ERR_MSG_MOD(info->extack,
> > >                                    "All provided attributes are not supported");
> > > @@ -1135,7 +1142,7 @@ static const struct nla_policy vdpa_nl_policy[VDPA_ATTR_MAX + 1] = {
> > >         [VDPA_ATTR_DEV_NAME] = { .type = NLA_STRING },
> > >         [VDPA_ATTR_DEV_NET_CFG_MACADDR] = NLA_POLICY_ETH_ADDR,
> > >         /* virtio spec 1.1 section 5.1.4.1 for valid MTU range */
> > > -       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, 68),
> > > +       [VDPA_ATTR_DEV_NET_CFG_MTU] = NLA_POLICY_MIN(NLA_U16, ETH_MIN_MTU),
> > >  };
> > >
> > >  static const struct genl_ops vdpa_nl_ops[] = {
> > > --
> > > 2.35.1
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
