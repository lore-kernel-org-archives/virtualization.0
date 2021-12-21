Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505CC433F5
	for <virtualization@archiver.kernel.org>; Tue, 21 Dec 2021 07:55:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA2538267F;
	Tue, 21 Dec 2021 07:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qRA4H0bfgtX2; Tue, 21 Dec 2021 07:55:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5512B82656;
	Tue, 21 Dec 2021 07:55:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27F19C002F;
	Tue, 21 Dec 2021 07:55:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D02DBC0012
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AB78E40947
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:55:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4euEc_i5344Q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:55:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 033AB40943
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Dec 2021 07:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1640073334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ApmCvPYCpf5GVu6W9kpJepfbAA6YvsjFHXVtEDvxb8=;
 b=T9BxOTN8+ktoIMj2BPL+cW/J8L0xsiGNEV/kC3OPAbJj51J1NgmL+r8DjnuYIfOqc/9N5x
 xUU3PfwQPD2gVDMyuFG8fmaQkzMeF22T6Z9J091uM7tpAjHBAnlPhLn1ioQpQRJQe1vib1
 4MXKrq8+tG14LJ3i/suJNVdEUn+TNHU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-bnRA4F5pMSqxlLvtqi5s3A-1; Tue, 21 Dec 2021 02:55:33 -0500
X-MC-Unique: bnRA4F5pMSqxlLvtqi5s3A-1
Received: by mail-lj1-f199.google.com with SMTP id
 b14-20020a05651c0b0e00b0021a1a39c481so1965904ljr.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Dec 2021 23:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3ApmCvPYCpf5GVu6W9kpJepfbAA6YvsjFHXVtEDvxb8=;
 b=BMFvOjN5/6nVDqnAGi8qUBUPZX8FdZ5g6zodnkDkgpwYq/2UKSPYUv7eUYnCYzW2bR
 94ytOkYeB/ULYB18L4rToU+oc8O9XyXXCkDPuxX5tYlNOqvNurhSR5HenG/L1cxsesUV
 e0ON2MPuQb2Yke/3aokZGoSDJtMvXO/OAJpKrK09t39NNtlGKplJDVj2meH57RbX8saJ
 oCm6V2GbJzzRdDMzP8wJDcGahZusBFe91uZMJthCT2hKhMo2cqC9brCFGUSduMfS6c+q
 neANemhaNY6/P0d0QQBv/r9W7IbrLKlUVNEfeacwHEd0vsDfg7qN1zuwkkqsGdkpfi4R
 6kIw==
X-Gm-Message-State: AOAM532S8CdQO1ykUrtH6i4Grjz5R2em4IfckhYLlvKD75WejbyoJwjE
 uNaJpBGVCH4D3jcY3qDwWKWg6vpu8Ftl7wbvowMXZ2xG3DGd7glScxVCcDPEd6SchT9Pupp0M6R
 z2GE6iGTsDRXfTPZeu53rXCHUUNb6dHA50WDm+3YnZbbli8FkJyMKjqRD3A==
X-Received: by 2002:a05:6512:1095:: with SMTP id
 j21mr2013186lfg.629.1640073331468; 
 Mon, 20 Dec 2021 23:55:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQQ4trZmDvXyUb8g3jpPkIfUUc+pDps63+kxwekSrqtLN6/6U1SVNIBS3Ll42rvscNuQIEZjkSOlXueiQTVms=
X-Received: by 2002:a05:6512:1095:: with SMTP id
 j21mr2013169lfg.629.1640073331274; 
 Mon, 20 Dec 2021 23:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20211219140236.27479-1-elic@nvidia.com>
 <20211219140236.27479-8-elic@nvidia.com>
 <CACGkMEtBqBo_AF-yxQ=TkF3Nt6uWWBKDtLEUVmjRdrzn-e7DzA@mail.gmail.com>
 <20211221062032.GB165503@mtl-vdi-166.wap.labs.mlnx>
 <20211221070435.GE165503@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20211221070435.GE165503@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 21 Dec 2021 15:55:20 +0800
