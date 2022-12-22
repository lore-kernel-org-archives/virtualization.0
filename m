Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE0FC4332F
	for <virtualization@archiver.kernel.org>; Thu, 22 Dec 2022 08:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D02F417D3;
	Thu, 22 Dec 2022 08:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D02F417D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PWHG8huA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KcPsIRQ8S7z1; Thu, 22 Dec 2022 08:49:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4E700417BD;
	Thu, 22 Dec 2022 08:49:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E700417BD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E7DCC0071;
	Thu, 22 Dec 2022 08:49:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B23BC0070
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7A152417BD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:49:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7A152417BD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5QXAbXDz8wXK
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:49:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71DB1417D1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 71DB1417D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671698945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24SjBaC5+R1bpPX2KbnsN80A77tDgarL7SjF1z9c+4g=;
 b=PWHG8huAoQxObSVz5YI6FP0FG08MkNxUP6iP1iLjmXJmtjNcrrVb9YdWAWvumXe+1lcTzn
 tmJrBe6Ts6UntayfBj3CwlDxdAPwRVTGd9hKLKuTiLq89GQj79Kge3wAY5Bx4WP4yuSjiK
 IdbrhJ6ulwWmKFwgJ92P8XAr1QvtzdY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-650-_cAVz8quMpSM_1DfniG6gQ-1; Thu, 22 Dec 2022 03:49:03 -0500
X-MC-Unique: _cAVz8quMpSM_1DfniG6gQ-1
Received: by mail-oi1-f198.google.com with SMTP id
 bi37-20020a05680818a500b0035ea4ea8db5so248897oib.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Dec 2022 00:49:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24SjBaC5+R1bpPX2KbnsN80A77tDgarL7SjF1z9c+4g=;
 b=7kcN1E+JnxgRWEzpT4pB9DQ8m2ZHb7OwLwjdebVDOulXi/FoKJf0htbgt4Lhbl/WEn
 V5p9Ub0/1s1EaGw1FKFrnwBQdaQXCAHW7lIVhtsk7f6FsEHsw/6KDM/c/1CT/vly0C0v
 adKyUXowG5hiivkESZHt0XFgt7eWCYf4LPiU0t1g5+qwLobk8YMNbghKVRUkfgb6XHoK
 W/ZQgWAr8A65EQZEanOlI8aA/6zUPrM2Jm1R8a+nLTDkrEfdWY6sfg5DpylSc0684AGo
 8aImnnwjirkUIJAv8cdUFxKQvNrN1b7fO43d7Dty9sSs5YQ1qlWd/HAjCorln4IaftOp
 dp4A==
X-Gm-Message-State: AFqh2kq85C4Jr7tJZWkhmwFPoZIeRm6z7B7xDaeiryGKXq7QU9lSaljo
 xZJqGOpmX6Zq1UjhJKhKzEKaaLGguknk/lFAOqgpvl5gNYBMOQW3cPGZSSaTweuG9NnFe2MVel9
 319S7Ab3+RCFAwTuoaIWhHxukB9DnLtCXKohsCQZJilMGjJwFkdZdaI+5mA==
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr304633otm.237.1671698943041; 
 Thu, 22 Dec 2022 00:49:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt0H5B2HRjAEKwQUonOjILxfVzsdchrDFOD71wfmyaYt+sSyUF6J4vJ1zUzneqGhd1C8v/KJpc7Wod7GEWcGCI=
X-Received: by 2002:a9d:7843:0:b0:678:1eb4:3406 with SMTP id
 c3-20020a9d7843000000b006781eb43406mr304627otm.237.1671698942833; Thu, 22 Dec
 2022 00:49:02 -0800 (PST)
MIME-Version: 1.0
References: <20221222050052.20785-1-jasowang@redhat.com>
 <20221222050052.20785-3-jasowang@redhat.com>
 <CAJaqyWemV8aC=MRsu_h-WuRw8bquMZnBPNGONaJ6Nz_sGNWxCg@mail.gmail.com>
