Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1283C433EF
	for <virtualization@archiver.kernel.org>; Wed, 11 May 2022 10:19:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 907C08349A;
	Wed, 11 May 2022 10:19:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s7b7i7y4A81Z; Wed, 11 May 2022 10:19:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1CE9883495;
	Wed, 11 May 2022 10:19:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02DAFC0039;
	Wed, 11 May 2022 10:19:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC38FC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CCF8D83498
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:19:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dHNM2H1RQcG7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:19:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 06DBB83495
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652264341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k9TokjqGxY4QglqVSG22lCcz992Q8/mhNfdXjbidjQY=;
 b=KV2ItWcui5J0evCZHbZJpOcgIGuNgT/hu6NwAFZt4ScjKSm7isYxY53nH7rgxoBaO/a5nb
 016d84iNFqpdwKX3aO1I24Q8dRx+CUs55YrYbamhZ24H40DpF0T0BQYO9wKz8QsZ0z1FAg
 CvrLi8nhVWZ0W46+sgaVjefY2iorAqw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-q6pwDzdjODKP5X8L9IVj1w-1; Wed, 11 May 2022 06:19:00 -0400
X-MC-Unique: q6pwDzdjODKP5X8L9IVj1w-1
Received: by mail-lf1-f69.google.com with SMTP id
 h34-20020a0565123ca200b00473e2754d00so639919lfv.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 May 2022 03:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k9TokjqGxY4QglqVSG22lCcz992Q8/mhNfdXjbidjQY=;
 b=cCzVlxZvyamYQPZ4gQQ5Etnf07wfkuKmFTCUYXEM4iRbDYIc8mmAc9DkEVx7/6roKS
 j6WjqxQplnpl+3Fo4Qs69v39tBOIdm0Ajg40hDeS9gPVvf05+sRer/JreCBe+nDxJzHB
 rq5h7Ff6o9a1olndc1csK9FKRS9M8dj2LFJ6+RSXTpeXgrZowXABPYy21MtgimPoufY1
 owYNbUfol7l6OYCMCoOM5aKrtxQJcHaips+3tIF/X+++ojSztuXpTwKprzAiJofGFo4U
 9SzCTl2UkZzt64lF/oTmvNYH0WJn60HWNqefrZOrmIB3mi1hUMWvHwfBZiLyta+cninX
 idUg==
X-Gm-Message-State: AOAM533qwiXTgBOBrXoyErcs9XrKIYlbCVNR80RWrrWH6ePR/1g5rwmI
 cb2hI30Dr0ltgtp9QqaaeNbI6HjTwk+NifBe0FoQ369/O9M23To9URU9yfo+1lu1bgbQdpYAkrP
 W6w1B98N5i8UPzFZqblNYtH6vARo+x7RQxeUUBUAYaru9yFwxWXE0igvAGw==
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr19246464lfj.587.1652264338815; 
 Wed, 11 May 2022 03:18:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpTOzDD2FjkHJo7T/BkCX3Znv1KFmNfUN5fbbXVEW4lzoNdcuck5WMwc/riTdg+4v9YGqWsKE8nVG1ZhNoKRw=
X-Received: by 2002:a19:ca50:0:b0:471:f556:92b with SMTP id
 h16-20020a19ca50000000b00471f556092bmr19246452lfj.587.1652264338607; Wed, 11
 May 2022 03:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220511084804.82482-1-elic@nvidia.com>
 <CACGkMEt9h=hGH9cGj=NNLrGtvg2PguS8-pe4trxNUQOxmTRsog@mail.gmail.com>
 <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB5400BC33A5ABD2FCBD0CA852ABC89@DM8PR12MB5400.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 11 May 2022 18:18:47 +0800
Message-ID: <CACGkMEvTTyT=RFp3aAL+8XcL229Fw=pW9_7zNntrUViriUHuNw@mail.gmail.com>
Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
To: Eli Cohen <elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Si-Wei Liu <si-wei.liu@oracle.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, mst <mst@redhat.com>
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

On Wed, May 11, 2022 at 6:02 PM Eli Cohen <elic@nvidia.com> wrote:
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, May 11, 2022 12:34 PM
> > To: Eli Cohen <elic@nvidia.com>
> > Cc: mst <mst@redhat.com>; virtualization <virtualization@lists.linux-foundation.org>; linux-kernel <linux-kernel@vger.kernel.org>; Si-
> > Wei Liu <si-wei.liu@oracle.com>
> > Subject: Re: [PATCH] vdpa: Warn if MTU configured is too low
> >
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
> It's definitely not a must but I thought if the spec says "should" it deserves a warning

Right.

> but we can drop this if you think the warning is not in place.

I remember netlink has an extra log buffer, I wonder if it's better to
warn there?

>
> >
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
>
> I don't think so. If it equals 1280 you don't want to warn.

Yes, you're right.

Thanks

>
> >
> > Thanks
> >
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