Message-ID: <CACGkMEuV-kQoucF1mugwapbWbjo_ni1K8xJE8moJf9oKv_83JQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/10] vdpa: Add support for returning device
 configuration information
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

On Tue, Dec 21, 2021 at 3:04 PM Eli Cohen <elic@nvidia.com> wrote:
>
> On Tue, Dec 21, 2021 at 08:20:32AM +0200, Eli Cohen wrote:
> > On Tue, Dec 21, 2021 at 01:57:54PM +0800, Jason Wang wrote:
> > > On Sun, Dec 19, 2021 at 10:03 PM Eli Cohen <elic@nvidia.com> wrote:
> > > >
> > > > Add netlink attribute to store the negotiated features. This can be used
> > > > by userspace to get the current state of the vdpa instance.
> > > >
> > > > Example:
> > > > $ vdpa dev config show vdpa-a
> > > > vdpa-a: mac 00:00:00:00:88:88 link up link_announce false max_vq_pairs
> > > > 16 mtu 1500 features c3182bc3182b
> > > > CSUM GUEST_CSUM MTU MAC HOST_TSO4 HOST_TSO6 STATUS VERSION_1 \
> > > > ACCESS_PLATFORM
> > > >
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > >
> > > > ----
> > > > V2 -> V3
> > > > 1. Move attribute definition to end of enum definition
> > > > 2. Return the entire negotiated features bit mask
> > > > ---
> > > >  drivers/vdpa/vdpa.c       | 3 +++
> > > >  include/uapi/linux/vdpa.h | 4 ++++
> > > >  2 files changed, 7 insertions(+)
> > > >
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index 83730713c7d0..64b2ab60e0bb 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -820,6 +820,9 @@ static int vdpa_dev_net_config_fill(struct vdpa_device *vdev, struct sk_buff *ms
> > > >                 return -EMSGSIZE;
> > > >
> > > >         features = vdev->config->get_driver_features(vdev);
> > > > +       if (nla_put_u64_64bit(msg, VDPA_ATTR_DEV_NEGOTIATED_FEATURES, features,
> > > > +                             VDPA_ATTR_PAD))
> > > > +               return -EMSGSIZE;
> > > >
> > > >         return vdpa_dev_net_mq_config_fill(vdev, msg, features, &config);
> > > >  }
> > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > index a252f06f9dfd..db3738ef3beb 100644
> > > > --- a/include/uapi/linux/vdpa.h
> > > > +++ b/include/uapi/linux/vdpa.h
> > > > @@ -23,6 +23,9 @@ enum vdpa_command {
> > > >  enum vdpa_attr {
> > > >         VDPA_ATTR_UNSPEC,
> > > >
> > > > +       /* Pad attribute for 64b alignment */
> > > > +       VDPA_ATTR_PAD = VDPA_ATTR_UNSPEC,
> > > > +
> > >
> > > I may miss something, but will this lead to a change in the existing ABI?
> > >
> >
> > You're right.
> > I think it can be moved to the end of the enum
>
> Actuall, it's OK. It does not change the other enum values and it can't
> be moved to the end because it will corrupt the enumeration of
> VDPA_ATTR_MAX

Right.

Acked-by: Jason Wang <jasowang@redhat.com>

> >
> > > Thanks
> > >
> > > >         /* bus name (optional) + dev name together make the parent device handle */
> > > >         VDPA_ATTR_MGMTDEV_BUS_NAME,             /* string */
> > > >         VDPA_ATTR_MGMTDEV_DEV_NAME,             /* string */
> > > > @@ -40,6 +43,7 @@ enum vdpa_attr {
> > > >         VDPA_ATTR_DEV_NET_CFG_MAX_VQP,          /* u16 */
> > > >         VDPA_ATTR_DEV_NET_CFG_MTU,              /* u16 */
> > > >
> > > > +       VDPA_ATTR_DEV_NEGOTIATED_FEATURES,      /* u64 */
> > > >         /* new attributes must be added above here */
> > > >         VDPA_ATTR_MAX,
> > > >  };
> > > > --
> > > > 2.34.1
> > > >
> > >
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