In-Reply-To: <CAJaqyWemV8aC=MRsu_h-WuRw8bquMZnBPNGONaJ6Nz_sGNWxCg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 22 Dec 2022 16:48:51 +0800
Message-ID: <CACGkMEt-VHmKVkwH=KzFuzUsg0AkT_0zLPnTfMrmR2cu2qvrcw@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] vdpasim: customize allocation size
To: Eugenio Perez Martin <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 mst@redhat.com
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

On Thu, Dec 22, 2022 at 4:22 PM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Thu, Dec 22, 2022 at 6:01 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > Allow individual simulator to customize the allocation size.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/vdpa/vdpa_sim/vdpa_sim.c     | 8 ++++++--
> >  drivers/vdpa/vdpa_sim/vdpa_sim.h     | 1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 1 +
> >  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 1 +
> >  4 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > index 757afef86ba0..55aaa023a6e2 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> > @@ -253,7 +253,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         struct vdpa_device *vdpa;
> >         struct vdpasim *vdpasim;
> >         struct device *dev;
> > -       int i, ret = -ENOMEM;
> > +       int i, ret = -EINVAL;
> > +
> > +       if (!dev_attr->alloc_size)
> > +               goto err_alloc;
>
> It's weird that we need an error goto here and the next chunk of code
> may return ERR_PTR(-EINVAL) directly. It's better to return directly
> here in my opinion.

Right, let me fix it.

>
> >
> >         if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
> >                 if (config->device_features &
> > @@ -268,9 +271,10 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr,
> >         else
> >                 ops = &vdpasim_config_ops;
> >
> > +       ret = -ENOMEM;
>
> Nitpicking again,
>
> To set ret = -ENOMEM here is weird to me, since the next failure on
> __vdpa_alloc_device will override it. I'd set it right before
> dma_set_mask_and_coherent, closer to its actual usage.

Yes.

>
> Actually, I'd propagate dma_set_mask_and_coherent error and set ret =
> -ENOMEM right before *alloc functions, but it wasn't done that way
> before this series, so not a reason to NAK to me.

Yes and I think this needs a separate fix.

Thanks

>
> Thanks!
>
> >         vdpa = __vdpa_alloc_device(NULL, ops,
> >                                    dev_attr->ngroups, dev_attr->nas,
> > -                                  sizeof(struct vdpasim),
> > +                                  dev_attr->alloc_size,
> >                                    dev_attr->name, false);
> >         if (IS_ERR(vdpa)) {
> >                 ret = PTR_ERR(vdpa);
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > index 0e78737dcc16..51c070a543f1 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> > @@ -37,6 +37,7 @@ struct vdpasim_dev_attr {
> >         struct vdpa_mgmt_dev *mgmt_dev;
> >         const char *name;
> >         u64 supported_features;
> > +       size_t alloc_size;
> >         size_t config_size;
> >         size_t buffer_size;
> >         int nvqs;
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > index c6db1a1baf76..4f7c35f59aa5 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> > @@ -378,6 +378,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >         dev_attr.nvqs = VDPASIM_BLK_VQ_NUM;
> >         dev_attr.ngroups = VDPASIM_BLK_GROUP_NUM;
> >         dev_attr.nas = VDPASIM_BLK_AS_NUM;
> > +       dev_attr.alloc_size = sizeof(struct vdpasim);
> >         dev_attr.config_size = sizeof(struct virtio_blk_config);
> >         dev_attr.get_config = vdpasim_blk_get_config;
> >         dev_attr.work_fn = vdpasim_blk_work;
> > diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > index c3cb225ea469..20cd5cdff919 100644
> > --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> > @@ -249,6 +249,7 @@ static int vdpasim_net_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
> >         dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
> >         dev_attr.ngroups = VDPASIM_NET_GROUP_NUM;
> >         dev_attr.nas = VDPASIM_NET_AS_NUM;
> > +       dev_attr.alloc_size = sizeof(struct vdpasim);
> >         dev_attr.config_size = sizeof(struct virtio_net_config);
> >         dev_attr.get_config = vdpasim_net_get_config;
> >         dev_attr.work_fn = vdpasim_net_work;
> > --
> > 2.25.1
> >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
